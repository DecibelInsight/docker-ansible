# Dockerfile for building Ansible image from release for Ubuntu 16.04 (xenial), with as few additional software as possible.
#
# Version  1.0
#


# pull base image
FROM ubuntu:16.04

MAINTAINER William Yeh <william.pjyeh@gmail.com>

ENV ANSIBLE_VER 2.3.1.0
ENV ANSIBLE_URL "http://releases.ansible.com/ansible/ansible-${ANSIBLE_VER}.tar.gz"

RUN echo "===> Adding Ansible's prerequisites..."   && \
    apt-get update -y            && \
    DEBIAN_FRONTEND=noninteractive  \
        apt-get install --no-install-recommends -y -q  \
                build-essential                        \
                python python-pip python-dev           \
                libxml2-dev libxslt1-dev zlib1g-dev    \
                curl                                   \
                git                                 && \
    pip install --upgrade setuptools pip wheel      && \
    pip install --upgrade pyyaml jinja2 pycrypto    && \
    pip install --upgrade pywinrm                   && \
    \
    \
    echo "===> Downloading Ansible's source tree..."            && \
    curl -o tmp/ansible.tar.gz ${ANSIBLE_URL}               && \
    \
    \
    echo "===> Extracting Ansible..."     && \
    cd /tmp                               && \
    mkdir -p /tmp/ansible                 && \
    tar xfz ansible.tar.gz -C ansible --strip-components 1 && \
    \
    \
    echo "===> Moving useful Ansible stuff to /opt/ansible ..."  && \
    mkdir -p /opt/ansible                && \
    mv /tmp/ansible/bin   /opt/ansible/bin   && \
    mv /tmp/ansible/lib   /opt/ansible/lib   && \
    mv /tmp/ansible/docs  /opt/ansible/docs  && \
    rm -rf /tmp/ansible                  && \
    \
    \
    echo "===> Installing handy tools (not absolutely required)..."  && \
    apt-get install -y sshpass openssh-client  && \
    \
    \
    echo "===> Clean up..."                                         && \
    apt-get remove -y --auto-remove \
            build-essential python-pip python-dev git               && \
    apt-get clean                                                   && \
    rm -rf /var/lib/apt/lists/*                                     && \
    \
    \
    echo "===> Adding hosts for convenience..."  && \
    mkdir -p /etc/ansible                        && \
    echo 'localhost' > /etc/ansible/hosts


ENV PATH        /opt/ansible/bin:$PATH
ENV PYTHONPATH  /opt/ansible/lib:$PYTHONPATH
ENV MANPATH     /opt/ansible/docs/man:$MANPATH

# default command: display Ansible version
CMD [ "ansible-playbook", "--version" ]
