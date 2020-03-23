#!/bin/bash

#### Build ###
# docker build -t devops/nginx-proxy .

FROM jwilder/nginx-proxy:latest

COPY /certs /etc/nginx/certs

RUN { \
      echo 'client_max_body_size 10M;'; \
      echo 'proxy_read_timeout 600;'; \
    } > /etc/nginx/conf.d/mio.conf



