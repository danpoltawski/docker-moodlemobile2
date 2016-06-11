FROM node:0.12

# Add Java..
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle/
RUN echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" | tee /etc/apt/sources.list.d/webupd8team-java.list && \
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886 &&  \
echo debconf shared/accepted-oracle-license-v1-1 select true |  debconf-set-selections && \
echo debconf shared/accepted-oracle-license-v1-1 seen true |  debconf-set-selections && \
apt-get update && \
apt-get install -y --no-install-recommends oracle-java8-installer && \
apt-get install -y --no-install-recommends apt-utils oracle-java8-set-default

# Install cordova and ionic
RUN npm install -g cordova && npm install -g ionic

# Install some moodlemobile2 defaults
RUN apt-get install -y rubygems && gem install sass && npm install -g node-sass
RUN npm install -g bower gulp

# Put moodlemobile2 in /srv (this is probably better to be mounted from host, but in
# my testing the mounting from my local system wasn't playing nice with watch). Plus I
# just want to use this for developing a plugin (which i'll mount locally :))
RUN  curl -SLO https://github.com/moodlehq/moodlemobile2/archive/v3.1.0.tar.gz && \
tar -xzf v3.1.0.tar.gz -C /srv --strip-components 1
WORKDIR /srv/
RUN npm install
RUN bower install --allow-root && npm rebuild node-sass
EXPOSE 8100 35729
VOLUME ["/srv"]
CMD ["ionic", "serve"]
