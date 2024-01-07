FROM node:21.5-bookworm-slim

WORKDIR /usr/src/app

COPY package.json ./
RUN npm install
RUN npm install -D @swc/cli @swc/core

COPY . .

CMD [ "npm", "run", "dev" ]
