FROM ubuntu:latest

USER root

RUN apt-get purge -y python.* && \
    apt autoremove -y && \
    apt-get update && \
    apt-get install -y --no-install-recommends ansible python3-pip git unzip && \
    mkdir -p /projects && \
    chgrp -R 0 /projects && \
    chmod -R g+rwX /projects

RUN pip3 install -U setuptools wheel

# Download and install Terraform
RUN wget https://releases.hashicorp.com/terraform/0.13.1/terraform_0.13.1_linux_amd64.zip && \
    unzip terraform_0.13.1_linux_amd64.zip && mv terraform /usr/local/bin/ && \
    terraform --version

# Download and install Hashi vault
RUN wget https://releases.hashicorp.com/vault/1.5.3/vault_1.5.3_linux_amd64.zip && \
    unzip vault_1.5.3_linux_amd64.zip && mv vault /usr/local/bin/ && \
    vault --version

# Install Python 3
RUN ln -s /usr/bin/python3 /usr/bin/python && \
    mkdir /.ansible && chmod 777 /.ansible && \
    ansible --version && python -V

# Add additional packages
RUN apt-get install -y curl
RUN useradd -m -u 12345 -s /bin/bash ceuser
USER ceuser
WORKDIR /projects
CMD tail -f /dev/null