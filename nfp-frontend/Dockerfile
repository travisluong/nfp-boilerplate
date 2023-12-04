FROM node:20.9

WORKDIR /usr/src/app

COPY package.json ./
RUN npm install
RUN npm install -D @swc/cli @swc/core

COPY . .

CMD [ "npm", "run", "dev" ]
