FROM gliderlabs/alpine

ENV NGINX_VERSION nginx-1.9.5

# Install dependencies
RUN apk --update add bind bash openssl-dev pcre-dev zlib-dev wget build-base && \
    mkdir -p /tmp/src && \
    cd /tmp/src && \
    wget http://nginx.org/download/${NGINX_VERSION}.tar.gz && \
    tar -zxvf ${NGINX_VERSION}.tar.gz && \
    cd /tmp/src/${NGINX_VERSION} && \
    ./configure \
        --with-http_ssl_module \
        --with-http_gzip_static_module \
        --prefix=/etc/nginx \
        --http-log-path=/var/log/nginx/access.log \
        --error-log-path=/var/log/nginx/error.log \
        --sbin-path=/usr/local/sbin/nginx && \
    make && \
    make install && \
    apk del build-base && \
    rm -rf /tmp/src && \
    rm -rf /var/cache/apk/*

ADD overlay /

# Configure nginx
RUN mkdir "/etc/nginx/sites-enabled" && \
    mkdir "/var/www" && \
    adduser -D -s /bin/false www-data && \
    ln -s /etc/nginx/sites-available/default.conf /etc/nginx/sites-enabled/default.conf

# Add our start script
ADD start.sh /root/start.sh
RUN chmod 777 /root/start.sh

# This container will be executable
WORKDIR /root/
ENTRYPOINT ["./start.sh"]