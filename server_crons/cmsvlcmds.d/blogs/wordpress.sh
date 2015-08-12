#!/bin/sh
# CMS Name
cmsname='WordPress';

# CMS Info/Description
cmshomepage='https://wordpress.org';
cmslatestvurl='https://wordpress.org/download/';
cmsdescrip='WordPress is web software you can use to create a beautiful website or blog. We like to say that WordPress is both free and priceless at the same time.';
cmsfindinstalledvi=$(cat <<EOF
Lookup Info:
====
From Current Directory:
   find $(echo $PWD) -type f -iwholename "*/wp-includes/version.php" -exec grep -H "\$wp_version =" {} \;
====
EOF
);

# Additional curl arguments required.
curlargs='\
-A "Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_3_3 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8J2 Safari/6533.18.5" \
-s ';

# Run version lookup command.
cmslatestversion=$(curl $curlargs $cmslatestvurl |grep -Po "Version (\d{1,3})?\.(\d{1,3})?\.(\d{1,3})" |sed 's/Version //g');

# Run and print the latest version lookup.
echo "$cmsname: $cmslatestversion";

# Print installed version lookup instructions.
# echo "$cmsfindinstaledvi";