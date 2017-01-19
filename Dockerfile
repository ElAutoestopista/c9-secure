FROM debian:latest
Maintainer sergio@fernandezcordero.net

RUN apt-get update && apt-get --yes upgrade
RUN apt-get --yes install apache2 net-tools python-software-properties python make build-essential g++ curl libssl-dev apache2-utils git libxml2-dev curl
RUN groupadd cloud9 && useradd -g cloud9 -G cloud9 -md /opt/cloud9  cloud9
RUN su - cloud9 -c "git clone https://github.com/c9/core /opt/cloud9/sdk"
RUN su - cloud9 -c "/opt/cloud9/sdk/scripts/install-sdk.sh"
COPY scripts/cloud9.service /lib/systemd/system
RUN ln -s /lib/systemd/system/cloud9.service /etc/systemd/system/cloud9.service
RUN systemctl enable cloud9.service

