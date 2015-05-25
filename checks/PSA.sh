awk -v SGPASS=$SGPASS -v SGFAIL=$SGFAIL -v SGWARN=$SGWARN '{
	if($1 ~ /^12.[0-9]?[0-9].[0-9]?[0-9]/){ 
		print "Plesk Version: " $0 SGPASS  
	} else {
		print "Plesk Version: " $0 SGFAIL 
	}
}' /usr/local/psa/core.version
