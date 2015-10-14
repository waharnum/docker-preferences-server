## GPII Preferences Server Dockerfile - Ansible version

Building Docker containers using our Ansible roles, still in development.

## Usage

- build intermediary image (installs Ansible, other dependencies for Ansible to work when run internally): `docker build -t aharnum/universal -f Dockerfile.aharnum.universal .`
- build Ansible-provisioned image:`docker build -t aharnum/universal .`
