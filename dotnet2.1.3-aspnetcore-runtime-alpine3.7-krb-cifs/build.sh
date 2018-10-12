#!/bin/bash -e

if [ $# -ne 1 ]
then
    echo "usage: grant_bucket_read_to"
    exit 1
fi

BUCKET_READ_PERMS=$1

$(dirname $0)/../build.sh $(dirname $0) dotnet 2.1.3-aspnetcore-runtime-alpine3.7-krb-cifs  ${BUCKET_READ_PERMS}
