#!/bin/sh
# CMS Name
cmsname='MODX Revolution';

# CMS Info/Description
cmshomepage='http://modx.com';
cmslatestvurl='http://modx.com/download/';
cmsdescrip='NA';
cmsfindinstalledvi=$(cat <<EOF
Lookup Info:
====
From Current Directory:
	find $(PWD) -type f -iwholename "*/manager/includes/version.inc.php" -exec grep -H "version = '" {} \; |grep -v "$MXLATEST"
====	
EOF
);

# Additional curl arguments required.
curlargs='\
-A "Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_3_3 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8J2 Safari/6533.18.5" \
-s ';

# Run version lookup command.
cmslatestversion=$(curl $curlargs $cmslatestvurl |grep -Po "Revolution (\d{1})\.(\d{1,2})\.(\d{1,2})?\-(\w{1,3})" |head -n1 |sed 's/Revolution //g');

# Run and print the latest version lookup.
echo "$cmsname: $cmslatestversion";