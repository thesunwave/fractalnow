FROM ruby:3.2

ENV PORT=8080

RUN apt-get update && apt-get install fractalnow -yy

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

CMD ["bundle", "exec", "puma"]
