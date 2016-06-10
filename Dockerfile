FROM node:0.12

# set default java environment variable
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle/
RUN echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" | tee /etc/apt/sources.list.d/webupd8team-java.list && \
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886 &&  \
echo debconf shared/accepted-oracle-license-v1-1 select true |  debconf-set-selections && \
echo debconf shared/accepted-oracle-license-v1-1 seen true |  debconf-set-selections && \
apt-get update && \
apt-get install -y --no-install-recommends oracle-java8-installer && \
apt-get install -y --no-install-recommends apt-utils oracle-java8-set-default

RUN npm install -g cordova && npm install -g ionic

RUN apt-get install -y rubygems && gem install sass && npm install -g node-sass
RUN npm install -g bower gulp
