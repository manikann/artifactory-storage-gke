#!/usr/bin/env bash

set -exuo pipefail

: ${GCS_FUSE_OPTS:=-o nonempty}
: ${GCS_CREDENTIALS:=${ARTIFACTORY_DATA}/artifactory-gcs-sa.json}

LOGDIR=${ARTIFACTORY_DATA}/logs
mkdir -pv $LOGDIR

LOGFILE=${LOGDIR}/gcsfuse.log
touch $LOGFILE

# run with given user
if [[ -f "${GCS_CREDENTIALS}" && ! -z "${BUCKET:-}" ]]; then
  nohup gcsfuse --temp-dir /tmp --foreground --key-file ${GCS_CREDENTIALS} ${GCS_FUSE_OPTS} ${BUCKET} /mnt/gcsfuse >> $LOGFILE 2>&1 &
else
  echo "GCS Credential file not found at {GCS_CREDENTIALS} or GCS Bucket not defined $BUCKET"
fi
