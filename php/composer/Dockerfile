# This image will be tagged with the name: anphabe/base:14.04
# - docker build -t devops/composer .
#

FROM composer:1.10.1

# composer will always store global-packages in /composer
ENV COMPOSER_HOME /composer

ENV COMPOSER_CACHE_DIR /composer_cache

RUN true \
&& composer global require hirak/prestissimo

# disable ssh host verification for git.anphabe.net domain
RUN echo $'\
Host git.vantt.net \n\
    StrictHostKeyChecking no \n\
    UserKnownHostsFile /dev/null \n\
' >> /etc/ssh/ssh_config
