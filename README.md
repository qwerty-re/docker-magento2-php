# PHP for Magento 2

[![Docker Hub downloads](https://img.shields.io/docker/pulls/qwertyre/magento2-php)](https://hub.docker.com/r/qwertyre/magento2-php)
[![Travis](https://img.shields.io/travis/qwerty-re/docker-magento2-php)](https://travis-ci.org/qwerty-re/docker-magento2-php)
[![License](https://img.shields.io/github/license/qwerty-re/docker-magento2-php)](https://github.com/qwerty-re/docker-magento2-php/blob/master/LICENSE)

[![Stars](https://img.shields.io/github/stars/qwerty-re/docker-magento2-php?style=social)](https://github.com/qwerty-re/docker-magento2-php/stargazers)
[![Forks](https://img.shields.io/github/forks/qwerty-re/docker-magento2-php?style=social)](https://github.com/qwerty-re/docker-magento2-php/network/members)

##### Versions
[![PHP version](https://img.shields.io/badge/PHP_FPM-7.2.21-green?logo=php)](https://www.php.net/ChangeLog-7.php#7.2.21)
[![Devian version](https://img.shields.io/badge/debian-buster-green?logo=debian)](https://www.debian.org/releases/buster/)

##### Supported Magento versions
![Magento2.2.x](https://img.shields.io/badge/Magento-2.2.x-green?logo=magento)
![Magento2.3.x](https://img.shields.io/badge/Magento-2.3.x-green?logo=magento)

##### Installed tools
[![Composer version](https://img.shields.io/badge/composer-1.9.0-green?logo=composer)](https://github.com/composer/composer/releases/tag/1.9.0)
[![magerun2 version](https://img.shields.io/badge/magerun2-3.2.0-green)](https://github.com/netz98/n98-magerun2/blob/master/CHANGELOG.md#320)
[![PHP CodeSniffer version](https://img.shields.io/badge/PHP_CodeSniffer-3.4.2-green)](https://github.com/squizlabs/PHP_CodeSniffer/releases/tag/3.4.2)

##### Description

This is PHP docker image for Magento 2.2.x-2.3.x with installed `composer`, `magerun2` and `phpcbf`, `phpcs` with Magento2 coding standards as default.

##### Example docker-compose

```yaml
version: '2'
services:
  dockerized_magento2_php:
    container_name: DOCKERIZED_MAGENTO2_PHP
    image: qwertyre/magento2-php:7.2.21
    volumes:
      - ./local-magento:/srv/magento2
    network_mode: "DOCKER_network"
  ...
```

##### Installed PHP extensions

* bcmath
* gd
* hash
* imagick
* intl
* mbstring
* opcache
* pcntl
* pdo_mysql
* soap
* xsl
* zip
