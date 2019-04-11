#!/bin/bash

set -xeuo pipefail

RANDOM_SUFFIX=$(hexdump -n 3 -e '"%06X" 1 "\n"' /dev/random | tr '[:upper:]' '[:lower:]')
PROJECT_ID=${1}-${RANDOM_SUFFIX}
gcloud projects create ${PROJECT_ID} --name $1

gcloud beta billing projects link $PROJECT_ID \
  --billing-account=$(gcloud beta billing  accounts list   --format="value(name)" --filter open=true)

#SA_NAME=terraform
#gcloud --project=$PROJECT_ID iam service-accounts create $SA_NAME --display-name=$SA_NAME
#SA_EMAIL=$(gcloud --project=$PROJECT_ID iam service-accounts list --format="value(email)" --filter displayName=terraform)
#gcloud projects add-iam-policy-binding $PROJECT_ID --role roles/owner --member serviceAccount:$SA_EMAIL
#gcloud --project=$PROJECT_ID iam service-accounts keys create terraform.${PROJECT_ID}.json --iam-account=$SA_EMAIL

gcloud --project $PROJECT_ID services enable iam.googleapis.com
gcloud --project $PROJECT_ID services enable cloudresourcemanager.googleapis.com
gcloud --project $PROJECT_ID services enable cloudbuild.googleapis.com
gcloud --project $PROJECT_ID services enable compute.googleapis.com
gcloud --project $PROJECT_ID services enable container.googleapis.com
gcloud --project $PROJECT_ID services enable pubsub.googleapis.com
gcloud --project $PROJECT_ID services enable storage-api.googleapis.com
gcloud --project $PROJECT_ID services enable servicenetworking.googleapis.com
