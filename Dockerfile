FROM gpii/universal

WORKDIR /etc/ansible/playbooks

COPY ansible/* /etc/ansible/playbooks/

RUN ansible-galaxy install -r requirements.yml

RUN ansible-playbook build.yml --tags "deploy"

COPY start.sh /usr/local/bin/start.sh

RUN chmod 755 /usr/local/bin/start.sh

ENTRYPOINT ["/usr/local/bin/start.sh"]
