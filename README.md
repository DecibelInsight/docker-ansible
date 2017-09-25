Docker-Ansible base images
===================


## Summary

Originally cloned from **[William-Yeh/docker-ansible](https://github.com/William-Yeh/docker-ansible)**

This repository contains Dockerized [Ansible](https://github.com/ansible/ansible), published to the public [Docker Hub](https://hub.docker.com/) via **automated build** mechanism.

## Configuration

These are Docker images for [Ansible](https://github.com/ansible/ansible) software, installed in a selected Linux distributions.

### Base OS

Ubuntu (xenial, trusty)

### Ansible

One version is provided:

  1. provides version 2.3.1.0 of Ansible

Each version is further divided into two variants:

- *Normal* variant: intended to be used as Ansible *control machines*, or in cases that is inadequate in the onbuild variants.
- *Onbuild* variant: intended to be used to build Docker images.


## Images and tags

### Official Ansible Version 2.3.1.0

- Normal variants:

  - `mspanakis/ansible:ubuntu16.04`
  - `mspanakis/ansible:ubuntu14.04`

- Onbuild variants (*recommended for common cases*):

  - `mspanakis/ansible:ubuntu16.04-onbuild`
  - `mspanakis/ansible:ubuntu14.04-onbuild`


## For the impatient

Here comes a simplest working example for the impatient.

First, choose a base image you'd like to begin with. For example, `williamyeh/ansible:ubuntu14.04-onbuild`.

Second, put the following `Dockerfile` along with your playbook directory:

```
FROM williamyeh/ansible:ubuntu14.04-onbuild

# ==> Specify requirements filename;  default = "requirements.yml"
#ENV REQUIREMENTS  requirements.yml

# ==> Specify playbook filename;      default = "playbook.yml"
#ENV PLAYBOOK      playbook.yml

# ==> Specify inventory filename;     default = "/etc/ansible/hosts"
#ENV INVENTORY     inventory.ini

# ==> Executing Ansible (with a simple wrapper)...
RUN ansible-playbook-wrapper
```

Third, `docker build .`

Done!

For more advanced usage, the role in Ansible Galaxy [`williamyeh/nginx`](https://galaxy.ansible.com/williamyeh/nginx/) demonstrates how to perform a simple smoke test (*configuration needs test, too!*) on a variety of (*containerized*) Linux distributions on [CircleCI](https://circleci.com/)'s Ubuntu 12.04 and [Travis CI](https://travis-ci.org/)’s Ubuntu 14.04 worker instances.




## Why yet another Ansible image for Docker?

There has been quite a few Ansible images for Docker (e.g., [search](https://hub.docker.com/search/?q=ansible&isAutomated=0&isOfficial=0&page=1&pullCount=1&starCount=0) in the Docker Hub), so why reinvent the wheel?

In the beginning I used the [`ansible/ansible-docker-base`](https://github.com/ansible/ansible-docker-base) created by Ansible Inc. It worked well, but left some room for improvement:

- *Base OS image* - It provides only `centos:centos7` and `ubuntu:14.04`.  Insufficent for me.

- *Unnecessary dependencies* - It installed, at the very beginning of its Dockerfile, the `software-properties-common` package, which in turns installed some Python packages. I prefered to incorporate these stuff only when absolutely needed.

Therefore, I built these Docker images on my own.

**NOTE:** [`ansible/ansible-docker-base`](https://github.com/ansible/ansible-docker-base) announced in September 2015: “Ansible no longer maintains images in Dockerhub directly.”

## Usage

Used mostly as a *base image* for configuring other software stack on some specified Linux distribution(s).

Take Debian/Ubuntu/CentOS for example. To test an Ansible `playbook.yml` against a variety of Linux distributions, we may use [Vagrant](https://www.vagrantup.com/) as follows:

```ruby
# Vagrantfile

Vagrant.configure(2) do |config|

    # ==> Choose a Vagrant box to emulate Linux distribution...
    config.vm.box = "ubuntu/xenial64"
    #config.vm.box = "ubuntu/trusty64"

    # ==> Executing Ansible...
    config.vm.provision "ansible" do |ansible|
        ansible.playbook = "playbook.yml"
    end

end
```

Virtual machines can emulate a variety of Linux distributions with good quality, at the cost of runtime overhead.


Docker to be a rescue. Now, with these **williamyeh/ansible** series, we may test an Ansible `playbook.yml` against a variety of Linux distributions as follows:


```dockerfile
# Dockerfile

# ==> Choose a base image to emulate Linux distribution...
FROM williamyeh/ansible:ubuntu16.04
#FROM williamyeh/ansible:ubuntu14.04


# ==> Copying Ansible playbook...
WORKDIR /tmp
COPY  .  /tmp

# ==> Creating inventory file...
RUN echo localhost > inventory

# ==> Executing Ansible...
RUN ansible-playbook -i inventory playbook.yml \
      --connection=local --sudo
```

You may also work with `onbuild` variants, which take care of many routine steps for you:

```dockerfile
# Dockerfile

# ==> Choose a base image to emulate Linux distribution...
FROM williamyeh/ansible:ubuntu16.04-onbuild
#FROM williamyeh/ansible:ubuntu14.04-onbuild


# ==> Specify requirements filename;  default = "requirements.yml"
#ENV REQUIREMENTS  requirements.yml

# ==> Specify playbook filename;      default = "playbook.yml"
#ENV PLAYBOOK      playbook.yml

# ==> Specify inventory filename;     default = "/etc/ansible/hosts"
#ENV INVENTORY     inventory.ini

# ==> Executing Ansible (with a simple wrapper)...
RUN ansible-playbook-wrapper
```



With Docker, we can test any Ansible playbook against any version of any Linux distribution without the help of Vagrant. More lightweight, and more portable across IaaS, PaaS, and even CaaS (Container as a Service) providers!

If better OS emulation (virtualization) isn't required, the Docker approach (containerization) should give you a more efficient Ansible experience.



## License

Author: William Yeh <william.pjyeh@gmail.com>

Licensed under the Apache License V2.0. See the [LICENSE file](LICENSE) for details.
