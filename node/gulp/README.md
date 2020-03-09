# Build images
docker build -t devops/gulp .

# One time running
docker run -it --rm --name gulp -v "$PWD":/data -v /etc/passwd:/etc/passwd:ro -v /etc/group:/etc/group:ro --user $(id -u):$(id -g) -w /data devops/gulp [command]
docker run -it --rm --name gulp -v "$PWD":/data -v /etc/passwd:/etc/passwd:ro -v /etc/group:/etc/group:ro --user $(id -u):$(id -g) -w /data devops/gulp gulp compile

# Source: 
https://nodejs.org/en/docs/guides/nodejs-docker-webapp/

# Add the following to your ~/.bashrc

```
function rungulp () {
    docker run -it --rm --name gulp -v "$HOME":"$HOME" -v "$PWD":/data -v /etc/passwd:/etc/passwd:ro -v /etc/group:/etc/group:ro --user $(id -u):$(id -g) -w /data devops/gulp
}
```
