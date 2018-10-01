#!/bin/bash -e

if [ $# -ne 4 ]
then
    echo "usage: dockerfile_dir output_image_name output_image_version grant_bucket_read_to"
    exit 1
fi

DOCKERFILE_DIR=$1
OUTPUT_IMAGE_NAME=$2
OUTPUT_IMAGE_VERSION=$3
BUCKET_READ_PERMS=$4

OUTPUT_IMAGE=${OUTPUT_IMAGE_NAME}:${OUTPUT_IMAGE_VERSION}
TAR_FILE=${OUTPUT_IMAGE_NAME}${OUTPUT_IMAGE_VERSION}.tar
BUCKET_NAME=${OUTPUT_IMAGE_NAME}${OUTPUT_IMAGE_VERSION}

echo Docker build...
docker build -t ${OUTPUT_IMAGE} ${DOCKERFILE_DIR}

echo Docker save...
docker save -o  ${TAR_FILE} ${OUTPUT_IMAGE}

echo Create S3 bucket...
aws s3api create-bucket --bucket ${BUCKET_NAME} --acl private

echo Set S3 bucket perms...
aws s3api put-bucket-acl --bucket ${BUCKET_NAME} --grant-read ${BUCKET_READ_PERMS}

echo Upload to S3 bucket...
aws s3api put-object --bucket ${BUCKET_NAME} --body ${TAR_FILE} --key $(basename ${TAR_FILE}) --grant-read ${BUCKET_READ_PERMS}

echo Done

