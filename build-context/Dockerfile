FROM ubuntu:20.04

ARG DOCKER_GROUP_ID=""

ARG DOCKER_HOST=""

ENV DEBIAN_FRONTEND="noninteractive"

ENV TZ="Etc/UTC"

ENV RUNNER_VERSION="2.283.2"

ENV DOCKER_HOST="${DOCKER_HOST}"

RUN useradd -m actions

RUN \
  apt-get -yqq update \
  && apt-get -yqq install tzdata \
  && apt-get install -yqq git curl jq wget gpg lsb-release

RUN \
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
  | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

RUN \
  echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
  | tee /etc/apt/sources.list.d/docker.list > /dev/null

RUN \
  apt-get -yqq update \
  && apt-get -yqq install docker-ce docker-ce-cli containerd.io \
  && docker buildx install

RUN usermod -a -G docker actions

RUN \
  ( \
    test -n "${DOCKER_GROUP_ID}" \
    && groupadd -g ${DOCKER_GROUP_ID} docker-external \
    && usermod -a -G docker-external actions \
  ) || true

# Dependencies of Cypress.
RUN \
  apt-get -yqq update \
  && apt-get install -yqq libgtk2.0-0 libgtk-3-0 libgbm-dev libnotify-dev \
    libgconf-2-4 libnss3 libxss1 libasound2 libxtst6 xauth xvfb \
  && wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
  && apt install -yqq ./google-chrome-stable_current_amd64.deb \
  && rm -f ./google-chrome-stable_current_amd64.deb

RUN \
  echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" \
    | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list \
  && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg \
    | apt-key --keyring /usr/share/keyrings/cloud.google.gpg  add - \
  && apt-get update -yqq \
  && apt-get install -yqq google-cloud-sdk

RUN \
  mkdir /home/actions/actions-runner \
  && cd /home/actions/actions-runner \
  && wget https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz \
  && tar xzf ./actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz \
  && rm -rf ./actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz

WORKDIR /home/actions/actions-runner

RUN \
  chown -R actions ~actions \
  && /home/actions/actions-runner/bin/installdependencies.sh

USER actions

RUN mkdir /home/actions/actions-runner/workspace

COPY entrypoint.sh .

ENTRYPOINT ["./entrypoint.sh"]
