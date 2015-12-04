## GPII Preferences Server Dockerfile - Ansible version

Builds a GPII Preference Server Docker container image. The image is built using the [Ansible role](https://github.com/gpii-ops/ansible-gpii-preferences-server).

## Building

- build Ansible-provisioned image:
    - `docker build -t inclusivedesign/preferences-server .`

## Running

- running requires a couchdb instance accessible to the container
- fully containerized example:
    - `docker run -d -p 5984:5984 --name couchdb klaemo/couchdb`
    - `docker run --name prefserver -d -p 8082:8082 -l couchdb -e NODE_ENV=preferencesServer.production -e COUCHDB_HOST_ADDRESS=couchdb:5984 -e PRIME_DB=true -t inclusivedesign/preferences-server`

## How it works
- `build.yml` - playbook for building the container image
- `run.yml` - playbook for runtime deployment steps (reconfiguring couchdb address, application environment and priming the DB), runs when the container is run - uses dynamically created `runtime_vars.yml` to pass environment variables from `docker run` to Ansible playbook
- `run.sh` - creates `runtime_vars.yml` based on environment variables from `docker run`, runs `run.yml` for runtime deployment steps, and starts the preferencesServer using supervisord
