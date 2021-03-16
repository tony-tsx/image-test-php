FROM php:7.4-cli

RUN apt-get update -y
RUN apt-get install -y apt-utils \
  zip \
  git \
  libmcrypt-dev \
  libpq-dev \
  libcurl4-gnutls-dev \
  libicu-dev \
  libvpx-dev \
  libjpeg-dev \
  libpng-dev \
  libxpm-dev \
  zlib1g-dev \
  libfreetype6-dev \
  libxml2-dev \
  libexpat1-dev \
  libbz2-dev \
  libgmp3-dev \
  libldap2-dev \
  unixodbc-dev \
  libsqlite3-dev \
  libaspell-dev \
  libsnmp-dev \
  libpcre3-dev \
  libtidy-dev \
  libssh2-1 \
  libssh2-1-dev \
  libmemcached-dev \
  python \
  python-pip \
  libonig-dev \
  libzip-dev \
  build-essential \
  nodejs \
  python3 \
  python3-pip \
  gnupg \
  wget \
  npm
RUN pecl install ssh2-1.2 memcached
RUN echo extension=memcached.so >> /usr/local/etc/php/conf.d/memcached.ini
RUN docker-php-ext-install mbstring pdo_pgsql curl json intl gd xml zip bz2 opcache pdo pdo_mysql soap

RUN pip3 install awsebcli
RUN pip3 install awscli

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php -r "if (hash_file('sha384', 'composer-setup.php') === '756890a4488ce9024fc62c56153228907f1545c228516cbf63f885e036d37e9a59d27d63f46af1d4d07ee0f76181c7d3') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
RUN php composer-setup.php --install-dir=bin --filename=composer
RUN php -r "unlink('composer-setup.php');"
RUN composer --version
