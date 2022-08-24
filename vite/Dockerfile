FROM node:16.2.0
ENV app /app/rails7vite-assets
WORKDIR $app
COPY package.json yarn.lock ./
RUN yarn
COPY . .
RUN yarn build
CMD ["bash"]
