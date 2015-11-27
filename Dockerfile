FROM inclusivedesign/universal

WORKDIR /etc/ansible/playbooks

COPY ansible/* /etc/ansible/playbooks/

RUN ansible-galaxy install -r requirements.yml

RUN ansible-playbook build.yml --tags "deploy"

COPY run.sh /usr/local/bin/run.sh

RUN chmod 755 /usr/local/bin/run.sh

ENTRYPOINT ["/usr/local/bin/run.sh"]
