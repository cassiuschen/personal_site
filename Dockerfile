FROM ubuntu:14.04
MAINTAINER Cassius Chen "chzsh1995@gmail.com"
RUN apt-get update
RUN apt-get -y install gcc g++ make automake autoconf imagemagick redis-server openssh-server curl wget nginx git-core
WORKDIR /tmp
RUN wget http://cache.ruby-lang.org/pub/ruby/2.2/ruby-2.2.2.tar.gz
RUN tar -zxvf ruby-2.2.2.tar.gz
WORKDIR /tmp/ruby-2.2.2
RUN ["./configure"]
RUN make -j2
RUN make install -j2
RUN ruby -v
ADD config/nginx.conf /etc/nginx/conf.d/personal_site.conf
RUN mkdir -pv /var/data
WORKDIR /var/data
ADD ./ /var/data/personal_site
WORKDIR /var/data/personal_site
RUN mkdir -pv tmp/{pids,sockets}
ENV RAILS_ENV docker
RUN bundle install -V
RUN chmod 777 start
EXPOSE 80

CMD ["/var/data/personal_site/start"]
