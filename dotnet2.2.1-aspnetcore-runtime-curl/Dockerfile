FROM microsoft/dotnet:2.2.1-aspnetcore-runtime

#ENV CURL_VERSION 7.50.1
ENV CURL_VERSION 7.46.0

RUN apt-get update && \
    apt-get -y install wget bzip2 openssl  ca-certificates libgss-dev && \
    apt-get -y install g++ make perl && \
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
    apt-get remove -y wget bzip2 make perl g++ && \
    apt-get clean -y

#RUN addgroup -g 1000 -S appuser && adduser -u 1000 -S appuser -G appuser
#USER appuser

CMD ["dotnet"]
