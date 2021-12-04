FROM node:16-alpine AS builder
WORKDIR /src
COPY . .
RUN npm install
RUN npm run build:prod

FROM nginx:alpine AS site
COPY ./nginx/nginx.conf /etc/nginx/conf.d/default.conf
COPY ./index.html /usr/share/nginx/html/index.html
COPY ./robots.txt /usr/share/nginx/html/robots.txt
COPY --from=builder /src/app.css /usr/share/nginx/html/app.css
