# goaccess

```sh
brew install goaccess
```

Gen report
```sh
goaccess \
access.log \
--no-query-string \
--ignore-crawlers \
--log-format=COMBINED \
--geoip-database GeoLite2-City.mmdb \
-o \
report.html
```

Get GeoLite2 City DB
1. [Signup](https://dev.maxmind.com/geoip/geoip2/geolite2/)  
2. Find your key  
3. Add it to the URL

```sh
wget "https://download.maxmind.com/app/geoip_download?edition_id=GeoLite2-City&license_key=YOUR_LICENSE_KEY&suffix=tar.gz" -nv -O GeoLite2-City.tar.gz
dbte=$(tar -tzf GeoLite2-City.tar.gz | grep GeoLite2-City.mmdb)
tar -O -zxvf GeoLite2-City.tar.gz $dbte > GeoLite2-City.mmdb
```

## Sources
* [Man](https://goaccess.io/man)  
