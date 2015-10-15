#!/bin/sh -e

echo "NODE_ENV: $NODE_ENV"
echo "COUCHDB_HOST_ADDRESS: $COUCHDB_HOST_ADDRESS"
echo "PRIME_DB: $PRIME_DB"

cat > runtime_vars.yml<<EOF
---
gpii_preferences_server_couchdb_host_address: $COUCHDB_HOST_ADDRESS
gpii_preferences_server_environment: $NODE_ENV
gpii_preferences_server_prime_db: $PRIME_DB
EOF

ansible-playbook playbook-docker-run.yml --tags "deploy" && supervisord -n -c /etc/supervisord.conf

# docker run --name prefserver -d -P -l couchdb -e NODE_ENV=development.all.local -e COUCHDB_HOST_ADDRESS=couchdb:5984 -e PRIME_DB=true -t aharnum/preferences-server
