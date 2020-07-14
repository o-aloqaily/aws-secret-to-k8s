#!/bin/bash
NAMESPACE=$1
SECRET_NAME=$2
AWS_SECRET_NAME=$2
AWS_REGION=$3
AWS_PROFILE=$4
kubectl -n $NAMESPACE create secret generic $SECRET_NAME --from-env-file=<(aws secretsmanager get-secret-value --secret-id $AWS_SECRET_NAME --region $AWS_REGION --profile $AWS_PROFILE | jq -r '.SecretString' | jq -r 'to_entries | .[] | .key + "=" + (.value|tostring)')