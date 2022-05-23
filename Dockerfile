FROM ruby:3.0.2

RUN apt-get update && apt-get install -y libsodium-dev

RUN mkdir /gallery-api
WORKDIR /gallery-api
COPY . /gallery-api
RUN gem install bundler
RUN bundle install

ENV RAILS_ENV production

EXPOSE 3002

# Start the main process.
CMD ["bundle", "exec", "puma", "-p", "3002", "-w", "0", "-t", "1:5"]
