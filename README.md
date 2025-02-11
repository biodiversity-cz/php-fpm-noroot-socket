# php-fpm-noroot-socket
PHP-FPM unprivileged image with shared socket. More info at the [Nginx container](https://github.com/biodiversity-cz/nginx-noroot-fpmSocket) .

Individual configuration should be store in $PHP_INI_DIR/conf.d/, that is /usr/local/etc/php/conf.d (but check the [documentation](https://hub.docker.com/_/php))