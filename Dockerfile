# 使用官方 PHP 8.2-FPM 镜像
FROM php:8.2-fpm

# 安装系统依赖和 PHP 扩展
RUN apt-get update && apt-get install -y \
    git unzip libicu-dev libonig-dev libxml2-dev libzip-dev libpng-dev libjpeg-dev \
    && docker-php-ext-install intl mbstring pdo_mysql zip opcache gd

# 安装 Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# 设置工作目录
WORKDIR /var/www/flarum

# 安装 Flarum 项目
RUN composer create-project flarum/flarum .

# 暴露容器端口
EXPOSE 8000

# 启动服务
CMD ["php", "-S", "0.0.0.0:8000", "-t", "public"]
