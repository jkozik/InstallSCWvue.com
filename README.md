# InstallSCWvue.com
This is an evolution of the [InstallSCW.com](https://github.com/jkozik/InstallSCW.com) repository.

I needed to change out the [WS-2000](https://ambientweather.com/ws-2000-smart-weather-station?utm_id=go_cmp-17798158262_adg-_ad-__dev-c_ext-_prd-WS-2000_mca-147779820_sig-CjwKCAjwprjDBhBTEiwA1m1d0lH0KqdBQ3YpcmC_u7IZju7K7J7v9q7Shh6HU2JMoKV8tFgZeP7QHRoC4AAQAvD_BwE&utm_source=google&gad_source=1&gad_campaignid=17416650847&gbraid=0AAAAAD_pbGdb8MgtO3hbk610YAHQoY2ij&gclid=CjwKCAjwprjDBhBTEiwA1m1d0lH0KqdBQ3YpcmC_u7IZju7K7J7v9q7Shh6HU2JMoKV8tFgZeP7QHRoC4AAQAvD_BwE) weather station that runs [https://sancapweather.com](https://sancapweather.com) with a [Davis Vantage Vue](https://ambientweather.com/ws-2000-smart-weather-station?utm_id=go_cmp-17798158262_adg-_ad-__dev-c_ext-_prd-WS-2000_mca-147779820_sig-CjwKCAjwprjDBhBTEiwA1m1d0lH0KqdBQ3YpcmC_u7IZju7K7J7v9q7Shh6HU2JMoKV8tFgZeP7QHRoC4AAQAvD_BwE&utm_source=google&gad_source=1&gad_campaignid=17416650847&gbraid=0AAAAAD_pbGdb8MgtO3hbk610YAHQoY2ij&gclid=CjwKCAjwprjDBhBTEiwA1m1d0lH0KqdBQ3YpcmC_u7IZju7K7J7v9q7Shh6HU2JMoKV8tFgZeP7QHRoC4AAQAvD_BwE). 

My existing site uses the [Saratoga-Weather website](https://saratoga-weather.org/scripts.php)  framework with the [Cumulus](https://www.cumuluswiki.org/a/About_Cumulus)  [plug-in](https://saratoga-weather.org/wxtemplates/Settings-config-Cumulus.php). 

The Vantage Vue sits on the deck of my house in Florida.  Just inside there's a 915MHZ radio receiver, [a Davis Envoy 6313](https://www.davisinstruments.com/products/wireless-weather-envoy?variant=39617694498977&country=US&currency=USD&utm_medium=product_sync&utm_source=google&utm_content=sag_organic&utm_campaign=sag_organic&gad_source=1&gad_campaignid=22288934145&gbraid=0AAAAADiof7O8JaxrePs-21B26hbFnNMqd&gclid=CjwKCAjwprjDBhBTEiwA1m1d0kmfTTmWl-78Z0rU4VoTQh7MVlvyWhMsUP73RhTVK4uIo6I8j5GH6RoCcRAQAvD_BwE) that bridges to a [WiFiLogger](https://wifilogger.net/index.html).  The receiver polls the weather station every 2-10 seconds and relays the raw weather data to the Cumulus program running inside a Windows 10 Virtual Machine in a server in my house in Naperville. The Cumulus program collects the data and renders charts for display on the webpages supplied by Saratoga Weather.

The Saratoga Weather software works with a wide specturm of physical weather station devices.  To configure, I justed their Cumulus plug-in.  There was alot of setup required and in this repository, I automate as much as possible the setup.  
The result is a Dockerfile. It downloads all the files from Saratoga. It run scripts that tailor the Settings files. It sets up an [Apache web server ](https://httpd.apache.org/). The first time I did this, it was alot of work.  But on going, everytime I need to move my webserver, or apply updates from Saratoga Weather, the effort is really low.  

Not shown here, but the image that is created here, I put it on Docker Hub so that I can run this software on my Kubernetes Cluster.

## Dockerfile and docker-compose.yml
The Dockerfile builds the image.  The contents is mostly derived from the [Saratoga Weather Installation instructions](https://saratoga-weather.org/wxtemplates/install.php). You'll see that I start with a Debian Linux based apache server with php-7.2.  I download the USA Template and the Cumulus Plugin files. I also download the icon files.  After everything is downloaded and unzipped, I run a shell script that edits many key files (eg Settings.php, Settings-weather, etc). 

```
jkozik@u2004:~/projects/InstallSCW.com$ docker build -t jkozik/scwenvoy.com . --no-cache
[+] Building 133.6s (28/28) FINISHED                                                                     docker:default
 => [internal] load build definition from Dockerfile                                                               0.0s
 => => transferring dockerfile: 2.31kB                                                                             0.0s
 => [internal] load metadata for docker.io/library/php:7.2-apache                                                  0.8s
 => [internal] load .dockerignore                                                                                  0.0s
 => => transferring context: 2B                                                                                    0.0s
 => CACHED [ 1/18] FROM docker.io/library/php:7.2-apache@sha256:4dc0f0115acf8c2f0df69295ae822e49f5ad5fe849725847f  0.0s
 => CACHED http://saratoga-weather.org/wxtemplates/meteotreviglio-icons.zip                                        0.2s
 => CACHED http://saratoga-weather.org/saratoga-icons2.zip                                                         0.2s
 => CACHED https://github.com/mcrossley/SteelSeries-Weather-Gauges/archive/master.zip                              0.7s
 => CACHED http://saratoga-weather.org/wxtemplates/CU-plugin.zip                                                   0.2s
 => CACHED http://saratoga-weather.org/wxtemplates/Base-USA.zip                                                    0.2s
 => [internal] load build context                                                                                  0.0s
 => => transferring context: 253B                                                                                  0.0s
 => [ 2/18] RUN apt update && apt -y install vim unzip wget libpng-dev zlib1g-dev  &&     docker-php-ext-instal  119.2s
 => [ 3/18] WORKDIR /var/www/html                                                                                  0.1s
 => [ 4/18] ADD http://saratoga-weather.org/wxtemplates/Base-USA.zip   /var/www/html                               0.1s
 => [ 5/18] ADD http://saratoga-weather.org/wxtemplates/CU-plugin.zip  /var/www/html                               0.0s
 => [ 6/18] ADD https://github.com/mcrossley/SteelSeries-Weather-Gauges/archive/master.zip /var/www/html           0.0s
 => [ 7/18] ADD http://saratoga-weather.org/saratoga-icons2.zip        /var/www/html                               0.1s
 => [ 8/18] ADD http://saratoga-weather.org/wxtemplates/meteotreviglio-icons.zip /var/www/html                     0.0s
 => [ 9/18] COPY davconsoleCW241_Full.zip /var/www/html                                                            0.0s
 => [10/18] COPY noaafct.zip     /var/www/html                                                                     0.1s
 => [11/18] COPY favicon.ico     /var/www/html                                                                     0.0s
 => [12/18] COPY wxssgaugescu.php  /var/www/html                                                                   0.0s
 => [13/18] RUN cd /var/www/html &&     unzip Base-USA.zip  && rm Base-USA.zip &&     unzip CU-plugin.zip && rm C  1.8s
 => [14/18] COPY flyout-menu.xml /var/www/html                                                                     0.1s
 => [15/18] COPY  wxtides.php /var/www/html                                                                        0.0s
 => [16/18] RUN chown -R www-data:www-data * &&     chmod -R 755 . &&     chmod 775 alert-images/ ajax-images/ ca  8.4s
 => [17/18] COPY customizeSettings.sh /var/www/html/                                                               0.2s
 => [18/18] RUN sed -i -e '/^#AddDef/s/\#AddDef/AddDef/' /etc/apache2/conf-enabled/charset.conf &&     sed -i -e   0.4s
 => exporting to image                                                                                             1.8s
 => => exporting layers                                                                                            1.8s
 => => writing image sha256:01a020e29034384cb81a927d8b04604e3e6de5e8dff6b0275ad9cc264d4b5a3e                       0.0s
 => => naming to docker.io/jkozik/scwenvoy.com         
```
To run the container...
```
jkozik@u2004:~/projects/InstallSCW.com$ docker run -dit --name scwenvoy.com-app -p 8084:80 -v /mnt/sancap_share:/var/www
/html/mount jkozik/scwenvoy2.com
c9d7495938f6357f6c9878403b6d7c2d6784aa90f7f9a281e027b56e2a8116cd
```
Note:  The Cumulus software sends a realtime.txt file every few seconds and website graphes and charts every 10 minutes or so.  These are sent via ftp to an NFS share.  That share gets "mounted" into the running contain using the -v option. 
Also note, the webserver is running on port 80 inside the container, but I am mapping it to 8084 on my host server.  

It is useful to verify basic sanity:
```
jkozik@u2004:~/projects/InstallSCW.com$ curl http://localhost:8084
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
   "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <!-- ##### start AJAX mods ##### -->
    <script type="text/javascript" src="ajaxCUwx.js"></script>
    <!-- AJAX updates by Ken True - http://saratoga-weather.org/wxtemplates/ -->
        <script type="text/javascript"> var usingWeeWX = false; </script>
        <script type="text/javascript" src="ajaxgizmo.js"></script>
    <script type="text/javascript"> showUV = false; </script>
    <script type="text/javascript" src="language-en.js"></script>
        <!-- language for AJAX script included -->
    <meta name="description" content="Personal weather station." />
' ' ' 
```
And also check from a browser:







# InstallSCW.com
SanCapWeather.com is made from the scripts at Saratoga Weather. With this repository, I hope to automate putting these scripts into a docker container, making it easier for me to keep up to date and move as my server environment evolves.

The weather station is an Ambient Weather WS-2000. The console collects data from the weather station sensor array, displays it locally and sends the data every minute or so to AmbientWeather.net.  This server has open APIs and using the AWS plugin, the Saratoga Weather software nicely creates a dynamic weather web page.

This repository fetches the Saratoga weather scripts, customizes them for my weather station, and spins up a container that runs the scripts in an apache linux environment.

Clone the repository, build and run it as follows:

```
$ git clone https://github.com/jkozik/InstallSCW.com
# Optionally edit customerSettings.sh 
$ docker build -t jkozik/scw.com .
$ docker run -dit --name scw.com-app -p 8084:80 jkozik/scw.com
```
This should work, but verify it by going to a browser and try http://192.168.x.y/wxindex.php:8084

To help with troubleshooting, you'll need the following commands:
```
# shell prompt, logs, and restart needed for rebuild
$ docker exec -it scw.com-app /bin/bash
$ docker logs -f scw.com-app
$ docker stop scw.com-app; docker rm scw.com-app
```
The AWN-Plugin needs a helper cronjob to fetch and save yesterday's data.  Since it is kinda hard to do more than one task per container, I decided to use the host's cron to trigger a daily polling of yesterday's data from the AmbientWeather.net API.  The cronjob needs to execute a php script on the web server.  It is easily run with a wget/curl one line script. I run this every hour a 58 minutes past.  The actual php file does timezone checking and only really fetches the data at 11:59pm every day. 

cronjob on host (not in docker container):
```
58 * * * * wget http://192.168.100.178:8084/saveYesterday.php >> /home/jkozik/logs/awn.log 2>&1
#blank line
```

