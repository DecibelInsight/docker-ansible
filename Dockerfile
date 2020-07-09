FROM python:2.7

ENV ANSIBLE_VERSION 2.9.10
ENV PACKER_VERSION 1.5.6
ENV TERRAFORM_VERSION 0.12.28
ENV TERRAGRUNT_VERSION 0.23.31

RUN mkdir /python && \
    useradd python -d /python && \
    mkdir /python/.ssh && \
    chown -R python:python /python && \
    chmod -R 0700 /python && \
    wget https://storage.googleapis.com/git-repo-downloads/repo -O /usr/local/bin/repo && \
    chmod 0755 /usr/local/bin/repo && \
    wget https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip -O /tmp/packer_${PACKER_VERSION}_linux_amd64.zip && \
    unzip -q /tmp/packer_${PACKER_VERSION}_linux_amd64.zip -d /usr/local/bin && \
    rm /tmp/packer_${PACKER_VERSION}_linux_amd64.zip && \
    wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
	mv terraform /usr/bin/terraform && \
	chmod +x /usr/bin/terraform && \
    wget https://github.com/gruntwork-io/terragrunt/releases/download/v${TERRAGRUNT_VERSION}/terragrunt_linux_amd64 -O /usr/bin/terragrunt && \
	chmod +x /usr/bin/terragrunt && \
    pip install --no-cache-dir ansible==${ANSIBLE_VERSION} molecule[ec2]==2.22 docker sh==1.12.14 lxml

USER python
