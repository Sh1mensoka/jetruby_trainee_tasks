FROM ruby:2.7

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client yarn

WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN bundle config build.nokogiri --use-system-libraries

RUN bundle check || bundle install

ENTRYPOINT ["./entrypoints/docker-entrypoint.sh"]

