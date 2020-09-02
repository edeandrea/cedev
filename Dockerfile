######################################################
# Using upstream Eclipse Che python image
FROM quay.io/eclipse/che-python-3.7:7.18.0

USER root

# Upgrade pip
RUN pip install --upgrade pip

# Install other tools
RUN apt-get update && \
    apt-get install -y git unzip curl wget && \
    pip3 install -U setuptools wheel

# Install Ansible
RUN pip3 install -U ansible && \
    ansible --version && \
    ansible-playbook --version

# Download and install Terraform
RUN wget https://releases.hashicorp.com/terraform/0.13.2/terraform_0.13.2_linux_amd64.zip && \
    unzip terraform_0.13.2_linux_amd64.zip && mv terraform /usr/local/bin/ && rm terraform_0.13.2_linux_amd64.zip && \
    terraform --version

# Download and install Hashi vault
RUN wget https://releases.hashicorp.com/vault/1.5.3/vault_1.5.3_linux_amd64.zip && \
    unzip vault_1.5.3_linux_amd64.zip && mv vault /usr/local/bin/ && rm vault_1.5.3_linux_amd64.zip && \
    vault --version

# Change permissions
RUN echo "user ALL=(ALL)  NOPASSWD: ALL" >> /etc/sudoers && \
    chown -R 1319330000 ${HOME}

USER user

######################################################
# Using RHEL8 base image that already has python on it
# FROM registry.redhat.io/codeready-workspaces/plugin-java8-rhel8:2.3

# USER root

# # Install tools
# RUN microdnf install -y git unzip && \
#     pip3 install setuptools wheel && \
#     pip3 install ansible && \

# # Download and install Terraform
# RUN wget https://releases.hashicorp.com/terraform/0.13.2/terraform_0.13.2_linux_amd64.zip && \
#     unzip terraform_0.13.2_linux_amd64.zip && mv terraform /usr/local/bin/ && rm terraform_0.13.2_linux_amd64.zip && \
#     terraform --version

# # Download and install Hashi vault
# RUN wget https://releases.hashicorp.com/vault/1.5.3/vault_1.5.3_linux_amd64.zip && \
#     unzip vault_1.5.3_linux_amd64.zip && mv vault /usr/local/bin/ && rm vault_1.5.3_linux_amd64.zip && \
#     vault --version

# USER jboss

######################################################
# FROM ubuntu:latest

# USER root

# ENV HOME="/home/ceuser"

# RUN apt-get purge -y python.* && \
#     apt autoremove -y && \
#     apt-get update && \
#     apt-get install -y --no-install-recommends ansible python3-pip git unzip curl wget && \
#     pip3 install -U setuptools wheel

# # Download and install Terraform
# RUN wget https://releases.hashicorp.com/terraform/0.13.2/terraform_0.13.2_linux_amd64.zip && \
#     unzip terraform_0.13.2_linux_amd64.zip && mv terraform /usr/local/bin/ && \
#     terraform --version

# # Download and install Hashi vault
# RUN wget https://releases.hashicorp.com/vault/1.5.3/vault_1.5.3_linux_amd64.zip && \
#     unzip vault_1.5.3_linux_amd64.zip && mv vault /usr/local/bin/ && \
#     vault --version

# # Install Python 3
# RUN ln -s /usr/bin/python3 /usr/bin/python && \
#     mkdir /.ansible && chmod 777 /.ansible && \
#     ansible --version && python -V

# # Add user
# RUN useradd -u 12345 -G root -d ${HOME} --shell /bin/bash -m ceuser && \
#     mkdir -p ${HOME}/che /projects && \
#     for f in "${HOME}" "/etc/passwd" "/etc/group" "/projects"; do \
#         chgrp -R 0 ${f} && \
#         chmod -R g+rwX ${f}; \
#     done && \
#     echo "ceuser ALL=(ALL)  NOPASSWD: ALL" >> /etc/sudoers


# USER ceuser

# WORKDIR /projects

# CMD tail -f /dev/null