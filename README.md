English | [简体中文](./README.zh-CN.md)

# Rails 7 + Vite + React + Docker

This project is a scaffold to help you easily and quickly to create your own Ruby on Rails 7 project with Vite, React and Docker support.

Comparing with webpack, Vite is a super fast and easy-to-use **Next Generation Frontend Tooling**, learn more [vite](https://github.com/vitejs/vite).

## Setup

You need to install ruby 3.x first, you can use [rbenv](https://github.com/rbenv/rbenv), and make sure you have latest version of nodejs and yarn installed already.

Clone this project, then run:

```shell
bundle
cd vite
yarn
```

Then start development daemons:

```shell
# go to project root
./start_dev.sh # puma
./start_dev_vite.sh # vite
```

then open http://localhost:5100 in your browser.

## Development

- Add more entry files

Assets(javascript, css, images, etc.) are under vite directory, if you want add more javascript entry files just change _vite.config.js_:

```javascript
....
build: {
    manifest: true,
    assetsDir: "packs/assets",
    rollupOptions: {
      input: [
        "./src/packs/app.jsx",
        "./src/packs/home/index.jsx",
        "./src/packs/other/new/entry/file.jsx", // new entry file here
      ]
    }
  }
```

and then use the helper method in your view:

```ruby
<%= vite_include_tag "js", "other/new/entry/file.jsx" %>
```

we already create a demo with the _WelcomeController_ and its view, you can follow it to see how it works. (which will also show you how to use CSS and images)

> All your javascript entry files should be placed under **vite/src/packs** directory.

- Database

This project is shipped with MongoDB by default, you can change it to other SQL databases if you want.

- Puma

Puma config file is _config/puma.rb_, you can search 5100(default port) through the project to change the default port.

- Vite port

The default vite port for local development is _3036_, you can search it through the whole project if you want a modify.

- master key

For convenient, this project commited the _master.key_, which is not recommended for your own project, please re-generate the master.key after cloned and ignore it from your git repository:

```shell
rm -f config/master.key
rm -f config/credentials.yml.enc
EDITOR="vim" bin/rails credentials:edit # just save, no need editing
git rm --cached config/master.key
# then edit .gitignore and add the master.key to it.
```

## Build & Deployment

- Build docker images

```shell
./docker-build.sh
```

and then, you can push the image to your registry server. You can change the image name if you want. you can also put the docker push command to the end of the _docker-build.sh_ script to save some time.

- Apple M1 & M2

If you are building images at Apple silicon(M1, M2 etc.) for linux, you need to uncomment the line with **build_opts** in both **docker-build.sh** scripts.

- If you want to run docker image locally:

You can run with docker-compose.yml or use **docker run** directly:

```shell
docker run --rm -it -p 5100:5100 \
--env RAILS_SERVE_STATIC_FILES=true rails7vite:latest
```

you may need to adjust the environment variables by your needs.

## Follow us

For more turorials and dev videos, you can follow us here [重力不足](https://space.bilibili.com/25990460)，cheers:)
