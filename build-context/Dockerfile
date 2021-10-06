FROM ubuntu:18.04

ARG RUNNER_VERSION
ARG USER_ID
ARG GROUP_ID

ENV RUNNER_VERSION=${RUNNER_VERSION}

RUN groupadd -g ${GROUP_ID} actions

RUN useradd -m actions -u ${USER_ID} -g ${GROUP_ID}

RUN apt-get -yqq update && apt-get install -yqq curl jq wget

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
