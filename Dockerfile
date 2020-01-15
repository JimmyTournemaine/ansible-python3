# docker image build -t ansible-python3
FROM centos:7
RUN yum -y update; \
yum -y install openssh-clients; yum -y install sshpass; yum -y install python3; \
pip3 install --upgrade pip; pip3 install ansible; pip3 install lxml; pip3 install ansible-lint; \
adduser -m -r -s /bin/bash -U ansible
