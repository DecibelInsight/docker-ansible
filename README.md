# Introduction

This Dockerfile is built to support Ansible Molecule testing for EC2 instances. This image is currently pegged to all of the requirements for Ansible Molecule v2.22, since integration of the EC2 driver for Molecule v3 is not yet finalized.

The image is currently sourced from the Python v2.7 upstream image.

## Container Execution

This container doesn't execute Ansible, or Molecule, by default, as it's a multipurposed image. You will need to execute a command when `docker run`ning this image.
