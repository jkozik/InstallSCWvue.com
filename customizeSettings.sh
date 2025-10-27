echo "Customize Settings.php"
sed -i  -e  '/SITE\[\x27organ/s/= \x27.*;/= \x27SanCapWeather.com\x27;/' \
        -e  '/SITE\[\x27copyr/s/Your Weather Website/SanCapWeather.com/' \
        -e  '/SITE\[\x27location/s/Somewhere, SomeState, USA/Sanibel, Florida, USA/' \
        -e  '/SITE\[\x27email/s/mailto:somebody@somemail.org/jackkozik at email.com/' \
        -e  '/SITE\[\x27latitude/s/= \x27.*;/= \x2726.468666\x27;/' \
        -e  '/SITE\[\x27longitude/s/= \x27.*;/= \x27-82.159859\x27;/' \
        -e  '/SITE\[\x27cityname/s/Saratoga/Sanibel/' \
        -e  '/SITE\[\x27tz/s/Los_Angeles/New_York/' \
        -e  '/SITE\[\x27WXSIM/s/true/false/' \
        -e  '/SITE\[\x27noaazone/s/= \x27.*;/= \x27FLZ165\x27;/' \
        -e  '/SITE\[\x27noaaradar/s/= \x27.*;/= \x27TBW\x27;/' \
        -e  '/SITE\[\x27WUregion/s/= \x27.*;/= \x27sw\x27;/' \
        -e  '/SITE\[\x27WUsatellite/s/= \x27.*;/= \x27se\x27;/' \
        -e  '/SITE\[\x27GR3radar/s/= \x27.*;/= \x27tbw\x27;/' \
        -e   '/SITE\[\x27fcsturlNWS/s@= \x27.*;@= \x27https://forecast\.weather\.gov/MapClick\.php?lat=26\.439800\&lon=-82\.071900\&unit=0\&lg=english\&FcstType=text\&TextType=2\x27;@' \
        Settings.php


sed -i  '/SITE\[\x27NWSforecasts/,/^);/ c\
$SITE[\x27NWSforecasts\x27]   = array( // for the advforecast2.php V3.xx version script \
// use "Zone|Location|Point-printableURL",  as entries .. first one will be the default forecast. \
"FLZ165|Coastal Lee|https://forecast.weather.gov/MapClick.php?lat=26.4398&lon=-82.0718&unit=0&lg=english&FcstType=text&TextType=2", \
);\
' Settings.php

sed -i '/SITE\[\x27NWSalertsCodes\x27/,/^);/ c\
$SITE[\x27NWSalertsCodes\x27] = array( \
"Coastal Lee|FLZ165|FLC071",\
);\
' Settings.php


echo "Customize Settings-weather.php"
sed -i  -e  '/SITE\[\x27realtimefile/s/realtime.txt/mount\/cumulus\/realtime.txt/' \
        -e  '/SITE\[\x27graphImageDir/s/images/mount\/cumulus\/images/' \
        -e  '/SITE\[\x27WXtags/s/CUtags/mount\/saratoga\/CUtags/' \
        -e  '/SITE\[\x27NOAAdir/s/Reports/mount\/cumulus\/Reports/' \
        -e  '/SITE\[\x27conditionsMETAR/s/= \x27.*;/= \x27KFMY\x27;/' \
        -e  '/SITE\[\x27UV/s/true/false/' \
        -e  '/SITE\[\x27SOLAR/s/true/false/' \
        Settings-weather.php


echo "Customize ajaxCUwx.js"
sed -i '/realtimeFile = \x27/s/realtime.txt/.\/mount\/cumulus\/realtime.txt/' ajaxCUwx.js
sed -i '/var maxupdates = /s/= 12/= 60/' ajaxCUwx.js

echo "Customize wxquake.php"
sed -i -e '/$setLatitude/s//#&/' \
       -e '/$setLongitude/s//#&/' \
       -e '/$setLocationName/s//#&/' \
       -e '/$setTimeZone/s//#&/' \
       wxquake.php

