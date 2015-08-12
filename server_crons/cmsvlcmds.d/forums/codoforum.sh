#!/bin/sh
# CMS Name
cmsname='CodoForum';

# CMS Info/Description
cmshomepage='https://codoforum.com';
cmslatestvurl='https://codoforum.com/';
cmsdescrip=$(cat <<'EOF'
A FORUM SOFTWARE WHICH IS BEAUTIFUL. FAST. EXTENSIBLE.
EOF
);
cmsfindinstalledvi=$(cat <<'EOF'
Lookup Info:
====
From Current Directory:
	N/A
====
EOF
);

# Additional curl arguments required.
curlargs='-s ';

# Run version lookup command.
cmslatestversion=$(curl $curlargs $cmslatestvurl |grep -Po "v\.(\d{1})\.(\d{1})" |head -n1);

# Run and print the latest version lookup.
echo "$cmsname: $cmslatestversion";