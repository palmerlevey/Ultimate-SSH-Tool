#!/bin/sh
# CMS Name
cmsname='Anchor';

# CMS Info/Description
cmshomepage='http://anchorcms.com';
cmslatestvurl='http://anchorcms.com/';
cmsdescrip='NA';
cmsfindinstalledvi=$(cat <<'EOF'
Lookup Info:
====
From Current Directory:
	find $(echo $pwd) -type f -iwholename "*/index.php" -exec grep -H "define('VERSION" {} \; |grep -v 'install'
====
EOF
);

# Additional curl arguments required.
curlargs='-s ';

# Run version lookup command.
cmslatestversion=$(curl $curlargs $cmslatestvurl |grep -Po "Download (\d{1})\.(\d{1,2})?\.(\d{1,2})" |sed 's/Download //g');

# Run and print the latest version lookup.
echo "$cmsname: $cmslatestversion";