FROM webdevops/apache:debian-7

ADD config /config
ADD www /www
ENV WEB_DOCUMENT_ROOT=/www

RUN a2enmod rewrite
RUN a2enmod proxy

RUN cp /config/cn.conf /opt/docker/etc/httpd/conf.d/
RUN chmod 777 /config
VOLUME /config
