FROM ruby:3.1.1-alpine

RUN apk --update add build-base tzdata postgresql-dev postgresql-client

ENV APP_DIR /core

WORKDIR $APP_DIR

COPY Gemfile ./
COPY Gemfile.lock ./

ARG RAILS_ENV
ENV RACK_ENV=$RAILS_ENV

RUN gem install bundler

RUN bundle install

COPY . ./

EXPOSE 80

ENV PORT 80

CMD bundle exec rails db:migrate && rails s -p 80 -b '0.0.0.0'
