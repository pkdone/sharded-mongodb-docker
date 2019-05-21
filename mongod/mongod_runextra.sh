#!/bin/sh

# Wait until local MongoDB instance is up and running
until /usr/bin/mongo --port 27017 --quiet --eval 'db.getMongo()'; do
    sleep 1
done

# Configure a MongoDB replica set (doesn't matter if each container attempts
# to run same action, first one wins, other attempts will then be ignored)
/usr/bin/mongo --port 27017 <<EOF
    rs.initiate({_id: "${REPSET_NAME}", members: [
        {_id: 0, host: "${REPSET_NAME}-replica0:27017"},
        {_id: 1, host: "${REPSET_NAME}-replica1:27017"},
        {_id: 2, host: "${REPSET_NAME}-replica2:27017"}
    ], settings: {electionTimeoutMillis: 2000}});
EOF

