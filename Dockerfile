FROM ubuntu:jammy

SHELL ["/bin/bash", "-c"]

ARG DEBIAN_FRONTEND=noninteractive

RUN : \
    && apt-get -y update \
    && apt-get -y install \
        apache2 \
        imagemagick \
        php \
        php-gd \
        php-mbstring \
        php-mysql \
        php-xml \
    && rm -rf /var/lib/apt/lists/*

RUN : \
    && ln -sf /proc/self/fd/1 /var/log/apache2/access.log \
    && ln -sf /proc/self/fd/1 /var/log/apache2/error.log

WORKDIR /tmp/phpBB3

COPY phpBB3/ .

RUN : \
    && chown -R www-data:www-data . \
    && chmod 660 images/avatars/upload/ config.php \
    && chmod 770 store/ cache/ files/

EXPOSE 80

VOLUME ["/var/www/html"]

CMD ["apachectl", "-D", "FOREGROUND"]
