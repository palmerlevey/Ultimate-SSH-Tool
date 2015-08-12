#!/bin/sh
# CMS Name
cmsname='Typo3';

# CMS Info/Description
cmshomepage='http://typo3.org';
cmslatestvurl='http://get.typo3.org/current';
cmsdescrip='NA';
cmsfindinstalledvi='NA';

# Additional curl arguments required.
curlargs='--max-time 5 \
-A "Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_3_3 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8J2 Safari/6533.18.5" \
-sI ';

# Run version lookup command.
cmslatestversion=$(curl $curlargs $cmslatestvurl |grep -Po "src\-(\d{1})\.(\d{1,2})\.(\d{1,2})\.tar" |sed 's/src-//g' |sed 's/.tar//g');

# Run and print the latest version lookup.
echo "$cmsname: $cmslatestversion";
