FROM nginx:stable
RUN apt-get update
RUN apt-get install wget openssl curl -y
RUN wget -O repo.sh https://packages.sury.org/php/README.txt
RUN bash repo.sh
RUN rm repo.sh
RUN apt-get update
RUN mkdir /run/php
RUN apt-get install php php-fpm php-mbstring php-mysql php-gd -y
COPY src/ /usr/share/nginx/html
COPY nginx.conf /etc/nginx/nginx.conf
EXPOSE 80
CMD php-fpm8.1 && nginx
