FROM ubuntu:12.10

# Install packages.
RUN apt-get update -q
RUN apt-get install -y ssh git build-essential libssl-dev

# Install Ruby 2.0 from an external apt repository.
RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:brightbox/ruby-ng-experimental
RUN apt-get update -q
RUN apt-get install -y ruby2.0 ruby2.0-dev

# Install Bundler.
RUN gem install --no-document bundler

# Clone repository.
RUN git clone https://github.com/r7kamura/qchan-worker.git

# Install gems.
RUN cd qchan-worker && bundle install

# Setup & Run.
CMD cd qchan-worker && git pull && bundle install && bundle exec rake resque:work
