FROM ubuntu:22.04

# get and update package lists from repositories
RUN apt-get update
RUN apt-get install -y software-properties-common
RUN apt-get install -y apt-utils
RUN add-apt-repository ppa:ondrej/php
RUN apt-get update
# Set the timezone
ENV TZ=Europe
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime
RUN echo $TZ > /etc/timezone

# Install PHP packages
RUN apt install -y php8.2 
RUN apt-get install -y php8.2-fpm
RUN apt-get install -y php8.2-cli
RUN apt-get install -y php8.2-zip
RUN apt-get install -y php8.2-mbstring
RUN apt-get install -y php8.2-tokenizer
RUN apt-get update
RUN apt-get install -y php8.2-mysql
RUN apt-get install -y php8.2-gd
RUN apt-get install -y php8.2-xml
RUN apt-get install -y php8.2-bcmath
RUN apt-get install -y php8.2-intl
RUN apt-get install -y php8.2-curl

# Install nodejs
RUN apt install -y nodejs
# Install npm
RUN apt install -y npm

# Clone laravel.io repository
RUN git clone https://github.com/laravelio/laravel.io
# Install curl
RUN apt-get install -y curl
# Get composer | composer setup version 2.2
RUN curl -sS https://getcomposer.org/installer -o /root/composer-setup.php
RUN php /root/composer-setup.php --2.2 --install-dir=/usr/local/bin --filename=composer

WORKDIR /laravel.io
# Install composer & npm latest version
RUN composer install
RUN npm install -g n && n latest
RUN npm install && npm run build

# Install mysql client
RUN apt-get install -y mysql-client
RUN cp .env.example .env

# Environment variables if user wants to migrate and seed db
ENV MIGRATESEED=true
ENV APP_URL="http://127.0.0.1:80"

# Generate php key
RUN php artisan key:generate

# Copy and Run migrate script
COPY ./migsed.sh .
RUN chmod +x migsed.sh
EXPOSE 80

CMD ./migsed.sh