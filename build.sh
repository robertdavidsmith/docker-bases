#!/bin/bash -e

if [ $# -ne 3 ]
then
    echo "usage: dockerfile_dir output_image_name output_image_version"
    exit 1
fi

DOCKERFILE_DIR=$1
OUTPUT_IMAGE_NAME=$2
OUTPUT_IMAGE_VERSION=$3

OUTPUT_IMAGE=${OUTPUT_IMAGE_NAME}:${OUTPUT_IMAGE_VERSION}
TAR_FILE=${OUTPUT_IMAGE_NAME}${OUTPUT_IMAGE_VERSION}.tar
BUCKET_NAME=${OUTPUT_IMAGE_NAME}${OUTPUT_IMAGE_VERSION}

echo Docker build...
docker build -t ${OUTPUT_IMAGE} ${DOCKERFILE_DIR}

echo Docker save...
docker save -o  ${TAR_FILE} ${OUTPUT_IMAGE}

echo Creating S3 bucket ${BUCKET_NAME}...
aws s3api create-bucket --bucket ${BUCKET_NAME} --acl private

echo Upload to S3 bucket...
KEY=$(basename ${TAR_FILE})
aws s3api put-object --bucket ${BUCKET_NAME} --body ${TAR_FILE} --key ${KEY}

echo Give public read perms on bucket...
aws s3api put-object-acl --bucket ${BUCKET_NAME} --key ${KEY} --acl public-read

echo Done

