FROM aharnum/universal

RUN mkdir /opt/ansible

WORKDIR /opt/ansible

COPY requirements.yml requirements.yml

COPY playbook-docker-build.yml playbook-docker-build.yml

COPY playbook-docker-run.yml playbook-docker-run.yml

RUN ansible-galaxy install -r requirements.yml

RUN echo '[local]' > /etc/ansible/hosts \
    && echo 'localhost' >> /etc/ansible/hosts \
    && echo '[defaults]' > .ansible.cfg \
    && echo 'transport = local' >> .ansible.cfg

RUN ansible-playbook playbook-docker-build.yml

EXPOSE 8081

COPY run.sh /usr/local/bin/run.sh

RUN chmod 755 /usr/local/bin/run.sh

ENTRYPOINT ["/usr/local/bin/run.sh"]
