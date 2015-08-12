#!/bin/sh
# CMS Name
cmsname='Drupal';

# CMS Info/Description
cmshomepage='https://www.drupal.org';
cmslatestvurl='https://www.drupal.org/project/drupal';
cmsdescrip='NA';
cmsfindinstalledvi='NA';

# Additional curl arguments required.
curlargs='\
-A "Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_3_3 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8J2 Safari/6533.18.5" \
-s ';

# Run version lookup command.
cmslatestversion=$(curl $curlargs $cmslatestvurl |grep -Po "drupal\-(?:\d*\.?\d+\.?\d+).tar.gz" | grep -Po "(?:\d*\.?\d+\.?\d+)" |tr "\n" " ");

# Run and print the latest version lookup.
echo "$cmsname: $cmslatestversion";