FROM debian:jessie-slim
Maintainer sergio@fernandezcordero.net

# Preparing environment
RUN apt-get update && apt-get --yes upgrade
RUN apt-get --yes install apache2 net-tools python-software-properties python make build-essential g++ curl libssl-dev apache2-utils git libxml2-dev curl sudo

# Creating user for running
RUN groupadd cloud9 && useradd -g cloud9 -G cloud9 -md /opt/cloud9 cloud9
RUN su - cloud9 -c "mkdir /opt/cloud9/workspace"
RUN echo "cloud9 ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers

# Cloning and installing
RUN su - cloud9 -c "git clone https://github.com/c9/core /opt/cloud9/sdk"
RUN su - cloud9 -c "/opt/cloud9/sdk/scripts/install-sdk.sh"
EXPOSE 8181
CMD su - cloud9 -c "/opt/cloud9/.c9/node/bin/node /opt/cloud9/sdk/server.js -p 8181 -l 0.0.0.0 -a admin:admin -w /opt/cloud9/workspace"

