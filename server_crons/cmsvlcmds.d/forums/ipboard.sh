#!/bin/sh
## 
## NOTES
## Currently blocking robots.
##

# CMS Name
cmsname='IPBoard';

# CMS Info/Description
cmshomepage='https://www.invisionpower.com';
cmslatestvurl='https://www.invisionpower.com';
cmsdescrip='NA';
cmsfindinstalledvi='NA';

# Additional curl arguments required.
curlargs='\
-A "Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_3_3 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8J2 Safari/6533.18.5" \
-s ';

# Run version lookup command.
#cmslatestversion=$(curl $curlargs $cmslatestvurl |grep ?);

# Run and print the latest version lookup.
#echo "$cmsname: $cmslatestversion";
echo "$cmsname is being blocked."
