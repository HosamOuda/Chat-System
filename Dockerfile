FROM ruby:3.0.1

# RUN bash -c "apt-get update && apt-get install --no-install-recommends -y libpq-dev libmagic-dev nodejs rsync vim"

# RUN bash -c "mkdir /gems"

# ENV GEM_HOME /gems
# ENV GEM_PATH /gems
# ENV BUNDLE_PATH /gems

# WORKDIR /app

# COPY Gemfile Gemfile
# #RUN bash -c "bundle config specific_platform x86_64-linux && bundle config --local build.sassc --disable-march-tune-native"
# RUN bash -c "bundle install"
# COPY . .
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Configure the main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0"]