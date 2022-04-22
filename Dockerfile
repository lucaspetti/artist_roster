FROM ruby:2.6.3 AS artist_roster

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update -qq && apt-get install -y nodejs yarn postgresql-client && gem install bundler

WORKDIR /artist_roster

COPY Gemfile /artist_roster/Gemfile
COPY Gemfile.lock /artist_roster/Gemfile.lock

RUN bundle install

COPY package.json /artist_roster/package.json
COPY yarn.lock /artist_roster/yarn.lock

RUN yarn install

COPY entrypoint.sh /usr/bin
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]