FROM microsoft/dotnet:2.1.3-runtime-alpine3.7
RUN apk update && apk add krb5
RUN addgroup -g 1000 -S appuser && adduser -u 1000 -S appuser -G appuser
USER appuser
