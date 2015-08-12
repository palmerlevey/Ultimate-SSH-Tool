#!/bin/sh
# CMS Name
cmsname='Concrete5';

# CMS Info/Description
cmshomepage='http://www.concrete5.org';
cmslatestvurl='http://www.concrete5.org/get-started';
cmsdescrip='NA';
cmsfindinstalledvi='NA';

# Additional curl arguments required.
curlargs='-s ';

# Run version lookup command.
cmslatestversion=$(curl $curlargs $cmslatestvurl |grep -Po "Download (\d{1})\.(\d{1,2})\.(\d{1,2})\.(\d{1,2})" |head -n1 |sed 's/Download //g');

# Run and print the latest version lookup.
echo "$cmsname: $cmslatestversion";