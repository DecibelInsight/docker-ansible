FROM python:2.7

ENV PACKER_VERSION 1.5.5

ADD https://download.docker.com/linux/debian/gpg .

RUN mkdir /python && \
    useradd python -d /python && \
    mkdir /python/.ssh && \
    chown -R python:python /python && \
    chmod -R 0700 /python && \
    mkdir -p /packer && \
    chown -R python:python /packer && \
    chmod -R 0700 /packer && \
    apt-get update && \
    apt-get install -y apt-transport-https ca-certificates software-properties-common && \
    apt-key add gpg && \
    echo "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | tee -a /etc/apt/sources.list.d/docker.list && \
    apt-get update && \
    apt-cache policy docker-ce && \
    apt-get -y install docker-ce && \
    rm -rf /var/lib/apt/lists/* && \
    wget https://storage.googleapis.com/git-repo-downloads/repo -O /usr/local/bin/repo && \
    chmod 0755 /usr/local/bin/repo && \
    wget https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip -O /packer/packer_${PACKER_VERSION}_linux_amd64.zip && \
    unzip -q /packer/packer_${PACKER_VERSION}_linux_amd64.zip -d /packer && \
    rm /packer/packer_${PACKER_VERSION}_linux_amd64.zip && \
    pip install --no-cache-dir ansible==2.9.7 molecule[ec2]==2.22 sh==1.12.14 awscli

ENV PATH $PATH:/packer

USER python
