cd /var/www/kitchen-manager
git pull

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

bundle exec puma -e production -b unix:///var/www/kitchen-manager/tmp/socket