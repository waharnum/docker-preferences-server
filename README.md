## GPII Preferences Server Dockerfile - Ansible version

Building Docker containers using our Ansible roles, still in development.

## Building

- build intermediary image (installs Ansible, other dependencies for Ansible to work when run internally):
    - `docker build -t aharnum/universal -f Dockerfile.aharnum.universal .`
- build Ansible-provisioned image:
    - `docker build -t aharnum/universal .`

## Running

- running requires a couchdb instance accessible to the container
- fully containerized example:
    - `docker run -d -p 5984:5984 --name couchdb klaemo/couchdb`
    - `docker run --name prefserver -d -p 8081:8081 -l couchdb -e NODE_ENV=development.all.local -e COUCHDB_HOST_ADDRESS=couchdb:5984 -e PRIME_DB=true -t aharnum/preferences-server`

## Current issues

- production mode doesn't work, am investigating:
    - `docker run --name prefserver -d -p 8082:8082 -l couchdb -e NODE_ENV=preferencesServer.production -e COUCHDB_HOST_ADDRESS=couchdb:5984 -e PRIME_DB=true -t aharnum/preferences-server`
        - `/preferences/carla` endpoint returns:
            - `{"isError":true,"message":"not_found: no_db_file","statusCode":500}`
    - this is probably something very simple that I don't yet know to solve due to lack of gpii familiarity
