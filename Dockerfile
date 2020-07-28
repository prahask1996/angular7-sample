# base image
FROM node:8.9.4

# set working directory
WORKDIR /app

# install and cache app dependencies
COPY . .
RUN npm install
RUN npm run build --prod

FROM nginx:1.13.3-alpine
RUN rm -rf /usr/share/nginx/html/*
COPY dist/ng7 /usr/share/nginx/html
