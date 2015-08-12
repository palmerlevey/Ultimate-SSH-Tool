#!/bin/sh
# CMS Name
cmsname='Ghost';

# CMS Info/Description
cmshomepage='https://ghost.org';
cmslatestvurl='https://ghost.org/download/';
cmsdescrip='NA';
cmsfindinstalledvi='NA';

# Additional curl arguments required.
curlargs='-s ';

# Run version lookup command.
cmslatestversion=$(curl $curlargs $cmslatestvurl |grep -Po "v\<b\>(\d{1})\.(\d{1,2})?\.(\d{1,2})" |sed 's/v<b>//g');

# Run and print the latest version lookup.
echo "$cmsname: $cmslatestversion";