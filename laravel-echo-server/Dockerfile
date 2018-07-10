FROM node:alpine

# Create app directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Install app dependencies
COPY package.json /usr/src/app/

RUN apk add --update \
    python \
    python-dev \
    py-pip \
    build-base \
    libc6-compat

RUN npm install

# Bundle app source
COPY laravel-echo-server.json /usr/src/app/laravel-echo-server.json

EXPOSE 6001
CMD [ "npm", "start" ]
