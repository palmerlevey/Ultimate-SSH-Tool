#!/bin/sh
# CMS Name
cmsname='BigTree';

# CMS Info/Description
cmshomepage='https://www.bigtreecms.org/';
cmslatestvurl='https://www.bigtreecms.org/download/';
cmsdescrip=$(cat <<'EOF'
We strongly believe your content managements system shouldn't require you to compromise your vision. BigTree is an extremely extensible open source CMS built on PHP and MySQL. It was created by designers, UX experts, and content strategists to help you make and maintain better websites.
EOF
);
cmsfindinstalledvi=$(cat <<'EOF'
Lookup Info:
====
From Current Directory:
	find $(echo $pwd) -type f -iwholename "*/core/version.php" -exec grep -H "define(\"BIGTREE_VERSION" {} \;
====
EOF
);

# Additional curl arguments required.
curlargs='-s ';

# Run version lookup command.
cmslatestversion=$(curl $curlargs $cmslatestvurl |grep -Po "version (\d{1})\.(\d{1,2})\.(\d{1,2})");

# Run and print the latest version lookup.
echo "$cmsname: $cmslatestversion";