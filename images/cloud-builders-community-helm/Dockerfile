FROM gcr.io/cloud-builders/gcloud

ARG BUILD_DATE
ARG COMMIT_SHA
ARG HELM_VERSION=v2.13.1
ARG YQ_VERSION=2.3.0
ARG KUBEVAL_VERSION=0.7.3

LABEL maintainer="manikandan.natarajan@anz.com" \
      org.label-schema.vcs-ref=$COMMIT_SHA \
      org.label-schema.build-date=$BUILD_DATE

COPY helm.bash helm-${HELM_VERSION}-linux-amd64.tar.gz.sha256 yq-${YQ_VERSION}-linux-amd64.sha256 kubeval-${KUBEVAL_VERSION}.sha256 /builder/

RUN set -ex \
    && cd /tmp \
    && curl -sSflL https://storage.googleapis.com/kubernetes-helm/helm-${HELM_VERSION}-linux-amd64.tar.gz \
              | tee helm.tar.gz \
              | sha256sum -c /builder/helm-${HELM_VERSION}-linux-amd64.tar.gz.sha256 \
    && tar -xvzf helm.tar.gz \
    && mv linux-amd64/helm /usr/local/bin \
    && curl -sSflL https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/yq_linux_amd64 \
              | tee /usr/local/bin/yq \
              | sha256sum -c /builder/yq-${YQ_VERSION}-linux-amd64.sha256 \
    && curl -sSflL https://github.com/garethr/kubeval/releases/download/${KUBEVAL_VERSION}/kubeval-linux-amd64.tar.gz \ 
              | tee kubeval.tar.gz \
              | sha256sum -c /builder/kubeval-${KUBEVAL_VERSION}.sha256 \
    && tar -xvzf kubeval.tar.gz \
    && mv kubeval /usr/local/bin \
    && chmod +x /usr/local/bin/yq /builder/helm.bash  /usr/local/bin/kubeval /usr/local/bin/helm \
    && apt-get update \
    && apt-get install -y jq \
    && apt-get --purge -y autoremove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/*.gz \
    && helm version --client \
    && yq -V \
    && jq --version \
    && kubeval --version

ENTRYPOINT ["/builder/helm.bash"]
