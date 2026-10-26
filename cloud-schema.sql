-- Personal documents: only the authenticated owner can access each row.
create table if not exists public.linuc_documents (
  user_id uuid primary key references auth.users(id) on delete cascade,
  payload jsonb not null default '{"items":[]}'::jsonb,
  revision bigint not null default 0,
  updated_at timestamptz not null default now(),
  constraint valid_payload check (jsonb_typeof(payload->'items') = 'array'),
  constraint bounded_payload check (octet_length(payload::text) <= 25000000)
);
alter table public.linuc_documents enable row level security;
revoke all on public.linuc_documents from anon;
grant select, insert, update on public.linuc_documents to authenticated;
create policy "Owners read own document" on public.linuc_documents for select to authenticated using ((select auth.uid()) = user_id);
create policy "Owners insert own document" on public.linuc_documents for insert to authenticated with check ((select auth.uid()) = user_id);
create policy "Owners update own document" on public.linuc_documents for update to authenticated using ((select auth.uid()) = user_id) with check ((select auth.uid()) = user_id);
-- Atomic revision check prevents an older device from overwriting newer work.
create or replace function public.save_linuc_document(p_payload jsonb, p_revision bigint)
returns bigint language plpgsql security invoker set search_path = '' as $$
declare v_revision bigint;
begin
  if auth.uid() is null then raise exception 'AUTH_REQUIRED'; end if;
  insert into public.linuc_documents(user_id) values (auth.uid()) on conflict (user_id) do nothing;
  select revision into v_revision from public.linuc_documents where user_id = auth.uid() for update;
  if v_revision <> p_revision then raise exception 'REVISION_CONFLICT'; end if;
  update public.linuc_documents set payload = p_payload, revision = revision + 1, updated_at = now() where user_id = auth.uid() returning revision into v_revision;
  return v_revision;
end;
$$;
revoke all on function public.save_linuc_document(jsonb,bigint) from public, anon;
grant execute on function public.save_linuc_document(jsonb,bigint) to authenticated;
