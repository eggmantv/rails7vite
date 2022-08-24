# Rails 7 + Vite + React + Docker

这个项目是一个脚手架，可以帮助你轻松快速地创建自己的 Ruby on Rails 7 项目，并支持 Vite、React 和 Docker。

与 webpack 相比，Vite 是一个超级快速且易于使用的 **下一代前端工具**，了解更多 [vite](https://github.com/vitejs/vite)。

## 设置

你需要先安装 ruby​​ 3.x，你可以使用 [rbenv](https://github.com/rbenv/rbenv)，并确保你已经安装了最新版本的 nodejs 和 yarn。

克隆这个项目，然后运行：

```shell
bundle
cd vite
yarn
```

然后启动开发守护进程：

```shell
# 到项目根目录
./start_dev.sh # puma
./start_dev_vite.sh # vite
```

然后在浏览器中打开 http://localhost:5100。

## 开发

- 添加更多入口文件

Assets（javascript、css、图像等）在 vite 目录下，如果你想添加更多的 javascript 入口文件，只需更改 _vite.config.js_：

```javascript
....
build: {
    manifest: true,
    assetsDir: "packs/assets",
    rollupOptions: {
      input: [
        "./src/packs/app.jsx",
        "./src/packs/home/index.jsx",
        "./src/packs/other/new/entry/file.jsx", // 添加到这里
      ]
    }
  }
```

然后在你的视图中使用辅助方法：

```ruby
<%= vite_include_tag "js", "other/new/entry/file.jsx" %>
```

我们已经使用 _WelcomeController_ 及其视图创建了一个演示，你可以按照它来查看它是如何工作的。（还将向你展示如何使用 CSS 和图像）

> 你所有的 javascript 入口文件都应该放在 **vite/src/packs** 目录下。

- 数据库

本项目默认自带 MongoDB，如果需要，你可以将其更改为其他 SQL 数据库。

- Puma

Puma 配置文件为 _config/puma.rb_，可以通过搜索本项目 5100（默认端口）来更改默认端口。

- Vite 端口

本地开发的默认 vite 端口是 _3036_，如果需要修改可以在整个项目中搜索。

- master key

为方便起见，本项目提交了 _master.key_，不建议您自己的项目使用，请在克隆后重新生成 master.key，并从您的 git 仓库中忽略它：

```shell
rm -f config/master.key
rm -f config/credentials.yml.enc
EDITOR="vim" bin/rails credentials:edit # 只需保存，无需编辑
git rm --cached config/master.key
# 然后编辑 .gitignore 并将 master.key 添加到其中。
```

## 构建和部署

- 构建 docker 镜像

```shell
./docker-build.sh
```

然后，你可以将镜像推送到你的镜像服务器。如果需要，你可以更改镜像名称。你还可以将 docker push 命令放在 _docker-build.sh_ 脚本的末尾以节省一些时间。

- Apple M1 和 M2

如果你在 Apple 芯片（M1、M2 等）上为 linux 构建镜像，则需要在两个 **docker-build.sh** 脚本中取消注释带有 **build_opts** 的行。

- 如果要在本地运行 docker 镜像：

你可以使用 docker-compose.yml 运行或直接使用 **docker run** ：

```shell
docker run --rm -it -p 5100:5100 \
--env RAILS_SERVE_STATIC_FILES=true rails7vite:latest
```

你可能需要根据需要来调整环境变量。

## 路线图

- 添加一个脚本来重命名项目，这将在克隆此项目后节省一些时间，并且需要更改项目名称。
