FROM ruby:2.6.5-alpine

RUN apk add --no-cache sqlite sqlite-dev g++ musl-dev make

RUN bundle config --global frozen 1

WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN bundle install

COPY . .

EXPOSE 3000

CMD ["bundle","exec", "thin", "start"]
