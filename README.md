## GPII Preferences Server Dockerfile - Ansible version

Builds a GPII Preference Server Docker container image. The image is built using the [Ansible role](https://github.com/gpii-ops/ansible-preferences-server).

A separate sidecar container exists for initializing the dataset.

## Building

- build Ansible-provisioned image:
    - `docker build -t gpii/preferences-server .`

## Runtime Environment Variables

- `COUCHDB_HOST_ADDRESS`: host address of the couchdb instance to use. You will typically need to be explicit about this. (default: `localhost:5984`)
- `NODE_ENV`: specifies the configuration file to be used from https://github.com/GPII/universal/tree/master/gpii/configs when launching (default: `gpii.config.preferencesServer.standalone.production`)
- `CONTAINER_TEST`: whether or not to run the container in test mode, then exit (default: `false`)

## Testing

The container can be tested by setting the *CONTAINER_TEST* environment variable to *true*:
- `docker run -d --name couchdb inclusivedesign/couchdb`
- `docker run --rm --link couchdb -e CLEAR_INDEX=true -e COUCHDB_HOST_ADDRESS=couchdb:5984 gpii/preferences-server-data-loader`
- `docker run --rm -it --name prefservertest --link couchdb -e NODE_ENV=gpii.config.preferencesServer.standalone.production -e CONTAINER_TEST=true -e NODE_ENV=gpii.config.preferencesServer.standalone.production -e COUCHDB_HOST_ADDRESS="couchdb:5984" gpii/preferences-server`

This is expected to be run after launching a couchdb container & priming it with test data (or similar) as part of a smoke integration test before pushing a rebuilt image. The container will exit after the test and the exit code as a result of the run command can be used for further actions.

## Running

- running requires a couchdb instance accessible to the container (likely primed with test data)
- fully containerized example, assuming the DB needs to be primed (using the sidecar container):
    - `docker run -d -p 5984:5984 --name couchdb inclusivedesign/couchdb`
    - `docker run --rm --link couchdb -e CLEAR_INDEX=true -e COUCHDB_HOST_ADDRESS=couchdb:5984 gpii/preferences-server-data-loader`
    - `docker run --name prefserver -d -p 8081:8081 --link couchdb gpii/preferences-server`

## How it works
- `build.yml` - playbook for building the container image
- `run.yml` - playbook for runtime deployment steps (reconfiguring couchdb address, application environment and priming the DB), runs when the container is run - uses dynamically created `run-vars.yml` to pass environment variables from `docker run` to Ansible playbook, then starts the application as a foreground process using supervisord
- `run.sh` - creates `run-vars.yml` based on environment variables from `docker run`, runs `run.yml` for runtime deployment steps, and starts the preferencesServer using supervisord
