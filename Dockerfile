FROM gpii/universal

WORKDIR /etc/ansible/playbooks

COPY provisioning/*.yml /etc/ansible/playbooks/

RUN ansible-galaxy install -r requirements.yml

RUN ansible-playbook build.yml --tags "deploy"

COPY provisioning/start.sh /usr/local/bin/start.sh

RUN chmod 755 /usr/local/bin/start.sh

EXPOSE 8082

ENTRYPOINT ["/usr/local/bin/start.sh"]
