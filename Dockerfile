FROM ubuntu:15.04
LABEL maintainer="Shaked KleinO Orbach <klein.shaked+whatsapp@gmail.com>"

#Updates apt repository
#Installs PHP5.6, some extensions and apcu.
#Installs curl, pear, wget, git, memcached and mysql-server
RUN apt-get update -y && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:ondrej/php5-5.6 && \
    apt-get install -y vim && \
    apt-get install -y php5  php5-dev && \
    apt-get install -y curl php-pear wget git memcached

#Installs PHPUnit, Composer && PHP CodeSniffer
#Fetches a sample php.ini file with most configurations already good-to-go.
RUN wget https://phar.phpunit.de/phpunit.phar && \
    chmod +x phpunit.phar && \
    mv phpunit.phar /usr/local/bin/phpunit && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
    pear install PHP_CodeSniffer

RUN wget https://raw.githubusercontent.com/naroga/docker-php56/master/php.ini && \
    rm -r /etc/php5/cli/php.ini && \
    rm -r /etc/php5/apache2/php.ini && \
    cp php.ini /etc/php5/cli/php.ini && \
    cp php.ini /etc/php5/apache2/php.ini

# Whatsapp dependencies
ADD ./start.sh /tmp/start.sh
RUN chmod +x /tmp/start.sh && \
    /tmp/start.sh && \
    apt-get install -y ffmpeg php5-gd php5-curl libapache2-mod-php5 php5-sqlite php5-mcrypt && \
    php5enmod mcrypt && \
    mkdir /whatsapp && \
    cd /whatsapp && composer require whatsapp/chat-api

#Tests build
RUN php -v && \
    phpunit --version && \
    composer --version && \
    phpcs --version && \
    php -i | grep timezone && \
    php -r "echo json_encode(get_loaded_extensions());" && \
    php -m | grep -w --color 'curve25519\|protobuf\|crypto'
