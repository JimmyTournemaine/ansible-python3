# docker image build -t tzimy/ansible-python3 .

FROM centos:7 as builder
RUN yum -y update \
&& yum -y install sudo \
&& yum -y install python3 openssh-clients sshpass \
&& pip3 install virtualenv \
&& adduser -m -s /bin/bash -U ansible \
&& echo 'ansible ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers \
&& mkdir /opt/ansible-venv \
&& chown ansible:ansible /opt/ansible-venv

FROM builder
USER ansible
RUN python3 -m venv /opt/ansible-venv \
&& echo 'source /opt/ansible-venv/bin/activate' >> ~/.bashrc \
&& echo 'export LANG=en_US.UTF-8' >> ~/.bashrc \
&& source /opt/ansible-venv/bin/activate \
&& pip install --upgrade pip ansible ansible-lint \
&& python --version; pip --version; ansible --version; ansible-lint --version 
