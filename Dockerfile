FROM ruby:3.1.1-alpine

RUN apk --update add build-base tzdata postgresql-dev postgresql-client bash

ENV APP_DIR /core

WORKDIR $APP_DIR

COPY Gemfile ./
COPY Gemfile.lock ./

ARG RAILS_ENV
ENV RACK_ENV=$RAILS_ENV

RUN gem install bundler

RUN if [[ "$RAILS_ENV" == "production" ]]; then bundle install --without development test; else bundle install; fi

COPY . ./

EXPOSE 80

ENV PORT 80

CMD bundle exec rails s -b '0.0.0.0'