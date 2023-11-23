FROM node:16

WORKDIR /app

RUN yarn config set registry https://registry.npmmirror.com
COPY package.json ./
RUN yarn

COPY .next public next.config.js ./

ENV HOST 0.0.0.0
EXPOSE 3000

CMD [ "yarn", "start" ]

# docker build --platform linux/amd64 -t registry.cn-hangzhou.aliyuncs.com/ktools/transform .