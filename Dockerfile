FROM nginx:alpine

# ensure www-data user exists
RUN set -x ; \
  addgroup -g 82 -S www-data ; \
  adduser -u 82 -D -S -G www-data www-data && exit 0 ; exit 1

# Install packages
RUN apk upgrade --update && apk add --no-cache \
        bash \
        py-pip \
    && pip install --upgrade pip && pip install j2cli --no-cache-dir

COPY templates /etc/nginx/templates
WORKDIR /usr/share/nginx/html

ADD docker-entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
