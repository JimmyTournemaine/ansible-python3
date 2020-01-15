# docker image build -t tzimy/ansible-python3 .
#
# CentOS 7 Image with Python3/Ansible installed in an isolated Python3 environment.
# Python 3 is conflicted python 2 is the RHEL 7 distributions.
#
# Using pip, ansible, python => v3
# Using sudo pip, sudo ansible, sudo python => v2
#
FROM centos:7 as builder
RUN yum -y update \
&& yum -y install python3 openssh-clients sshpass\
&& pip3 install virtualenv \
&& adduser -m -r -s /bin/bash -U ansible \
&& echo 'ansible ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers \
&& mkdir /opt/ansible-venv \
&& chown ansible:ansible /opt/ansible-venv

FROM builder
USER ansible
RUN python3 -m venv /opt/ansible-venv \
&& echo 'source /opt/ansible-venv/bin/activate' >> ~/.bash_profile \
&& source /opt/ansible-venv/bin/activate \
&& pip install --upgrade pip ansible ansible-lint \
&& python --version; pip --version; ansible --version; ansible-lint --version 
