FROM microsoft/dotnet:2.2.1-aspnetcore-runtime-alpine3.8

RUN echo https://dl-cdn.alpinelinux.org/alpine/edge/testing >>/etc/apk/repositories 

ENV CURL_VERSION 7.50.1

RUN apk add --update --no-cache openssl openssl-dev ca-certificates
RUN apk add --update --no-cache --virtual curldeps g++ make perl && \
    wget https://curl.haxx.se/download/curl-$CURL_VERSION.tar.bz2 && \
    tar xjvf curl-$CURL_VERSION.tar.bz2 && \
    rm curl-$CURL_VERSION.tar.bz2 && \
    cd curl-$CURL_VERSION && \
    ./configure \
        --prefix=/usr \
        --with-ssl \
	--without-nghttp2 \
	--with-gssapi \
        --without-libidn \
        --disable-static \
        --disable-ldap \
        --with-pic && \
    make && \
    make install && \
    cd / && \
    rm -r curl-$CURL_VERSION && \
    rm -r /var/cache/apk && \
    rm -r /usr/share/man && \
    apk del curldeps


RUN addgroup -g 1000 -S appuser && adduser -u 1000 -S appuser -G appuser
USER appuser

CMD ["curl"]
