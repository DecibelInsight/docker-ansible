FROM python:2.7

RUN mkdir /python && \
    useradd python -d /python && \
    chown python:python /python && \
    chmod 0700 /python && \
    pip install --no-cache-dir ansible==2.9.7 molecule[ec2]==2.22 docker sh==1.12.14
USER python
