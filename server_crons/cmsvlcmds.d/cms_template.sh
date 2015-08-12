#!/bin/sh
#
# This is a template file for newly created CMS version check commands.
#

# CMS Name
cmsname='CMS Name Here';

# CMS Info/Description
cmshomepage='https://cms.tld';
cmslatesvurl='https://cms.tld/downloadlatest';
cmsdescrip='This is a cool CMS.';
cmsfindinstalledvi=$(cat <<EOF
Lookup Info:
====
From Current Directory:
	N/A
====
EOF
);

# Additional curl arguments required.
curlargs='\
-A "Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_3_3 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8J2 Safari/6533.18.5" \
-s ';

# Run version lookup command.
# Be sure to replace CMSSCRAPINGARGUEMENTSGOHERE with the actual scraping argument.
cmslatestversion=$(curl $curlargs $cmslatestvurl |CMSSCRAPINGARGUEMENTSGOHERE);

# Run and print the latest version lookup.
echo "$cmsname: $cmslatestversion";