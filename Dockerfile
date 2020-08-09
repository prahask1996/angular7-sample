FROM node:8.9.4

# set working directory
WORKDIR /app

# install and cache app dependencies
COPY package*.json ./
RUN npm install
RUN npm run build --prod
COPY . .
EXPOSE 4200

CMD ["npm", "start"]
