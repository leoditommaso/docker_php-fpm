# PHP FPM Docker

*MASTER VERSION IS IN DEVELOPMENT STATUS, DO USE TAGGED VERSIONS INSTEAD.*

Docker container automated PHP-FPM installation.

# Usage

This container is on the Docker Hub so you do not need to clone this repo
to use it unless you'd like to build a new container based on this one.

To run the container you could simply execute:

```
docker run leoditommaso/php-fpm
```

Anyway, that will be useless because you will have a PHP-FPM running with
no application configured and with no connection to a webserver. So, the 
best way to run the container is:

```
docker run -d -v /PATH/TO/LOGDIR:/var/log/phpfpm -v /PATH/TO/SOCKETDIR:/var/run/phpfpm -v /PATH/TO/APPDIR:/opt/applications leoditommaso/php-fpm:latest
```

Where:

* **/PATH/TO/LOGDIR**: is the full path to a local folder on the host machine
  where logs will be stored.
* **/PATH/TO/SOCKETDIR**: is the full path to a local folder on the host machine
  where the socket will be placed. With this you could then configure an Nginx
  virtual host and set it to read from this socket. The socket will be named
  after the application (www_php5-fpm.sock by default).
* **/PATH/TO/APPDIR**: is the full path to a local folder on the host machine where
  the website public files are stored.

# Building

If you need to customize some setting you should clone this repo, change the appropiate
file and then build the container. It's important to know the meaning of each file then:

* **Dockerfile**: this is the docker configuration file to build the container from. Take a
  look at the comments on the file for an explanation of each line meaning.
* **supervisord.conf**: the configuration file for supervisord. It tells the daemon to start
  PHP-FPM.
* **www.conf**: this is PHP-FPM pool configuration file. You could introduce any configuration
  you need but keep **pool_name**, **app_user** and **app_group** the way they are
  'cause those strings are replaced with the appropiate values in the Dockerfile.

After making any customization you need execute:

```
docker build -t newcontainername .
```

# License and Authors

This project is released under MIT License.

Author:: [Leandro Di Tommaso](http://leoditommaso.io) 
(<leandro.ditommaso@mikroways.net>)
