FROM mongo:latest

RUN apt-get update && apt-get -q install -y

COPY --chown=mongodb:mongodb mongod_start.sh /usr/local/bin/
COPY --chown=mongodb:mongodb mongod_runextra.sh /usr/local/bin/

RUN chmod u+x /usr/local/bin/mongod_start.sh /usr/local/bin/mongod_runextra.sh

ENTRYPOINT ["mongod_start.sh"]

CMD mongod -f /etc/mongod.conf
