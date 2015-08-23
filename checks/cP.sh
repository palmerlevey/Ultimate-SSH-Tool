SGINFO="\\033[60G\\033[0;39m[\\033[1;34mINFO\\033[0;39m]"

/usr/local/cpanel/bin/rebuild_phpconf --current | awk -v SGPASS=$SGPASS -v SGFAIL=$SGFAIL -v SGWARN=$SGWARN -v SGSEC=$SGSEC '/PHP5/ { HAND=$0 } /RUID/ { DSOR=$0
	if( HAND ~ /[Ss][Uu][Pp][Hh][Pp]/ ) {
	        print HAND SGPASS
    	} else if( HAND ~ /[Dd][Ss][Oo]/ && DSOR ~ /[Ee][Nn][Aa][Bb][Ll][Ee][Dd]/ ) {
        	if( system( "test -f /usr/local/lsws/bin/lswsctrl" ) != 0 ) {
            		print HAND " + mod_ruid" SGPASS
        	} else {
            		print HAND " + mod_ruid is incompatible with LiteSpeed" SGFAIL
        	}            
	} else if( HAND ~ /[Ff][Cc][Gg][Ii]/ ) {
		print HAND SGWARN
	} else {
		print HAND SGFAIL
	}

	while ((getline line < "/etc/csf/csf.pignore") > 0) {
		if (line ~ /^[[:blank:]]*p?(cmd|exe):\/usr\/bin\/php[[:blank:]]*$/) {
            		print SGSEC " Remove " line " from csf.pignore" SGFAIL
        	}
	}
}'
awk -v SGPASS=$SGPASS -v SGFAIL=$SGFAIL -v SGWARN=$SGWARN '{
        if($1 ~ /^11.[4-9][0-9]/){
                print "cPanel Version: " $0 SGPASS
        } else {
                print "cPanel Version: " $0 SGFAIL
        }
}' /usr/local/cpanel/version

if [[ -f /usr/local/lsws/bin/lswsctrl ]]; then
    echo -e "LiteSpeed is installed $SGINFO"
fi

if [[ -f /usr/sbin/nginx ]]; then
    if [[ -f /usr/local/cpanel/whostmgr/docroot/cgi/nginx.php ]]; then
        echo -e "nginxCP is installed $SGINFO"
    elif [[ -f /usr/local/cpanel/whostmgr/docroot/cgi/engintron.php ]]; then
        echo -e "nginx / Enginetron is installed $SGINFO"
    else
        echo -e "nginx binaries present; plugin unknown $SGWARN"
    fi
fi

if [ -e /usr/local/frontpage/version5.0/bin/owsadm.exe ]; then
        echo -e "Frontpage Installed" $SGFAIL;
fi
