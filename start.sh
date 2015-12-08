#!/bin/sh -e

# Create an Ansible variables file for playbook-docker-run based on environment variables passed to the container

cat > run-vars.yml<<EOF
---
preferences_server_couchdb_host_address: $COUCHDB_HOST_ADDRESS
preferences_server_environment: $NODE_ENV
preferences_server_prime_db: $PRIME_DB

nodejs_app_host_address: 127.0.0.1
nodejs_app_tcp_port: 8082
nodejs_app_test_http_endpoint: /preferences/carla
nodejs_app_test_http_status_code: 200
nodejs_app_test_string: registry.gpii.net

EOF

ansible-playbook run.yml --tags "deploy" --extra-vars "@run-vars.yml" && \
ansible-playbook run.yml --tags "test" --extra-vars "@run-vars.yml" && \
# kill the supervisord process started by the test so we can restart it in the foreground
pkill supervisord && \
supervisord -n -c /etc/supervisord.conf
