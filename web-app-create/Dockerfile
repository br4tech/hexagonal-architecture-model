# Use the official Ruby image as the base image
FROM ruby:2.7.0

# Set the working directory in the container
WORKDIR /app

# Install dependencies
RUN apt-get update && \
    apt-get install -y \
      build-essential \
      libpq-dev \
      nodejs

# Install Rails version 5.2.3
RUN gem install rails -v '5.2.3'

# Copy Gemfile and Gemfile.lock to the container
COPY Gemfile Gemfile.lock ./

# Install gems
RUN bundle install

# Copy the rest of the application files to the container
COPY . .

# Expose port 3000 for the Rails server
EXPOSE 3000

# Start the Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]
