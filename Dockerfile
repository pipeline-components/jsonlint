FROM node:10.14-alpine
COPY app /app/
WORKDIR /app/
ENV PATH "$PATH:/app/node_modules/.bin/"
RUN apk --no-cache add parallel=20180622-r0
RUN yarn install --frozen-lockfile && yarn cache clean
