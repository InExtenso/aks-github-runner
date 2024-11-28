FROM ubuntu:24.04

RUN apt-get update && apt-get -y install curl \
    iputils-ping \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \
    tar \
    jq \
    git \
    unzip \
    libicu-dev \
    htop \
    python-is-python3 \
    python3 && \
    apt-get clean && apt-get autoremove

RUN apt-get install -y podman
RUN #sed -i '/%t/podman/podman.sock/c\/var/run/docker.sock' /usr/lib/systemd/user/podman.socket
RUN #systemctl restart podman
RUN ln -s /usr/bin/podman /usr/bin/docker

RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

ARG GH_RUNNER_VERSION="2.321.0"
WORKDIR /actions-runner
RUN curl -o actions.tar.gz --location "https://github.com/actions/runner/releases/download/v${GH_RUNNER_VERSION}/actions-runner-linux-x64-${GH_RUNNER_VERSION}.tar.gz"
RUN tar -zxf actions.tar.gz
RUN rm -f actions.tar.gz
RUN ./bin/installdependencies.sh

COPY entrypoint.sh .
RUN chmod +x entrypoint.sh
ENTRYPOINT ["/actions-runner/entrypoint.sh"]
