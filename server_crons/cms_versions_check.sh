#!/bin/sh
## Live Version Lookups
# WordPress - https://wordpress.org
WORDPRESSLATEST=$(curl -A "Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_3_3 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8J2 Safari/6533.18.5" -s "https://wordpress.org/download/" |grep -Po "Version (\d{1,3})?\.(\d{1,3})?\.(\d{1,3})" |sed 's/Version //g');

# Joomla - http://www.joomla.org
JOOMLALATEST=$(curl -A "Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_3_3 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8J2 Safari/6533.18.5" -s http://www.joomla.org/download.html |grep -Po "Joomla_(?:\d*\.?\d+\.?\d+)\-Stable\-Full\_Package\.zip" | grep -Po "(?:\d*\.?\d+\.?\d+)" |tr "\n" " ");

# Drupal - https://www.drupal.org
DRUPALLATEST=$(curl -A "Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_3_3 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8J2 Safari/6533.18.5" -s https://www.drupal.org/project/drupal | grep -Po "drupal\-(?:\d*\.?\d+\.?\d+).tar.gz" | grep -Po "(?:\d*\.?\d+\.?\d+)" |tr "\n" " ");

# ImpressCMS - http://impresscms.org
IMPRESSLATEST=$(curl -A "Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_3_3 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8J2 Safari/6533.18.5" -s 'http://impresscms.org/' |grep -Po "version (\d{1})\.(\d{1,2})\.(\d{1,2})" |sed 's/version //g');

# Concrete5 - http://www.concrete5.org
CONCRETELATEST=$(curl -A "Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_3_3 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8J2 Safari/6533.18.5" -s 'http://www.concrete5.org/get-started' |grep -Po "Download (\d{1})\.(\d{1,2})\.(\d{1,2})\.(\d{1,2})" |head -n1 |sed 's/Download //g');

# Pligg - http://pligg.com
PLIGGLATEST=$(curl -A "Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_3_3 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8J2 Safari/6533.18.5" -s 'http://pligg.com/downloads/package/pligg-cms/' |grep -Po "Product Version (\d{1})\.(\d{1,2})\.(\d{1,2})" |sed 's/Product Version //g');

# Plone - https://plone.org
PLONELATEST=$(curl -A "Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_3_3 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8J2 Safari/6533.18.5" -s 'https://plone.org/products/plone/releases' |grep -Po "Plone (\d{1})\.(\d{1,2})\.(\d{1,2})" |head -n1 |sed 's/Plone //g');

# Frog - http://www.madebyfrog.com
FROGLATEST=$(curl -A "Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_3_3 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8J2 Safari/6533.18.5" -s 'http://www.madebyfrog.com/download.html' |grep -Po "version (\d{1})\.(\d{1,2})\.(\d{1,2})" |sed 's/version //g');

# MODX Revolution - http://modx.com
MODXREVLATEST=$(curl -A "Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_3_3 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8J2 Safari/6533.18.5" -s 'http://modx.com/download/' |grep -Po "Revolution (\d{1})\.(\d{1,2})\.(\d{1,2})?\-(\w{1,3})" |head -n1 |sed 's/Revolution //g');

# Typo3 - http://typo3.org
TYPOLATEST=$(curl -sI 'http://get.typo3.org/current' |grep -Po "src\-(\d{1})\.(\d{1,2})\.(\d{1,2})\.tar" |sed 's/src-//g' |sed 's/.tar//g');

# XOOPS - http://xoops.org
XOOPSLATEST=$(curl -A "Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_3_3 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8J2 Safari/6533.18.5" -s 'http://xoops.org/modules/core/' |grep -Po "XOOPS (\d{1})\.(\d{1,2})\.(\d{1,2})?\.(\d{1,2})" |sed 's/XOOPS //g');

# WHMCS - https://whmcs.com
WHMCSLATEST=$(curl -A "Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_3_3 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8J2 Safari/6533.18.5" -s 'https://download.whmcs.com/' |grep -Po "V(\d{1})\.(\d{1,2})?\.(\d{1,2})" |head -n1 |sed 's/V//g');

# phpBB - https://www.phpbb.com
PHPBBLATEST=$(curl -A "Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_3_3 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8J2 Safari/6533.18.5" -s https://www.phpbb.com/downloads/ |grep -Po "stable phpBB: (\d{1})\.(\d{1,2})\.(\d{1,2})" |sed 's/stable phpBB: //g')
####################################################

# Versioning file status.
VERSIONSFILE='/home/servergu/domains/repo.servergur.us/public_html/sshtool/lists/cms_latest';
VERSIONSTMPFILE="$VERSIONSFILE.tmp";

if [ -f $VERSIONSFILE ]; then WRITEFILE=$VERSIONSTMPFILE; else WRITEFILE=$VERSIONSFILE; fi
if [ -f $VERSIONSTMPFILE ]; then rm -f $VERSIONSTMPFILE; fi

# Version Reporting
echo "WORDPRESS=$WORDPRESSLATEST" >> $WRITEFILE;
echo "JOOMLA=$JOOMLALATEST" >> $WRITEFILE;
echo "DRUPAL=$DRUPALLATEST" >> $WRITEFILE;
echo "IMPRESSCMS=$IMPRESSLATEST" >> $WRITEFILE;
echo "CONCRETE5=$CONCRETELATEST" >> $WRITEFILE;
echo "PLIGG=$PLIGGLATEST" >> $WRITEFILE;
echo "PLONE=$PLONELATEST" >> $WRITEFILE;
echo "FROG=$FROGLATEST" >> $WRITEFILE;
echo "MODXREV=$MODXREVLATEST" >> $WRITEFILE;
echo "TYPO3=$TYPOLATEST" >> $WRITEFILE;
echo "XOOPS=$XOOPSLATEST" >> $WRITEFILE;
echo "WHMCS=$WHMCSLATEST" >> $WRITEFILE;

# Update Time Stamp
echo "" >> $WRITEFILE;
echo "UPDATED=$(date)" >> $WRITEFILE;

if [ $WRITEFILE=$VERSIONSTMPFILE ]; then mv -f $VERSIONSTMPFILE $VERSIONSFILE; fi

# Temp cron debugging.
echo "Ran @ $(date)" >> /home/servergu/domains/repo.servergur.us/public_html/sshtool/server_crons/run.log
