FROM node:12

WORKDIR /usr/src/app

COPY ./node-app .

RUN npm install

EXPOSE 3000

CMD [ "node", "app.js" ]
