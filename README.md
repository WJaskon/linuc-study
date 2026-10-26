# LinuC 个人学习工作台

纯静态网站，无安装依赖，无服务器，无 AI API 调用。支持学习笔记、错题、图片、搜索、自评复习、JSON 备份、ChatGPT 提示词和整理结果导入。

## 发布到 GitHub Pages

1. 登录 GitHub，新建一个公开仓库，例如 `linuc-study`。
2. 在仓库的 Add file → Upload files 中上传本文件夹中的 `index.html` 和 `README.md`，然后提交。index.html 必须在仓库根目录。
3. 打开 Settings → Pages。Build and deployment 选择 Deploy from a branch，分支选择 main，文件夹选择 / (root)，点击 Save。
4. 等待发布完成，Pages 页面会显示访问地址，通常为 `https://你的用户名.github.io/linuc-study/`。

不需要配置域名、数据库、密钥或收费 AI API。GitHub 服务政策以其最新官方说明为准。

## 使用

- 在“学习笔记”或“错题本”新增内容，保存文字或一张小于 2 MB 的图片。
- 在记录中点击“AI 整理 / 出题”，将生成的提示词复制给 ChatGPT。
- 核对返回内容后，将 JSON 粘贴到“备份与 AI 助手”导入。
- 在“练习与复习”先回忆再查看答案；自评后安排在 1、3 或 7 天之后复习。
- 学习数据只在当前浏览器 localStorage 中保存，不会同步到 GitHub。定期导出完整备份；换设备时导入。
- 不要将个人笔记、截图或备份上传到公开仓库。页面自身没有账号或密码保护；同一浏览器使用者可以查看本地资料。
- 浏览器存储有容量限制，建议以文字为主。存储满时网站会提示保存失败，不会显示成功。
- 不支持自动 OCR、PDF 提取、自动读取 ChatGPT 历史或自动 AI 出题。可把 PDF 内容复制为文字，或在 ChatGPT 中附上资料，再导入其结果。

直接双击 index.html 可体验页面，但推荐通过固定的 GitHub Pages 地址使用，以获得稳定的浏览器存储与剪贴板体验。不同地址的资料彼此隔离。
