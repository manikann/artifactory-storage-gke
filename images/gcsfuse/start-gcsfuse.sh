#!/usr/bin/env bash

set -exuo pipefail

: ${GCS_FUSE_OPTS:=-o nonempty}
GCS_CREDENTIALS=/var/opt/gcs/key.json
MOUNT_POINT=/mnt/artifactory-volume/data/filestore

# run with given user
if [[ -f "${GCS_CREDENTIALS}" && ! -z "${BUCKET:-}" ]]
then
  mkdir -pv ${MOUNT_POINT}
  echo gcsfuse  --key-file ${GCS_CREDENTIALS} ${GCS_FUSE_OPTS} ${BUCKET} ${MOUNT_POINT}
  gcsfuse  --foreground --key-file ${GCS_CREDENTIALS} ${GCS_FUSE_OPTS} ${BUCKET} ${MOUNT_POINT}
else
  echo "GCS Credential file not found at {GCS_CREDENTIALS} or GCS Bucket not defined $BUCKET"
fi
