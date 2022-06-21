FROM php:8.1-apache
RUN apt-get update && apt-get install -y \
		libfreetype6-dev \
		libjpeg62-turbo-dev \
		libpng-dev \
	&& docker-php-ext-configure gd --with-freetype --with-jpeg \
	&& docker-php-ext-install -j$(nproc) gd
  RUN curl -o typecho.zip https://github.com/typecho/typecho/releases/download/v1.2.0/typecho.zip
  RUN apt-get install unzip wget
  RUN unzip tyepcho.zip -d /var/www/html
  RUN { \
        echo 'RewriteEngine On'; \
        echo 'RewriteBase /'; \
        echo 'RewriteCond %{REQUEST_FILENAME} !-f'; \
        echo 'RewriteCond %{REQUEST_FILENAME} !-d'; \
        echo 'RewriteRule ^(.*)$ /index.php/$1 [L]'; \
    } >> /var/www/html/.htaccess
  RUN docker-php-ext-install -j "$(nproc)" \
        bcmath \
        exif \
        gd \
        zip \
        mysqli \
        pdo_mysql \
        pdo_pgsql \
        tokenizer \
        opcache 
   RUN pecl install imagick
   RUN docker-php-ext-enable imagick
   VOLUME /var/www/html
   WORKDIR /var/www/html
   EXPOSE 80
