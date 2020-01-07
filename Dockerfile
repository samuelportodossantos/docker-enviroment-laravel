FROM php:7.2-apache
COPY ./config/000-default.conf /etc/apache2/sites-available/
RUN a2enmod rewrite
RUN docker-php-ext-install pdo pdo_mysql
RUN service apache2 restart
RUN cd ~; curl -sS https://getcomposer.org/installer -o composer-setup.php;php composer-setup.php --install-dir=/usr/local/bin --filename=composer