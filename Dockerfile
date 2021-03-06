FROM node:8.9.4-alpine AS builder
RUN mkdir -p /app
WORKDIR /app
COPY package.json /app/
RUN npm install -g @angular/cli@7.0.7
COPY . /app
EXPOSE 4200/tcp
CMD ["npm", "start", "--", "--host", "0.0.0.0", "--poll", "500"]
