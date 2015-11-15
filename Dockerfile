FROM ruby:2.2.3

# date ASIA
RUN ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
#ENV BUNDLE_APP_CONFIG=.bundle
ENV RAILS_ENV=production
#ENV RAILS_SERVE_STATIC_FILES=/public
#ENV RUBYGEMS_GEMDEPS=-

# 
RUN apt-get update -qq && apt-get install -y git build-essential libpq-dev cron vim

# supervisoer
RUN apt-get install -y supervisor

# ruby


# rails files
RUN mkdir /home/rails
RUN mkdir /home/rails/rails_dev_bot
WORKDIR   /home/rails/rails_dev_bot
ADD ./Gemfile Gemfile
ADD ./Gemfile.lock Gemfile.lock

RUN bundle install -j4 --path vendor/bundle  --without test development

ADD . /home/rails/rails_dev_bot


# RUN rake assets:precompile


ENTRYPOINT /usr/bin/supervisord -c config/supervisord.conf
