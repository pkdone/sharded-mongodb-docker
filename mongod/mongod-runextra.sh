#!/bin/sh

if [ "$DO_INIT_REPSET" = true ] ; then
    # Wait until local MongoDB instance is up and running
    until /usr/bin/mongosh --port 27017 --quiet --eval 'db.getMongo()'; do
        sleep 1
    done

    # Configure a MongoDB replica set if this replica has been asked to
    /usr/bin/mongosh --port 27017 <<EOF
        rs.initiate({_id: "${REPSET_NAME}", members: [
            {_id: 0, host: "${REPSET_NAME}-replica0:27017"},
            {_id: 1, host: "${REPSET_NAME}-replica1:27017"},
            {_id: 2, host: "${REPSET_NAME}-replica2:27017"}
        ], settings: {electionTimeoutMillis: 2000}});
EOF
fi
