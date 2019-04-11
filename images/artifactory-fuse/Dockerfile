ARG ARTIFACTORY_VERSION
FROM docker.bintray.io/jfrog/artifactory-pro:${ARTIFACTORY_VERSION}

USER root

COPY --chown=artifactory:artifactory start-gcsfuse.sh /start-gcsfuse.sh

RUN set -x \
    && apt-get update  \
    && apt-get install -y curl lsb-release sudo rsync \
    && export GCSFUSE_REPO=gcsfuse-`lsb_release -c -s` \
    && echo "deb http://packages.cloud.google.com/apt $GCSFUSE_REPO main" | tee /etc/apt/sources.list.d/gcsfuse.list \
    && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - \
    && apt-get update  \
    && apt-get install -y gcsfuse \
    && gcsfuse -v \
    && chmod +x /start-gcsfuse.sh \
    && rm -vrf /var/lib/apt/lists/* \
    && mkdir -pv /mnt/gcsfuse \
    && chown -R artifactory:artifactory /mnt/gcsfuse

USER artifactory

CMD ["/start-gcsfuse.sh"]

