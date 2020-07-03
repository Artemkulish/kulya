FROM node:alpine3.12

LABEL maintainer="Artem Kulish"
ENV HTTP=80 \
    HTTPS=443 \
    HOST=0.0.0.0 \
    DOMAIN=nodejs.svagworks.me

WORKDIR /app

COPY package.json app.js ./
COPY nodejs.crt nodejs.ca-bundle nodejs.key /etc/ssl/
RUN npm i --no-cache

ENTRYPOINT ["npm", "run"]
CMD ["start"]
