FROM gtirloni/universal

RUN yum install sudo -y

# Try to disable requiretty in /etc/sudoers, found at https://gist.github.com/petems/367f8119bbff011bf83e
RUN echo "Removing requiretty" \
    && sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers \
    && echo "Complete!"

RUN yum install ansible -y

COPY requirements.yml requirements.yml

COPY playbook.yml playbook.yml

RUN ansible-galaxy install -r requirements.yml

RUN echo '[local]' > /etc/ansible/hosts \
    && echo 'localhost' >> /etc/ansible/hosts \
    && echo '[defaults]' > .ansible.cfg \
    && echo 'transport = local' >> .ansible.cfg

RUN ansible-playbook playbook.yml

# COPY modify_preferences.sh /usr/local/bin/modify_preferences.sh
# COPY start.sh /usr/local/bin/start.sh

# RUN chmod 755 /usr/local/bin/modify_preferences.sh
# RUN chmod 755 /usr/local/bin/start.sh

# EXPOSE 8082

# ENTRYPOINT ["/usr/local/bin/start.sh"]
