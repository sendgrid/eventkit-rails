# FROM heroku/ruby

FROM ruby:2.1.10-slim
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs libsqlite3-dev
RUN mkdir /myapp
WORKDIR /myapp
ADD Gemfile /myapp/Gemfile
ADD Gemfile.lock /myapp/Gemfile.lock
RUN bundle install
ADD . /myapp
