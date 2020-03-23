# docker-phpunit

### Build docker

`docker build -t devops/phpunit .`


### Add command to your bash profile

```
phpunit () {
    tty=
    tty -s && tty=--tty
    docker run \
        $tty \
        --interactive \
        --rm \
        --volume $(dirname $SSH_AUTH_SOCK):$(dirname $SSH_AUTH_SOCK) \
        --volume $(pwd):/app \
        --volume /etc/passwd:/etc/passwd:ro \
        --volume /etc/group:/etc/group:ro \
        --user $(id -u):$(id -g) \
        --env SSH_AUTH_SOCK=$SSH_AUTH_SOCK \
        devops/phpunit "$@"
}
```


