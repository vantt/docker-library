# PHPUnit Docker Container.
FROM alpine as builder

ARG PHPUNIT_VERSION=9.0.1

RUN echo 'BEGIN' \
    && set -xe \ 
    && wget https://phar.phpunit.de/phpunit-${PHPUNIT_VERSION}.phar -O /usr/local/bin/phpunit \
    && chmod +x /usr/local/bin/phpunit
    
########################

FROM vantt/phpcli:7.4.4

ARG WORKDIRECTORY=/app

ARG HOST_USER_UID=1000
ARG HOST_USER_GID=1000
ARG HOST_USER_NAME=www
ARG HOST_GROUP_NAME=www

COPY --from=builder /usr/local/bin/phpunit /usr/local/bin/phpunit
RUN /usr/local/bin/phpunit --version

VOLUME ["${WORKDIRECTORY}"]

WORKDIR ${WORKDIRECTORY}

USER ${HOST_USER_NAME}

ENTRYPOINT ["/usr/local/bin/phpunit"]
