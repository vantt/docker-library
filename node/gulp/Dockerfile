#
# Build images
#
# docker build -t devops/gulp .
#
# One time running
# docker run -it --rm --name gulp -v "$PWD":/data -v /etc/passwd:/etc/passwd:ro -v /etc/group:/etc/group:ro --user $(id -u):$(id -g) -w /data devops/gulp [command]
# docker run -it --rm --name gulp -v "$PWD":/data -v /etc/passwd:/etc/passwd:ro -v /etc/group:/etc/group:ro --user $(id -u):$(id -g) -w /data devops/gulp gulp compile
#
# Source: https://nodejs.org/en/docs/guides/nodejs-docker-webapp/
#
#

FROM node:6.10.3

# Add default mio user    

RUN apt-get update -qq && apt-get install -y build-essential
RUN apt-get install -y ruby ruby-dev
RUN gem update --system
RUN gem install sass
RUN gem install compass
RUN npm install -g gulp

    
# replace this with your application's default port
#EXPOSE 8888
#EXPOSE 3001
#EXPOSE 3000

CMD ["bash"]

