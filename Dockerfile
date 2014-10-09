# Dockerfile for a Rails application using Nginx and Unicorn

# Select ubuntu as the base image
FROM ubuntu:14.10

# Install nginx, nodejs and curl
RUN apt-get update -q
RUN apt-get install -qy nginx
RUN apt-get install -qy curl
RUN apt-get install -qy git
RUN apt-get install -qy nodejs
RUN apt-get install -qy nano

# Install rvm, ruby, bundler
RUN curl -sSL https://get.rvm.io | bash -s stable
RUN /bin/bash -l -c "rvm requirements"
RUN /bin/bash -l -c "rvm install 2.1.3"
RUN /bin/bash -l -c "gem install bundler --no-ri --no-rdoc"

RUN bash -c 'echo "source /etc/profile.d/rvm.sh" >> ~/.bashrc'

# Add configuration files in repository to filesystem
RUN rm /etc/nginx/sites-enabled/default
ADD docker/nginx.conf /etc/nginx/sites-enabled/nginx.conf

# ADD config/container/start-server.sh /usr/bin/start-server
# RUN chmod +x /usr/bin/start-server
RUN git clone https://github.com/robinbortlik/kitchen-manager.git /var/www/kitchen-manager

# # Add rails project to project directory
ADD ./ /var/www/kitchen-manager

# # set WORKDIR
WORKDIR /var/www/kitchen-manager

ADD Gemfile /var/www/kitchen-manager/Gemfile
ADD Gemfile.lock /var/www/kitchen-manager/Gemfile.lock

# # bundle install
RUN /bin/bash -l -c "bundle install --deployment"

RUN /bin/bash -l -c "service nginx restart"

# # Publish port 80
EXPOSE 80

# Fix ubuntu locale problem
RUN /bin/bash -l -c "locale-gen en_US en_US.UTF-8"
RUN /bin/bash -l -c "dpkg-reconfigure locales"
RUN /bin/bash -l -c "export LC_ALL=en_US.UTF-8"
RUN /bin/bash -l -c "export LANG=en_US.UTF-8"

# # Startup commands
# CMD ["bundle", "exec", "puma", "-C", "puma.rb"]
# ENTRYPOINT bundle exec puma -C puma.rb