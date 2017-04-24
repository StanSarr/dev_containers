# Use this as a base image
FROM ubuntu:14.04

# Optional: specify the maintainer
MAINTAINER STAN SARR <stan.sarr@koober.com>


# Run any command on terminal
RUN apt-get update && \
    apt-get -y install apache2 php5 libapache2-mod-php5 php5-mcrypt php5-json php5-mysql php5-curl php5-sqlite default-jre curl git && \
    apt-get clean && \
    update-rc.d apache2 defaults && \
    php5enmod opcache pdo mysql mysqli pdo_mysql readline mcrypt curl sqlite && \
    a2enmod rewrite && \
    rm -rf /var/www/html && \
    curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer

COPY koober.conf /etc/apache2/sites-available/000-default.conf

# Install APP
WORKDIR /var/www


# Expose necessary ports to the container
EXPOSE 80
EXPOSE 443

# COPY setup-laravel.sh /setup-laravel.sh
# RUN ["chmod", "+x", "/setup-laravel.sh"]
# ENTRYPOINT ["/setup-laravel.sh"]

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]