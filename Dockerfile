# 参考: https://medium.com/@kyle_26541/how-to-build-a-docker-image-that-depends-on-a-gem-that-exists-in-a-private-github-repo-using-f88c319a7a41
# 

FROM ruby:3.1.0 as build_host
RUN apt-get update -qq && apt-get install -y git

RUN mkdir -p /app/rails7vite
WORKDIR /app/rails7vite
COPY Gemfile* ./
RUN gem install bundler
RUN bundle config set --local path '/app/bundle'
RUN bundle config set --local without 'development test'
RUN bundle install

# final
FROM ruby:3.1.0
RUN apt-get update -qq && apt-get install -y git rsync vim ntpdate build-essential nodejs imagemagick
# install yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qq && apt-get install -y yarn

ENV LANG C.UTF-8
ENV app /app/rails7vite
RUN mkdir -p $app
COPY --from=build_host /app/bundle /app/bundle
COPY --from=build_host /usr/local/bundle /usr/local/bundle

WORKDIR $app
ENV RAILS_ENV production
# COPY package.json yarn.lock ./
# RUN yarn
COPY . .
# RUN bundle exec rails assets:precompile -v

# vite assets
COPY --from=rails7vite-assets:latest /app/rails7vite-assets/dist ./public
RUN mv ./public/manifest.json ./public/packs

RUN mkdir -p tmp/pids
EXPOSE 5100
CMD ["bundle", "exec", "puma", "-e", "production", "-C", "config/puma.rb"]
