FROM mongo:latest

RUN apt-get update && apt-get -q install -y

COPY --chown=mongodb:mongodb mongos_start.sh /usr/local/bin/
COPY --chown=mongodb:mongodb mongos_runextra.sh /usr/local/bin/

RUN chmod u+x /usr/local/bin/mongos_start.sh /usr/local/bin/mongos_runextra.sh

ENTRYPOINT ["mongos_start.sh"]

CMD mongos --port 27017 --bind_ip 0.0.0.0
