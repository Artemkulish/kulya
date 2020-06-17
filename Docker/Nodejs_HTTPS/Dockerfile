FROM node:alpine3.12

ARG MAINTAINER="Artyom Kulish"
ENV HTTP=80
ENV HTTPS=443
ENV HOST=0.0.0.0

WORKDIR /app

COPY package.json app.js ./
COPY nodejs.crt nodejs.ca-bundle nodejs.key /etc/ssl/
RUN npm i --no-cache

HEALTHCHECK --interval=5s --timeout=3s --start-period=5s --retries=3 CMD ["curl", "0.0.0.0/ping"]

ENTRYPOINT ["npm", "run"]
CMD ["start"]
