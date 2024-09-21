FROM node:14
RUN apt-get update -o Acquire::Retries=3 \
    && apt-get install -y git imagemagick \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
WORKDIR /ecs-app

COPY package*.json ./
COPY . .

RUN npm install
RUN chown -R node:node /ecs-app

ENV NODE_ENV=production
ENV ENV_ECS=true
USER root
EXPOSE 80

ENTRYPOINT ["npm", "start"]
