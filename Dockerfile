FROM ruby:2.6.3

RUN apt-get update \
  && apt-get -y upgrade \
  && apt-get -fy install tzdata git build-essential \
    patch zlib1g-dev liblzma-dev libcurl4-openssl-dev \
  && apt-get clean

RUN cp /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime

RUN mkdir /usr/src/app

WORKDIR /usr/src/app

RUN gem install bundler
ADD Gemfile Gemfile.lock ./

RUN bundle install
ADD . /usr/src/app

RUN bin/rake assets:precompile
