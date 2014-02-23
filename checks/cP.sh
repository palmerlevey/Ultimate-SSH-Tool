/usr/local/cpanel/bin/rebuild_phpconf --current | awk -v SGPASS=$SGPASS -v SGFAIL=$SGFAIL -v SGWARN=$SGWARN -v SGSEC=$SGSEC '/PHP5/ {
	if( $3 ~ /[Ss][Uu][Pp][Hh][Pp]/ ) {
		print $0 SGPASS
		while ((getline line < "/etc/csf/csf.pignore") > 0) {
			if (line ~ /^[[:blank:]]*p?(cmd|exe):\/usr\/bin\/php[[:blank:]]*$/) {
				print SGSEC " Remove " line " from csf.pignore" SGFAIL
			}
		}
	} else if( $3 ~ /[Ff][Cc][Gg][Ii]/ ) {
		print $0 SGWARN
	} else {
		print $0 SGFAIL
		while ((getline line < "/etc/csf/csf.pignore") > 0) {
			if (line ~ /^[[:blank:]]*p?(cmd|exe):\/usr\/bin\/php[[:blank:]]*$/) {
				print SGSEC " Remove " line " from csf.pignore" SGFAIL
			}
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