FROM ruby:2.6.3 AS distrokid_admin

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update -qq && apt-get install -y nodejs yarn postgresql-client && gem install bundler

WORKDIR /distrokid_admin

COPY Gemfile /distrokid_admin/Gemfile
COPY Gemfile.lock /distrokid_admin/Gemfile.lock

RUN bundle install

COPY package.json /distrokid_admin/package.json
COPY yarn.lock /distrokid_admin/yarn.lock

RUN yarn install

COPY entrypoint.sh /usr/bin
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]