FROM alpine:3.7
RUN apk update && apk add krb5
RUN addgroup -g 1000 -S appuser && adduser -u 1000 -S appuser -G appuser
USER appuser
