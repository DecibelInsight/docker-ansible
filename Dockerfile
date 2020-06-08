FROM python:2.7

ENV PACKER_VERSION 1.5.5

RUN mkdir /python && \
    useradd python -d /python && \
    mkdir /python/.ssh && \
    chown -R python:python /python && \
    chmod -R 0700 /python && \
    wget https://storage.googleapis.com/git-repo-downloads/repo -O /usr/local/bin/repo && \
    chmod 0755 /usr/local/bin/repo && \
    mkdir -p /packer && \
    chown -R python:python /packer && \
    chmod -R 0700 /packer && \
    wget https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip -O /packer/packer_${PACKER_VERSION}_linux_amd64.zip && \
    unzip -q /packer/packer_${PACKER_VERSION}_linux_amd64.zip -d /packer && \
    rm /packer/packer_${PACKER_VERSION}_linux_amd64.zip && \
    pip install --no-cache-dir ansible==2.9.7 molecule[ec2]==2.22 docker sh==1.12.14 lxml

ENV PATH $PATH:/packer

USER python
