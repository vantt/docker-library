FROM nginx:1.19.3-alpine

ARG HOST_USER_UID=1000
ARG HOST_USER_GID=1000
ARG HOST_USER_NAME=www
ARG HOST_GROUP_NAME=www

RUN set -xe \
	&& echo 'Creating notroot user and group from host' \
	&& addgroup -g ${HOST_USER_GID} -S ${HOST_GROUP_NAME}                      \
	&& adduser  -u ${HOST_USER_UID} -D -S -G ${HOST_GROUP_NAME} ${HOST_USER_NAME} \	
	&& mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.orig  \	
	&& mkdir -p /etc/nginx/sites-enabled \
	&& mkdir -p /etc/nginx/sites-available 	

COPY etc/nginx /etc/nginx/
WORKDIR /app

