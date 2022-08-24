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

- Database

This project is shipped with MongoDB by default, you can change it to other SQL databases if you want.

- Puma

Puma config file is *config/puma.rb*, you can search 5100(default port) through the project to change the default port.

- Vite port

The default vite port for local development is *3036*, you can search it through the whole project if you want a modify.

- Add more entry files

Just change *vite.config.js* file under vite directory:

```javascript
....
build: {
    manifest: true,
    assetsDir: "packs/assets",
    rollupOptions: {
      input: [
        "./src/packs/app.jsx",
        "./src/packs/home/index.jsx",
        "./src/packs/other/new/entry/file.jsx", // add here
      ]
    }
  }
```

and then use the helper method in your view:

```ruby
<%= vite_include_tag "js", "other/new/entry/file.jsx" %>
```

we already create a demo with the *WelcomeController* and its view, you can follow it to see how it works.

> All your javascript entry files should be placed under **vite/src/packs** directory.

## Build & Deployment

- Build docker images

```shell
./docker-build.sh
```

and then, you can push the image to your registry server. You can change the image name if you want. you can also put the docker push command to the end of the *docker-build.sh* script to save some time.

- Apple M1 & M2

If you are building images at Apple silicon(M1, M2 etc.) for linux, you need to uncomment the line with **build_opts** in both **docker-build.sh** scripts.

- If you want to run docker image locally:

You can run with docker-compose.yml or use **docker run** directly:

```shell
docker run --rm -it -p 5100:5100 \
--env RAILS_SERVE_STATIC_FILES=true rails7vite:latest
```

you may need to adjust the environment variables by your needs.


## Roadmap

- Add a script to rename project, which will save some time after cloning this project and has a need to change the project name.
