FROM ruby:2.6.6

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update -qq \
    && apt-get install -qq -y nodejs yarn \
    && mkdir /Sharing_Portfolio

WORKDIR /Sharing_Portfolio

COPY Gemfile /Sharing_Portfolio/Gemfile
COPY Gemfile.lock /Sharing_Portfolio/Gemfile.lock
RUN gem install bundler
RUN bundle install
COPY . /Sharing_Portfolio
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
