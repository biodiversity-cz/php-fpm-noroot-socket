# php-fpm-noroot-socket
PHP-FPM unprivileged image with shared socket. More info at the [Nginx container](https://github.com/biodiversity-cz/nginx-noroot-fpmSocket) .

Individual configuration should be store in $PHP_INI_DIR/conf.d/, that is /usr/local/etc/php/conf.d (but check the [documentation](https://hub.docker.com/_/php)).

The memory limit is possible change also via ENV variable PHP_MEMORY_LIMIT, see php.ini-production:435

[//]: # (obligatory branding for EOSC.CZ)
<hr style="margin-top: 100px; margin-bottom: 20px">

<p style="text-align: left"> <img src="https://webcentrum.muni.cz/media/3831863/seda_eosc.png" alt="EOSC CZ Logo" height="90"> </p>
This project output was developed with financial contributions from the EOSC CZ initiative throught the project National Repository Platform for Research Data (CZ.02.01.01/00/23_014/0008787) funded by Programme Johannes Amos Comenius (P JAC) of the Ministry of Education, Youth and Sports of the Czech Republic (MEYS).

<p style="text-align: left"> <img src="https://webcentrum.muni.cz/media/3832168/seda_eu-msmt_eng.png" alt="EU and MŠMT Logos" height="90"> </p>
