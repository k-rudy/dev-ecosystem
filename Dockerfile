FROM ruby:2.6

MAINTAINER Konstantin Rudy <konstantin.rudy@gmail.com>

ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

RUN apt-get update -y && \
    apt-get install -y cmake libssl-dev postgresql-client-9.6

ENV APP_HOME /usr/src/app
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

COPY Gemfile $APP_HOME
COPY Gemfile.lock $APP_HOME

RUN gem update --system
RUN bundle install -j 8
RUN apt-get update && apt-get install -y vim

COPY . $APP_HOME
