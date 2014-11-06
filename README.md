# docker_php-fpm

Docker automated PHP-FPM installation based on Ubuntu 14.04.

# Building

If you would like to build the container, just clone this repo and then execute:

```
docker build -t newcontainername .
```

# Usage

To run the container you could simply execute:

```
docker run leoditommaso/php-fpm
```

That will be useless because you will have a PHP-FPM running with
no application configured and with no possibility to connect to a
webserver. So, the best way to run the container is:

```
docker run -d -v /PATH/TO/LOGDIR:/var/log/phpfpm -v /PATH/TO/SOCKETDIR:/var/run/phpfpm -v /PATH/TO/APPDIR:/opt/applications/APP_NAME
```

Where APP_NAME is the one specified in the Dockerfile (www by default).

By default, the container will create a socket placed in the /PATH/TO/SOCKETDIR directory
and named after the application name which will be:

```
www_php-fpm.socket
```

# License and Authors

This project is released under MIT License.

Author:: [Leandro Di Tommaso](http://leoditommaso.io) 
(<leandro.ditommaso@mikroways.net>)
