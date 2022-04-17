FROM node:14

# Also exposing VSCode debug ports
EXPOSE 8000 9929 9230

RUN \
  apt update && \
  apt install python && \
  apt autoremove && \
  apt clean

RUN npm install -g gatsby-cli

WORKDIR /app
COPY ./package.json .
RUN yarn install && yarn cache clean
COPY . .
CMD ["yarn", "develop", "-H", "0.0.0.0" ]