# How to use

```
volumes:
    #    # this is for Native Linux (Ubuntu)
    #    appVolume:
    #        driver: local
    #        driver_opts:
    #            type: bind
    #            device: ${PROJECT_FOLDER}
    #            o: bind

    # this is for MacOS
    appVolume:
        driver: local
        driver_opts:
            type: nfs
            o: addr=host.docker.internal,rw,nolock,hard,nointr,nfsvers=3
            device: ":/System/Volumes/Data/$PWD/${PROJECT_FOLDER}"

services:
    nginx:
        image: devops/nginx:1.17.9
        ports:
            - 8080:8080 # dont need to expose here since traefik will do forwarding
        depends_on:
            - php
        volumes:
            - ./nginx-vhost.conf:/etc/nginx/conf.d/localhost.conf
            - appVolume:/app

```

# Nginx Configuration Overwrite Structure Explain;

https://www.digitalocean.com/community/tutorials/understanding-the-nginx-configuration-file-structure-and-configuration-contexts


```

# MAIN CONTEXT
# The main context is here, outside any other contexts

. . .

events {

    # events context
    . . .

}

http {
    # http context

    # http context

    upstream upstream_name {

        # upstream context

        server proxy_server1;
        server proxy_server2;

        . . .

    }

    server {

        #  server context

        . . . .
    }

    server {

        # second server context

    }

    server {

        # server context

        location match_modifier location_match {

            # location context
            . . .

        }

        # server context

        location /match/criteria {

            # first location context

            if (test_condition) {

                # if context

            }

        }

        location /other/criteria {

            # second location context

            location nested_match {

                # first nested location

            }

            location other_nested {

                # second nested location

            }

        }
    } 

}


mail {

    # mail context

}

```