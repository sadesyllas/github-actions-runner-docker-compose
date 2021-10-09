FROM ubuntu:18.04

ARG RUNNER_VERSION
ARG USER_ID
ARG GROUP_ID
ARG DOCKER_GROUP_ID

ENV RUNNER_VERSION=${RUNNER_VERSION}

RUN groupadd -g ${GROUP_ID} actions

RUN useradd -m actions -u ${USER_ID} -g ${GROUP_ID}

RUN apt-get -yqq update && apt-get install -yqq curl jq wget gpg lsb-release

RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
  | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

RUN echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
  | tee /etc/apt/sources.list.d/docker.list > /dev/null

RUN apt-get -yqq update && apt-get -yqq install docker-ce docker-ce-cli containerd.io

RUN groupadd -g ${DOCKER_GROUP_ID} docker-external

RUN usermod -a -G docker,docker-external actions

RUN \
  LABEL="$(curl -s -X GET 'https://api.github.com/repos/actions/runner/releases/latest' | jq -r '.tag_name')" \
  RUNNER_VERSION="$(echo ${latest_version_label:1})" \
  cd /home/actions && mkdir actions-runner && cd actions-runner \
  && wget https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz \
  && tar xzf ./actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz \
  && rm -rf ./actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz

WORKDIR /home/actions/actions-runner

RUN chown -R actions ~actions && /home/actions/actions-runner/bin/installdependencies.sh

USER actions

RUN mkdir /home/actions/actions-runner/workspace

COPY entrypoint.sh .

ENTRYPOINT ["./entrypoint.sh"]
