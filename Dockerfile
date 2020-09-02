FROM registry.redhat.io/codeready-workspaces/plugin-java8-rhel8:2.3

USER root

# Install tools
RUN microdnf install -y git unzip && \
    pip3 install ansible && \
    pip3 install setuptools

# Download and install Terraform
RUN wget https://releases.hashicorp.com/terraform/0.13.2/terraform_0.13.2_linux_amd64.zip && \
    unzip terraform_0.13.2_linux_amd64.zip && mv terraform /usr/local/bin/ && \
    terraform --version

# Download and install Hashi vault
RUN wget https://releases.hashicorp.com/vault/1.5.3/vault_1.5.3_linux_amd64.zip && \
    unzip vault_1.5.3_linux_amd64.zip && mv vault /usr/local/bin/ && \
    vault --version

USER jboss