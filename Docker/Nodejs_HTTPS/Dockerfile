FROM node:alpine3.12

LABEL maintainer="Artem Kulish"
ENV HTTP=80 \
    HTTPS=443 \
    HOST=0.0.0.0 \
    DOMAIN=nodejs.svagworks.me

WORKDIR /app

COPY ./src/ ./
COPY ./ssl/ /etc/ssl/
RUN npm i --no-cache

ENTRYPOINT ["npm", "run"]
CMD ["start"]
