FROM ubuntu:14.04
MAINTAINER Leandro Di Tommaso <leandro.ditommaso@mikroways.net>

RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y i--force-yes \
  supervisor php5-fpm php5-gd php5-imagick php5-curl php5-mcrypt php5-json \
  php5-mysqlnd

# Define environment variables
ENV APP_NAME    www
ENV APP_USER    www-data
ENV APP_GROUP   www-data

# Create directory for the application
RUN mkdir -p /opt/applications/$APP_NAME

# php.ini customizations
RUN sed -i "s/upload_max_filesize = 2M/upload_max_filesize = 10M/g" /etc/php5/fpm/php.ini
RUN sed -i "s/post_max_size = 8M/post_max_size = 10M/g" /etc/php5/fpm/php.ini

# PHP-FPM pool configuration
RUN rm /etc/php5/fpm/pool.d/www.conf
ADD www.conf /etc/php5/fpm/pool.d/www.conf
RUN sed -i "s/pool_name/$APP_NAME/g" /etc/php5/fpm/pool.d/www.conf
RUN sed -i "s/app_user/$APP_USER/g" /etc/php5/fpm/pool.d/www.conf
RUN sed -i "s/app_group/$APP_GROUP/g" /etc/php5/fpm/pool.d/www.conf

# Add supervisord to make sure service restarts if something fails
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
CMD supervisord -c /etc/supervisor/conf.d/supervisord.conf