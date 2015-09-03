#!/bin/sh
# CMS Name
cmsname='Joomla';

# CMS Info/Description
cmshomepage='http://www.joomla.org';
cmslatestvurl='https://www.joomla.org/download.html';
cmsdescrip='NA';
cmsfindinstalledvi='NA';

# Additional curl arguments required.
curlargs='\
-A "Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_3_3 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8J2 Safari/6533.18.5" \
-s -k';

# Run version lookup command.
cmslatestversion=$(curl $curlargs $cmslatestvurl |grep -Po "Joomla_(?:\d*\.?\d+\.?\d+)\-Stable\-Full\_Package\.zip" | grep -Po "(?:\d*\.?\d+\.?\d+)" |tr "\n" " ");

# Run and print the latest version lookup.
echo "$cmsname: $cmslatestversion";