echo "Customize wxmetar.php"
sed -i '/MetarList = array/,/^);/ c\
$MetarList = array ( // set this list to your local METARs \
  // Metar(ICAO) | Name of station | dist-mi | dist-km | direction | \
  "KFMY|Fort Myers, Florida, USA|20|32|ENE|", // lat=26.5833,long=-81.8667, elev=4, dated=03-SEP-20 \
  "KRSW|Fort Myers, Florida, USA|26|41|E|", // lat=26.5333,long=-81.7500, elev=10, dated=03-SEP-20 \
  "KPGD|Punta Gorda, Florida, USA|32|52|NNE|", // lat=26.9167,long=-82.0000, elev=7, dated=03-SEP-20 \
  "KAPF|Naples Municipal, Florida, USA|33|53|SE|", // lat=26.1500,long=-81.7667, elev=3, dated=03-SEP-20 \
  "KMKY|Marco Island, Florida, USA|45|72|SE|", // lat=26.0000,long=-81.6667, elev=2, dated=03-SEP-20 \
  "KVNC|Venice, Florida, USA|45|72|NNW|", // lat=27.0667,long=-82.4333, elev=6, dated=03-SEP-20 \
  "KIMM|Immokalee, Florida, USA|47|76|E|", // lat=26.4333,long=-81.4000, elev=12, dated=03-SEP-20 \
// list generated Sat, 02-May-2020 11:10am PDT at https://saratoga-weather.org/wxtemplates/find-metar.php \
);\
' wxmetar.php

echo "Customize menubar.php"
sed -i '/External Links/, /^<.ul>/ c\
<p class="sideBarTitle"><?php langtrans(\x27External Links\x27); ?></p>\
<ul>\
   <li><a href="https://ambientweather.net/dashboard/6fbc376946ad75893d451dbdbbeb017f" title="Ambient Weather">Ambient Weather </a></li>\
   <li><a href="http://www.wunderground.com/" title="Weather Underground">Weather Underground</a></li>\
   <li><a href="https://www.wunderground.com/personal-weather-station/dashboard?ID=KFLSANIB27" title="-KFLSANIB27">-KFLSANIB27</a></li>\
   <li><a href="http://www.wxforum.net/" title="WXForum">WXforum.net</a></li>\
   <li><a href="http://www.findu.com/cgi-bin/wxpage.cgi?call=FW8511" title="FW8511">APRS-FW8511</a></li>\
   <li><a href="https://www.pwsweather.com/station/pws/sancapweather" title="PWS-SANCAPWEATHER">PWS-SanCap</a></li>\
   <li><a href="https://sancapweather.com/wxtides.php" title="Captive/Sound Tides">Tides</a></li>\
   <li><a href="http://sancapweather.com/wxweatherlink.php" title="WeatherLink"">WeatherLink</a></li>\
</ul>\
' menubar.php

echo "Customize flyout-menu.xml"
sed -i '/Nearby METAR Reports/a\
                <item caption="Steel Guages" link="wxssgauges.php"/>\
                <item caption="WeatherLink" link="wxweatherlink.php"/>\
     
' flyout-menu.xml


echo "Customize include-wxstatus.php"
sed -i '/realtimefile/s/15/60/' include-wxstatus.php

echo "Customize noaafct/noaaSettings.php"
sed -i -e '/myLatitude/s/= \x27.*\x27;/= \x2726.468666\x27;/' \
       -e '/myLongitude/s/= \x27.*\x27;/= \x27-82.159859\x27;/'   \
       -e '/myTimezone/s/= \x27.*\x27;/= \x27America\/Chicago\x27;/'   \
       -e '/myArea/s/= \x27.*\x27;/= \x27Sanibel\x27;/'   \
       -e '/myStation/s/= \x27.*\x27;/= \x27SanCapWeather.com\x27;/'   noaafct/noaaSettings.php

echo "Customize noaafct/noaaDigitalGenerateHtml.php"
sed -i '/<?php/a\
error_reporting(0);
' noaafct/noaaDigitalGenerateHtml.php

echo "Customize davconvp2CW.php"
sed -i '/graphurl/s/davcon24.txt/mount\/saratoga\/davcon24.txt/'  davconvp2CW.php

echo "Customize Steel Gauges"
sed -i '/Combined/,$s/scripts/.\/ssg\/scripts/' ssg/gauges-ss-basic-inc.php
sed -i -e '/showUvGauge/s/true/false/' \
	-e '/imgPathURL/s/images/mount\/cumulus\/images/' \
	-e '/realTimeUrlCumulus/s/realtimegauges.txt/.\/mount\/saratoga\/realtimegauges.txt/' \
	-e '/showSolarGauge/s/true/false/' ssg/scripts/gauges.js


#echo "rename wxindex.php to index.php"
mv wxindex.php index.php
sed -i  -e '/wxindex/s/wxindex/index/' flyout-menu.xml

echo "New Radar view in Settings.php"
sed -i -e '/NWSregion/s/sw/se/' Settings.php

echo "Fix PHP 8.1 deprecation in CU-defs.php"
sed -i '/windlabel\[ fmod/s/fmod(/(int)fmod(/' CU-defs.php
