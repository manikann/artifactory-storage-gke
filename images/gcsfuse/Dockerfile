FROM debian:jessie-slim

ENV GCSFUSE_REPO gcsfuse-jessie

COPY start-gcsfuse.sh /

RUN apt-get update \
    && apt-get install --yes --no-install-recommends ca-certificates curl \
    && echo "deb http://packages.cloud.google.com/apt $GCSFUSE_REPO main" | tee /etc/apt/sources.list.d/gcsfuse.list \
    && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - \
    && apt-get update \
    && apt-get install --yes gcsfuse \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && chmod +x /start-gcsfuse.sh \
    && groupadd --system --gid 1030 artifactory \
    && useradd --create-home --system --uid 1030 --gid artifactory --groups root artifactory \
    && mkdir -pv /mnt/artifactory-volume \
    && chown -R artifactory:artifactory /mnt/artifactory-volume

USER artifactory

CMD [ "/start-gcsfuse.sh" ]
