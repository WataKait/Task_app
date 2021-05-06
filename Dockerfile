FROM ruby:2.6.3

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        postgresql-client \
        vim zsh less \
    && rm -rf /var/lib/apt/lists/*

RUN chsh -s /usr/bin/zsh

# RUN bundle install
# RUN bundle exec rake db:create
# RUN bundle exec rake db:migrate