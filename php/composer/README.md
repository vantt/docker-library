# php-composer

### Please read:

> https://hub.docker.com/_/composer/


### Build docker 

```
docker build -t devops/composer .

### To run docker

## Add the following to your ~/.bashrc

```
composer () {
    CACHE_FOLDER=~/.composer
    
    if [[ ! -d $CACHE_FOLDER ]]; then       
        mkdir -p $CACHE_FOLDER;
    fi
    
    tty=
    tty -s && tty=--tty
    docker run \
        $tty \
        --interactive \
        --rm \
        --volume $CACHE_FOLDER:/composer_cache \
        --volume $(pwd):/app \
        --volume $(dirname $SSH_AUTH_SOCK):$(dirname $SSH_AUTH_SOCK) \
        --volume /etc/passwd:/etc/passwd:ro \
        --volume /etc/group:/etc/group:ro \
        --user $(id -u):$(id -g) \
        --env SSH_AUTH_SOCK=$SSH_AUTH_SOCK \
        devops/composer "$@" --prefer-source --verbose --ignore-platform-reqs
}
```

```
composer2 () { 
    CACHE_FOLDER=~/.composer
    
    if [[ ! -d $CACHE_FOLDER ]]; then       
        mkdir -p $CACHE_FOLDER;
    fi
    
    
    tty=
    tty -s && tty=--tty
    docker run \
        $tty \
        --interactive \
        --rm \
        --volume $CACHE_FOLDER:/composer_cache \
        --volume $(pwd):/app \
        --volume $(dirname $SSH_AUTH_SOCK):$(dirname $SSH_AUTH_SOCK) \
        --volume /etc/passwd:/etc/passwd:ro \
        --volume /etc/group:/etc/group:ro \
        --user $(id -u):$(id -g) \
        --env SSH_AUTH_SOCK=$SSH_AUTH_SOCK \
        devops/composer "$@" --verbose
}
```

### To by-pass php-extension or required scripts

> Pass the `--ignore-platform-reqs` and `--no-scripts` flags to install or update
