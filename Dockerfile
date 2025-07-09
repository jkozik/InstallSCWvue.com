FROM php:7.2-apache 
RUN apt update && apt -y install vim unzip wget libpng-dev zlib1g-dev  && \
    docker-php-ext-install calendar && \
    docker-php-ext-install mbstring && \
    docker-php-ext-install gd && \
    apt clean


WORKDIR /var/www/html

ADD http://saratoga-weather.org/wxtemplates/Base-USA.zip   /var/www/html
ADD http://saratoga-weather.org/wxtemplates/CU-plugin.zip  /var/www/html
ADD https://github.com/mcrossley/SteelSeries-Weather-Gauges/archive/master.zip /var/www/html
#ADD http://saratoga-weather.org/wxtemplates/AWN-plugin.zip /var/www/html
ADD http://saratoga-weather.org/saratoga-icons2.zip        /var/www/html
ADD http://saratoga-weather.org/wxtemplates/meteotreviglio-icons.zip /var/www/html
COPY davconsoleCW241_Full.zip /var/www/html
COPY noaafct.zip     /var/www/html
COPY favicon.ico     /var/www/html
COPY wxssgaugescu.php  /var/www/html


RUN cd /var/www/html && \
    unzip Base-USA.zip  && rm Base-USA.zip && \
    unzip CU-plugin.zip && rm CU-plugin.zip && \
    unzip -of saratoga-icons2.zip && rm saratoga-icons2.zip && \
    unzip noaafct.zip && cp noaafct/wxStartNoaaFct.php /var/www/html && rm noaafct.zip && \
    unzip meteotreviglio-icons.zip && rm meteotreviglio-icons.zip && \
    unzip davconsoleCW241_Full.zip  && rm davconsoleCW241_Full.zip && \
    unzip master.zip  && \
    mv SteelSeries-Weather-Gauges-master/web_server/ ssg && \
    rm master.zip && \
    rm -rf SteelSeries-Weather-Gauges-master/ && \
    echo



COPY flyout-menu.xml /var/www/html
#COPY  saveYesterday.php /var/www/html
COPY  wxtides.php /var/www/html

RUN chown -R www-data:www-data * && \
    chmod -R 755 . && \
    chmod 775 alert-images/ ajax-images/ cache/ alertlog/  WXtags-template-files/ && \
    chmod 775 forecast/ forecast/images/ forecast/icon-templates/ && \
    chmod 775 cumx/ davcon/ jpgraph-4.4.2-src-only/ moonimg/ noaafct/  ssg/ && \
    chmod 777 cache && \ 
    mkdir mount && chmod 777 mount && chown www-data:www-data mount


COPY customizeSettings.sh /var/www/html/
#COPY wxwebcam.php /var/www/html

RUN sed -i -e '/^#AddDef/s/\#AddDef/AddDef/' /etc/apache2/conf-enabled/charset.conf && \
    sed -i -e '/fcsticonstype/s/jpg/gif/' Settings.php && \
    chmod +x customizeSettings.sh   && . ./customizeSettings.sh

