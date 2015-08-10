#!/bin/sh
## Live Version Lookups

# Curl with agent string variable options.
# Added server interface due to rate-limited IP logging. Will eventually have to rotate interfaces.
CURLCMD='curl --interface 'eth0:a3' -A "Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_3_3 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8J2 Safari/6533.18.5" -s'

## BLOGS/CMS
# WordPress - https://wordpress.org
WORDPRESSLATEST=$($CURLCMD "https://wordpress.org/download/" |grep -Po "Version (\d{1,3})?\.(\d{1,3})?\.(\d{1,3})" |sed 's/Version //g');
# Joomla - http://www.joomla.org
JOOMLALATEST=$($CURLCMD http://www.joomla.org/download.html |grep -Po "Joomla_(?:\d*\.?\d+\.?\d+)\-Stable\-Full\_Package\.zip" | grep -Po "(?:\d*\.?\d+\.?\d+)" |tr "\n" " ");
# Drupal - https://www.drupal.org
DRUPALLATEST=$($CURLCMD https://www.drupal.org/project/drupal | grep -Po "drupal\-(?:\d*\.?\d+\.?\d+).tar.gz" | grep -Po "(?:\d*\.?\d+\.?\d+)" |tr "\n" " ");
# ImpressCMS - http://impresscms.org
IMPRESSLATEST=$($CURLCMD 'http://impresscms.org/' |grep -Po "version (\d{1})\.(\d{1,2})\.(\d{1,2})" |sed 's/version //g');
# Concrete5 - http://www.concrete5.org
CONCRETELATEST=$($CURLCMD 'http://www.concrete5.org/get-started' |grep -Po "Download (\d{1})\.(\d{1,2})\.(\d{1,2})\.(\d{1,2})" |head -n1 |sed 's/Download //g');
# Pligg - http://pligg.com
PLIGGLATEST=$($CURLCMD 'http://pligg.com/downloads/package/pligg-cms/' |grep -Po "Product Version (\d{1})\.(\d{1,2})\.(\d{1,2})" |sed 's/Product Version //g');
# Plone - https://plone.org
PLONELATEST=$($CURLCMD 'https://plone.org/products/plone/releases' |grep -Po "Plone (\d{1})\.(\d{1,2})\.(\d{1,2})" |head -n1 |sed 's/Plone //g');
# Frog - http://www.madebyfrog.com
FROGLATEST=$($CURLCMD 'http://www.madebyfrog.com/download.html' |grep -Po "version (\d{1})\.(\d{1,2})\.(\d{1,2})" |sed 's/version //g');
# MODX Revolution - http://modx.com
MODXREVLATEST=$($CURLCMD 'http://modx.com/download/' |grep -Po "Revolution (\d{1})\.(\d{1,2})\.(\d{1,2})?\-(\w{1,3})" |head -n1 |sed 's/Revolution //g');
# Typo3 - http://typo3.org
TYPOLATEST=$(curl -sI 'http://get.typo3.org/current' |grep -Po "src\-(\d{1})\.(\d{1,2})\.(\d{1,2})\.tar" |sed 's/src-//g' |sed 's/.tar//g');
# XOOPS - http://xoops.org
XOOPSLATEST=$($CURLCMD 'http://xoops.org/modules/core/' |grep -Po "XOOPS (\d{1})\.(\d{1,2})\.(\d{1,2})?\.(\d{1,2})" |sed 's/XOOPS //g');
# Ghost - https://ghost.org
GHOSTLATEST=$($CURLCMD 'https://ghost.org/download/' |grep -Po "v\<b\>(\d{1})\.(\d{1,2})?\.(\d{1,2})" |sed 's/v<b>//g');
# Anchor - http://anchorcms.com
ANCHORLATEST=$($CURLCMD 'http://anchorcms.com/' |grep -Po "Download (\d{1})\.(\d{1,2})?\.(\d{1,2})" |sed 's/Download //g');
# Wagtail - http://www.wagtail.io
WAGTAILLATEST=$(curl -s https://raw.githubusercontent.com/torchbox/wagtail/v1.0/docs/releases/index.rst |head -n7 |tail -n1 |sed 's/   //g');
# CMS Made Simple - http://www.cmsmadesimple.org
CMSMADESIMPLELATEST=$($CURLCMD 'http://www.cmsmadesimple.org/downloads/' |grep "Version: " |head -n1 | cut -d ":" -f2 | cut -d "<" -f1 |sed 's/ //g');
# Blot - https://bolt.cm
BOLTLATEST=$($CURLCMD 'https://bolt.cm/' |grep -Po "version v (\d{1,2})\.(\d{1,2})?\.(\d{1,2})" |sed 's/version v //g');
# MovableType - https://movabletype.org
MOVABLETYPELATEST=$($CURLCMD 'https://movabletype.org/documentation/appendices/release-notes/' |grep -Po "(\d{1,2})\.(\d{1,2})?\.(\d{1,2})" |head -n1);

## BILLING
# WHMCS - https://whmcs.com
WHMCSLATEST=$($CURLCMD 'https://download.whmcs.com/' |grep -Po "V(\d{1})\.(\d{1,2})?\.(\d{1,2})" |head -n1 |sed 's/V//g');
# Blesta - http://www.blesta.com
BLESTALATEST=$($CURLCMD 'http://www.blesta.com/blog/' |grep -Po "Download (\d{1})\.(\d{1,2})?\.(\d{1,2}) Full" |head -n1 |sed 's/Download //g' |sed 's/ Full//g');

## FORUM/BB
# phpBB - https://www.phpbb.com
PHPBBLATEST=$($CURLCMD 'https://www.phpbb.com/downloads/' |grep -Po "stable phpBB: (\d{1})\.(\d{1,2})\.(\d{1,2})" |sed 's/stable phpBB: //g');
# IPBoard - https://www.invisionpower.com
# Blocked roots.

## SOCIAL
# BuddyPress - https://buddypress.org
BUDDYPRESSLATEST=$($CURLCMD 'https://buddypress.org/download/' |grep -Po "(\d{1})\.(\d{1,2})?\.(\d{1,2})\.(\d{1,2})" |head -n1);
# Elgg - https://elgg.org
ELGGLATEST=$($CURLCMD 'https://elgg.org/' |grep -Po "(\d{1})\.(\d{1,2})?\.(\d{1,2})");

## ECOMMERCE
# OpenCart - http://www.opencart.com
OPENCARTLATEST=$($CURLCMD 'http://www.opencart.com/index.php?route=download/download' |grep -Po "(\d{1})\.(\d{1,2})?\.(\d{1,2})\.(\d{1,2})" |head -n1);
# PrestaShop - https://www.prestashop.com
PRESTASHOPLATEST=$($CURLCMD 'https://www.prestashop.com/en/download' |grep -Po "(\d{1})\.(\d{1,2})?\.(\d{1,2})\.(\d{1,2})" |head -n1);
# Magento - https://www.magentocommerce.com
MAGENTOLATEST=$($CURLCMD 'https://www.magentocommerce.com/download' |grep -Po "(\d{1})\.(\d{1,2})?\.(\d{1,2})\.(\d{1,2})" |head -n1);

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
echo "GHOST=$GHOSTLATEST" >> $WRITEFILE;
echo "ANCHOR=$ANCHORLATEST" >> $WRITEFILE;
echo "CMSMADESIMPLE=$CMSMADESIMPLELATEST" >> $WRITEFILE;
echo "BOLT=$BOLTLATEST" >> $WRITEFILE;
echo "MOVABLETYPE=$MOVABLETYPELATEST" >> $WRITEFILE;
echo "WHMCS=$WHMCSLATEST" >> $WRITEFILE;
echo "BLESTA=$BLESTALATEST" >> $WRITEFILE;
echo "PHPBB=$PHPBBLATEST" >> $WRITEFILE;
echo "BUDDYPRESS=$BUDDYPRESSLATEST" >> $WRITEFILE;
echo "ELGG=$ELGGLATEST" >> $WRITEFILE;
echo "OPENCART=$OPENCARTLATEST" >> $WRITEFILE;
echo "PRESTASHOP=$PRESTASHOPLATEST" >> $WRITEFILE;
echo "MAGENTO=$MAGENTOLATEST" >> $WRITEFILE;

# Update Time Stamp
echo "" >> $WRITEFILE;
echo "UPDATED=$(date)" >> $WRITEFILE;

if [ $WRITEFILE=$VERSIONSTMPFILE ]; then mv -f $VERSIONSTMPFILE $VERSIONSFILE; fi

# Temp cron debugging.
echo "Ran @ $(date)" >> /home/servergu/domains/repo.servergur.us/public_html/sshtool/server_crons/run.log