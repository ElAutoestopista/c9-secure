FROM alpine:latest
Maintainer sergio@fernandezcordero.net

# Preparing environment
RUN apk update && apk add bash openssl-dev python python-dev make g++ curl wget git ruby sudo nodejs tmux ansible && rm -f /var/cache/apk/* && rm /bin/sh && ln -s /bin/bash /bin/sh
RUN wget https://bootstrap.pypa.io/get-pip.py && python get-pip.py && pip install virtualenv pylint

# Creating user for running
RUN mkdir -p /opt/cloud9 && addgroup cloud9 && adduser -g cloud9 -G cloud9 -h /opt/cloud9 -D cloud9 && chown -R cloud9:cloud9 /opt/cloud9 &&echo "cloud9 ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers
USER cloud9

# Cloning and installing
RUN mkdir /opt/cloud9/workspace && git clone https://github.com/c9/core /opt/cloud9/sdk && curl -s -L https://raw.githubusercontent.com/c9/install/master/link.sh | bash && /opt/cloud9/sdk/scripts/install-sdk.sh
RUN mkdir /opt/cloud9/venv && virtualenv -p `which python2` /opt/cloud9/venv && source /opt/cloud9/venv/bin/activate && echo "source /opt/cloud9/venv/bin/activate" | tee -a /opt/cloud9/.bashrc

CMD /opt/cloud9/.c9/node/bin/node /opt/cloud9/sdk/server.js -p 8181 -l 0.0.0.0 -a admin:admin -w /opt/cloud9/workspace

