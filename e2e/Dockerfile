FROM node:6

COPY ./e2e/src /var/lib/app
COPY ./microservicesdemo-core /var/lib/core
COPY ./e2e/scripts/startup.sh /home/docker/

WORKDIR /var/lib/app

RUN chmod +x /home/docker/startup.sh
RUN npm install --silent

EXPOSE 80

ENTRYPOINT ["/home/docker/startup.sh"]
