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
    - `docker run --name prefserver -d -p 8082:8082 -l couchdb -e NODE_ENV=preferencesServer.production -e COUCHDB_HOST_ADDRESS=couchdb:5984 -e PRIME_DB=true -t aharnum/preferences-server`

## How it works
- `playbook-docker-build.yml` - playbook for building the container image
- `playbook-docker-run.yml` - playbook for runtime deployment steps (reconfiguring couchdb address, application environment and priming the DB), runs when the container is run - uses dynamically created `runtime_vars.yml` to pass environment variables from `docker run` to Ansible playbook
- `run.sh` - creates `runtime_vars.yml` based on environment variables from `docker run`, runs `playbook-docker-run.yml` for runtime deployment steps, and starts the preferencesServer using supervisord
