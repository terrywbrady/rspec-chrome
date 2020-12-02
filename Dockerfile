FROM ruby:2.7

RUN gem install bundler

COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock

RUN bundle install

COPY . .

RUN chmod 777 .

CMD ["bundle", "exec", "rspec", "spec"]
