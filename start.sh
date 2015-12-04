#!/bin/sh -e

# Create an Ansible variables file for playbook-docker-run based on environment variables passed to the container

cat > runtime_vars.yml<<EOF
---
gpii_preferences_server_couchdb_host_address: $COUCHDB_HOST_ADDRESS
gpii_preferences_server_environment: $NODE_ENV
gpii_preferences_server_prime_db: $PRIME_DB
EOF

ansible-playbook run.yml --tags "deploy" && supervisord -n -c /etc/supervisord.conf
