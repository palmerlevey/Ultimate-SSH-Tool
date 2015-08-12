#!/bin/sh
# CMS Name
cmsname='CMS Made Simple';

# CMS Info/Description
cmshomepage='http://www.cmsmadesimple.org';
cmslatestvurl='http://www.cmsmadesimple.org/downloads/';
cmsdescrip='NA';
cmsfindinstalledvi='NA';

# Additional curl arguments required.
curlargs='\
-A "Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_3_3 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8J2 Safari/6533.18.5" \
-s ';

# Run version lookup command.
cmslatestversion=$(curl $curlargs $cmslatestvurl |grep "Version: " |head -n1 | cut -d ":" -f2 | cut -d "<" -f1 |sed 's/ //g');

# Run and print the latest version lookup.
echo "$cmsname: $cmslatestversion";