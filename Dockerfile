FROM ruby:2.6

MAINTAINER Konstantin Rudy <konstantin.rudy@gmail.com>

ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

# The next 7 lines are needed to fix hash checksum issues for Kon when fetching dependencies.
# Please ping Kon (kon@profinda.com) to recheck when you decide to remove them
RUN echo 'Acquire::http::Pipeline-Depth 0; \
          Acquire::http::No-Cache true; \
          Acquire::CompressionTypes::Order:: "gz"; \
          Acquire::BrokenProxy    true;' > /etc/apt/apt.conf.d/99fixbadproxy
RUN echo "deb http://ftp.uk.debian.org/debian stretch main" > /etc/apt/sources.list
RUN echo "deb http://ftp.uk.debian.org/debian stretch-updates main" >> /etc/apt/sources.list

RUN apt-get update -y && \
    apt-get install -y cmake libcurl3 libtinfo5 libssl-dev postgresql-client

ENV APP_HOME /usr/src/app
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

COPY Gemfile $APP_HOME
COPY Gemfile.lock $APP_HOME

RUN gem update --system
RUN bundle update --bundler
RUN bundle install -j 8
RUN apt-get update && apt-get install -y vim

COPY . $APP_HOME
