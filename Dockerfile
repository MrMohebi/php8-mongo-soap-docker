FROM php:8.0
MAINTAINER MMMohebi <MMMohebi@outlook.com>

# install composer
COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

RUN apt-get update -y && apt-get upgrade -y && apt-get install git libssl-dev -y
# Install unzip utility and libs needed by zip PHP extension
RUN apt-get update && apt-get install -y \
    zlib1g-dev \
    libzip-dev \
    libxml2-dev \
    unzip
RUN docker-php-ext-install zip
RUN docker-php-ext-install soap

RUN mkdir -p /usr/src/php/ext/mongodb \
    && curl -fsSL https://pecl.php.net/get/mongodb-1.14.1 | tar xvz -C "/usr/src/php/ext/mongodb" --strip 1 \
    && docker-php-ext-install mongodb
