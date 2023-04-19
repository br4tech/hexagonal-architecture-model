FROM ruby:2.7.0

RUN apt-get update && apt-get install -y \
  curl \
  libpq-dev &&\
  apt-get update

RUN mkdir /app
WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
COPY package.json /app/package.json
RUN bundle install
RUN yarn install --check-files
COPY . /app

EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]