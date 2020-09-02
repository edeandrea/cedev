# FROM ubuntu:latest
FROM registry.redhat.io/codeready-workspaces/plugin-java8-rhel8:2.3

USER root

RUN microdnf install -y zip

# ENV \
#     HOME="/home/ceuser"

# RUN apt-get purge -y python.* && \
#     apt autoremove -y && \
#     apt-get update && \
#     apt-get install -y --no-install-recommends ansible python3-pip git unzip

# RUN pip3 install -U setuptools wheel

# Download and install Terraform
RUN wget https://releases.hashicorp.com/terraform/0.13.2/terraform_0.13.2_linux_amd64.zip && \
    unzip terraform_0.13.2_linux_amd64.zip && mv terraform /usr/local/bin/ && \
    terraform --version

# Download and install Hashi vault
RUN wget https://releases.hashicorp.com/vault/1.5.3/vault_1.5.3_linux_amd64.zip && \
    unzip vault_1.5.3_linux_amd64.zip && mv vault /usr/local/bin/ && \
    vault --version

# Install Python 3
# RUN ln -s /usr/bin/python3 /usr/bin/python && \
#     mkdir /.ansible && chmod 777 /.ansible && \
#     ansible --version && python -V

# Add additional packages
# RUN apt-get install -y curl

# Add user & directories
# RUN useradd -u 12345 -G wheel,root -d /home/ceuser --shell /bin/bash -m ceuser && \
#     mkdir -p /projects && \
#     for f in "/home/ceuser" "/projects"; do \
#         chgrp -R 0 ${f} && \
#         chmod -R g+rwX ${f}; \
#     done

# USER ceuser

# WORKDIR /projects
USER jboss

# CMD tail -f /dev/null