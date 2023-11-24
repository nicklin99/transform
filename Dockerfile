FROM node:16 as builder

WORKDIR /app

COPY package.json ./

RUN yarn config set registry https://registry.npmmirror.com

COPY . .

RUN yarn

RUN yarn build

RUN tar -czvf dist.tar.gz node_modules .next public next.config.js package.json

FROM node:16

WORKDIR /app

VOLUME /app

COPY --from=builder /app/dist.tar.gz ./

RUN tar -xzvf dist.tar.gz

RUN rm -rf dist.tar.gz

EXPOSE 3000

CMD [ "yarn", "start" ]