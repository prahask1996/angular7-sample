FROM node:8.9.4

RUN mkdir -p /app
WORKDIR /app
RUN npm install
COPY . /app
RUN npm run build --prod
# Stage 2
FROM nginx:1.17.1-alpine
COPY nginx.conf /etc/nginx/nginx.conf
COPY /dist/aston-villa-app /usr/share/nginx/html
