FROM alpine:3.7
RUN apk add --no-cache \
    git \
    autoconf \
    automake \
    libtool \
    binutils \
    build-base \
    coreutils \
    openssl-dev \
    libssh2-dev
RUN git clone \
    https://github.com/curl/curl.git \
    --depth 1 \
    --branch `git ls-remote --refs --tags https://github.com/curl/curl curl-\* | sort -t '/' -k 3 -V | tail -n1 | cut --delimiter='/' --fields=3`
WORKDIR /curl
RUN ./buildconf
RUN LDFLAGS="-static" PKG_CONFIG="pkg-config --static" ./configure \
    --disable-shared \
    --enable-static \
    --disable-ldap \
    --enable-ipv6 \
    --enable-unix-sockets \
    --with-ssl \
    --with-libssh2
RUN make \
    -j4 \
    V=1 \
    curl_LDFLAGS=-all-static
RUN strip src/curl
RUN ls -lah src/curl && ldd src/curl || true

FROM alpine:3.7
RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=0 /curl/src/curl /usr/bin/curl
ENTRYPOINT ["/usr/bin/curl"]
CMD [""]
