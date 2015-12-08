## GPII Preferences Server Dockerfile - Ansible version

Builds a GPII Preference Server Docker container image. The image is built using the [Ansible role](https://github.com/gpii-ops/ansible-preferences-server).

## Building

- build Ansible-provisioned image:
    - `docker build -t gpii/preferences-server .`

## Testing

The container can be tested by setting the *CONTAINER_TEST* environment variable to *true*:
- `docker run -d --name couchdbtest klaemo/couchdb`
- `docker run --rm -it --name prefservertest -l couchdbtest -e NODE_ENV=preferencesServer.production -e CONTAINER_TEST=true -e NODE_ENV=preferencesServer.production -e COUCHDB_HOST_ADDRESS="couchdbtest:5984" -e PRIME_DB=true gpii/preferences-server`

This is expected to be run after launching a couchdb container or otherwise as part of a smoke integration test before pushing a rebuilt image. The container will exit after the test and the exit code as a result of the run command can be used for further actions.

## Running

- running requires a couchdb instance accessible to the container
- fully containerized example, assuming the DB needs to be primed:
    - `docker run -d --name couchdb klaemo/couchdb`
    - `docker run --name prefserver -d -p 8082:8082 -l couchdb -e NODE_ENV=preferencesServer.production -e COUCHDB_HOST_ADDRESS=couchdb:5984 -e PRIME_DB=true gpii/preferences-server`

## How it works
- `build.yml` - playbook for building the container image
- `run.yml` - playbook for runtime deployment steps (reconfiguring couchdb address, application environment and priming the DB), runs when the container is run - uses dynamically created `run-vars.yml` to pass environment variables from `docker run` to Ansible playbook, tests the container is connected properly to couchdb, then starts the application as a foreground process using supervisord
- `run.sh` - creates `run-vars.yml` based on environment variables from `docker run`, runs `run.yml` for runtime deployment steps, and starts the preferencesServer using supervisord
