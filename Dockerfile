FROM node:16 as builder

WORKDIR /app

COPY package.json yarn.lock ./

RUN yarn config set registry https://registry.npmmirror.com

RUN yarn

COPY . .

RUN yarn build

FROM node:16

WORKDIR /app

COPY --from=builder /app/node_modules /app/.next /app/public app/next.config.js /app/package.json ./

ENV HOST 0.0.0.0
EXPOSE 3000

CMD [ "yarn", "start" ]

# docker build --platform linux/amd64 -t registry.cn-hangzhou.aliyuncs.com/ktools/transform .