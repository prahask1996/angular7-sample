# base image
FROM node:8.9.4

# set working directory
WORKDIR /app


# add `/node_modules/.bin` to $PATH
ENV PATH /node_modules/.bin:$PATH

# install app dependencies
COPY package.json ./

RUN npm install -y
RUN npm run build --prod

# add app
COPY . .

EXPOSE 4200

# start app
CMD ["npm", "start"]
