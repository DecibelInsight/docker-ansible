FROM python:2.7

RUN mkdir /python && \
    useradd python -d /python && \
    mkdir /python/.ssh && \
    chown -R python:python /python && \
    chmod -R 0700 /python && \
    wget https://storage.googleapis.com/git-repo-downloads/repo -O /usr/local/bin/repo && \
    chmod 0755 /usr/local/bin/repo && \
    pip install --no-cache-dir ansible==2.9.7 molecule[ec2]==2.22 docker sh==1.12.14
USER python
