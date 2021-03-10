# Docker PHP-FPM

## Introduction

This docker is inspired from: https://github.com/alterway/docker-php/blob/master/doc-php-fpm.md

The default workdir is `/app`.
The entrypoint start php-fpm and expose port `9000`

## Environment variables

### Load PHP Extensions

The PHP Extensions are load on start. Just add environment variable `PHP_phpenmod` with list of your extensions

Example with docker-compose :

    ...
    environment:
        PHP_phpenmod: 'phalcon rdkafka'


### Set your php.ini

The php configuration is dynamic. Just add environment variable with prefix `PHP__`.

Example with docker-compose :

    ...
    environment:
        PHP__display_errors: 'On'
        PHP__opcache.enable: 'Off'
        PHP__memory_limit:   '128M'
        PHP__post_max_size:  '50M'
        PHP__date.timezone:  '"Asia/Ho_Chi_Minh"'

### Set your php-fpm.conf

The php-fpm configuration is dynamic. Just add environment variable with prefix : `PHPFPM__` and `PHPFPM_GLOBAL__`.

Example with docker-compose :

     environment:
        PHPFPM_GLOBAL__pm: dynamic
        PHPFPM_GLOBAL__pm.max_children: 5
        PHPFPM_GLOBAL__pm.start_servers: 2
        PHPFPM_GLOBAL__pm.min_spare_servers: 1
        PHPFPM_GLOBAL__pm.max_spare_servers: 3
        PHPFPM__access.format '"%R - %u [%t] \"%m %r\" %s %l %Q %f"'


### Advanced Environment variables

#### https://binfalse.de/2020/02/17/migrating-from-ssmtp-to-msmtp/

- `SMTP` : set address of mail server (Format `address:port`)
- `PHP__blackfire.agent_socket` : set address of blackfire agent (Format `tcp://address:port`)

Example with docker-compose :

    ...
    environment:
       SMTP:                           'mailcatcher_1:25'
       PHP__blackfire.agent_socket:    'tcp://blackfire:8707'


# docker-phpcli
docker build -f Dockerfile-7.4 -t devops/phpfpm:7.4 .

add this line to your bash_profile file

```
php () {
    tty=
    tty -s && tty=--tty
    docker run \
        $tty \
        --interactive \
        --rm \
        --volume $(pwd):/app \
        --volume $(dirname $SSH_AUTH_SOCK):$(dirname $SSH_AUTH_SOCK) \
        --volume /etc/passwd:/etc/passwd:ro \
        --volume /etc/group:/etc/group:ro \
        --user $(id -u):$(id -g) \
        --env SSH_AUTH_SOCK=$SSH_AUTH_SOCK \
        devops/phpfpm:latest "$@"
}
```
