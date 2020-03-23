## Implement a self-signed https-proxy using docker

### Build container nginx_proxy

```
git clone https://github.com/vantt/dockerfile

cd dockerfile/https-proxy

docker build -t vantt/https-proxy .

```

### Create network

```
docker network create --driver=bridge --subnet=172.21.0.0/16 --gateway=172.21.0.1 https-proxy
```

### Run docker from AWS Registry

```
docker run -d --restart=always --name=https-proxy --network=https-proxy -v /var/run/docker.sock:/tmp/docker.sock:ro -p 80:80 -p 443:443 -e VIRTUAL_PROTO=https 756239576923578463.dkr.ecr.us-west-2.amazonaws.com/devops/https-proxy:latest
```

### Run docker from local image
```
docker run -d --restart=always --name=https-proxy --network=https-proxy -v /var/run/docker.sock:/tmp/docker.sock:ro -p 80:80 -p 443:443 -e VIRTUAL_PROTO=https -e VIRTUAL_PORT=443 devops/nginx-proxy
```

### Run dnsmasq proxy for domain .mio

```
docker run -d --restart=always --name=dnsmasq --network=https-proxy --cap-add=NET_ADMIN -p 127.0.0.53:53:53/tcp -p 127.0.0.53:53:53/udp -p 127.0.0.1:53:53/tcp -p 127.0.0.1:53:53/udp -p 192.168.68.171:53:53/tcp -p 192.168.68.171:53:53/udp andyshinn/dnsmasq:2.78 --address=/mio/192.168.68.178 --server=192.168.68.207 --server=192.168.68.206
```

### Install RootCA for browser

**ex**: Chrome browser

Setting -> HTTPS/SSL -> Manage certificates -> choose tab Authorities -> Import rootCA.pem in directory  $PWD/https-proxy/certs -> check all of options.
