FROM ubuntu:14.04
MAINTAINER Cassius Chen "chzsh1995@gmail.com"
RUN apt-get update
RUN apt-get -y install gcc g++ make automake autoconf mongodb postgresql-contrib-9.3 libpq-dev imagemagick redis-server openssh-server curl wget nginx git-core
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
RUN \curl -sSL https://get.rvm.io | bash -s stable
RUN ["/bin/bash", "--login"]
RUN rvm install 2.2.2
WORKDIR /tmp
RUN wget http://cache.ruby-lang.org/pub/ruby/2.2/ruby-2.2.2.tar.gz
RUN tar-zxvf ruby-2.2.2.tar.gz
WORKDIR /tmp/ruby-2.2.2
RUN ["./configure"]
RUN make -j2
RUN make install -j2
RUN ruby -v
EXPOSE 80
EXPOSE 22
