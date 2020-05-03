FROM alpine

COPY ./myCA.pem /usr/local/share/ca-certificates/myCA.crt

RUN set -xe \
	&& apk add --update curl openssl ca-certificates && rm -rf /var/cache/apk/* 

RUN update-ca-certificates \
	&& cat /etc/ssl/certs/ca-certificates.crt 

# COPY myCA.pem /usr/share/ca-certificates/extra/myCA.pem  
# RUN echo "extra/myCA.pem" >> /etc/ca-certificates.conf \
# 	&& /usr/sbin/update-ca-certificates --fresh \
# 	&& cat /etc/ssl/certs/ca-certificates.crt