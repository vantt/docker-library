FROM devops/composer:1.10.1 as builder
MAINTAINER Julien Breux <julien.breux@gmail.com>

# Run composer and phpspec installation.
RUN composer selfupdate && \
  composer global require "phpspec/phpspec:~6.1.1" && \
  ln -s /composer/vendor/bin/phpspec /usr/local/bin/phpspec

FROM devops/phpcli:7.4.4

COPY --from=builder /composer /composer

USER root
RUN ln -s /composer/vendor/bin/phpspec /usr/local/bin/phpspec && \
    ln -s /composer/vendor/bin/phpspec /phpspec
USER ${HOST_USER_NAME}


# Set up the application directory.
VOLUME ["/app"]
WORKDIR /app

# Set up the command arguments.
ENTRYPOINT ["/usr/local/bin/phpspec"]
CMD ["--help"]
