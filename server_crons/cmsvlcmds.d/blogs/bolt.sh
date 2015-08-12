#!/bin/sh
# CMS Name
cmsname='Bolt';

# CMS Info/Description
cmshomepage='https://bolt.cm';
cmslatestvurl='https://bolt.cm/';
cmsdescrip='NA';
cmsfindinstalledvi='NA';

# Additional curl arguments required.
curlargs='-ks ';

# Run version lookup command.
cmslatestversion=$(curl $curlargs $cmslatestvurl |grep -Po "version v (\d{1,2})\.(\d{1,2})?\.(\d{1,2})" |sed 's/version v //g');

# Run and print the latest version lookup.
echo "$cmsname: $cmslatestversion";