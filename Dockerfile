FROM debian:stretch-slim
Maintainer sergio@fernandezcordero.net

# Preparing environment
RUN rm /bin/sh && ln -s /bin/bash /bin/sh && apt-get update && apt-get --yes --no-install-recommends install python python-dev libpython-dev make build-essential g++ curl wget git libxml2-dev curl ruby-full
RUN wget https://bootstrap.pypa.io/get-pip.py && python get-pip.py && pip install virtualenv

# Creating user for running
RUN groupadd cloud9 && useradd -g cloud9 -G cloud9 -md /opt/cloud9 cloud9 && echo "cloud9 ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers
USER cloud9

# Cloning and installing
RUN mkdir /opt/cloud9/workspace && git clone https://github.com/c9/core /opt/cloud9/sdk && /opt/cloud9/sdk/scripts/install-sdk.sh
RUN mkdir /opt/cloud9/venv && virtualenv -p `which python2` /opt/cloud9/venv && source /opt/cloud9/venv/bin/activate && echo "source /opt/cloud9/venv/bin/activate" | tee -a /opt/cloud9/.bashrc

CMD /opt/cloud9/.c9/node/bin/node /opt/cloud9/sdk/server.js -p 8181 -l 0.0.0.0 -a admin:admin -w /opt/cloud9/workspace

