#!/bin/bash
#Currently For use in CentOS/RedHat/Fedora based servers
version='0.04.dpl'
pulld='09-03-2014 10:30:01'
SGFILE=sshtool_main.rc
SGLOC="http://repo.servergur.us/sshtool/php"

alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -i"

if [ -f /tmp/$SGFILE ]; then
	rm -f /tmp/$SGFILE
elif [ -f /dev/shm/$SGFILE ]; then
	rm -f /dev/shm/$SGFILE
fi

#if [ $(ps aux|grep "/tmp/sgmain.rc" |grep -v "grep" |wc -l) -gt 2 ]; then
#	echo "Someone is already logged in with SGSSH. Go Away."
#	exit
#fi

shopt -s histappend
export HISTFILE="${HOME}/support/.bash_history_kh"
export HISTTIMEFORMAT="%d/%m/%y %T "
export PROMPT_COMMAND="history -a; history -n"

LS_OPTIONS='--color=tty -F -a -b -T 0'; #Lets set some options for 'ls' for nicer printing
export LS_OPTIONS;
alias ls='/bin/ls $LS_OPTIONS';
eval $(dircolors -b)

if [ "$(id -u)" -eq 0 ]; then #Are we root?
	SGUSER="root"
else
	SGUSER="other"
fi

SGPASS="\\033[60G\\033[0;39m[\\033[1;32mPASS\\033[0;39m]"
SGFAIL="\\033[60G\\033[0;39m[\\033[1;31mFAIL\\033[0;39m]"
SGWARN="\\033[60G\\033[0;39m[\\033[1;33mWARN\\033[0;39m]"
SGBOLD=$(tput bold)
SGNORM=$(tput sgr0)
SGSEC="$(tput sgr0)[\\033[1;31mSECURITY$(tput sgr0)]"

function echo_pass(){
	echo -e "\\033[1;32m$@ \\033[60G\\033[0;39m[\\033[1;32mPASS\\033[0;39m]"
}

function echo_fail(){
	echo -e "\\033[1;31m$@ \\033[60G\\033[0;39m[\\033[1;31mFAIL\\033[0;39m]"
}

function echo_warn(){
	echo -e "\\033[1;33m$@ \\033[60G\\033[0;39m[\\033[1;33mWARN\\033[0;39m]"
}

df -h|awk -v SGPASS=$SGPASS -v SGFAIL=$SGFAIL -v SGWARN=$SGWARN -v SGBOLD=$SGBOLD -v SGNORM=$SGNORM '/[[:digit:]]+%/ {
	if( $5 ~ /1?[90][0-9]%/ ) {
		print "Usage of " $6 " has reached " SGBOLD $5 SGNORM " and " SGBOLD $4 SGNORM " is available" SGFAIL
	} else if ( $5 ~ /1?[80][5-9]%/ ) {
		print "Usage of " $6 " has reached " SGBOLD $5 SGNORM " and " SGBOLD $4 SGNORM " is available" SGWARN
	} 
}' 

if [ -f /proc/vz/version ];then #This is an OpenVZ node
    
	echo 'This is a node!'
    
elif [ -d /proc/vz/ ];then #This is a VPS on an OpenVPS node

	SGSERVER="VZ"

	if [ -f /etc/redhat-release ]; then #A RedHat based distro
		SGOS="RH"
		#cat /etc/redhat-release

		if [ ! -d ~/support/logs ];then #Making a directory to leave our stuff
			mkdir -p ~/support/logs 
		fi

		SGinit="/etc/init.d"
		if [ -f ${SGinit}/psa ];then
			SGPANEL="PSA"
		elif [ -f ${SGinit}/cpanel ];then
			SGPANEL="cP"
		elif [ -f ${SGinit}/directadmin ];then
			SGPANEL="DA"
		else
			SGPANEL="NA"
		fi

		if [ $SGUSER = "root" ]; then
			if grep -q CentOS /etc/redhat-release ;then
				#cat /etc/redhat-release | tr -d "\n"
				awk -v SGPASS=$SGPASS -v SGFAIL=$SGFAIL -v SGWARN=$SGWARN '{
					if($3>=6.5){ 
						print $0 SGPASS 
					} else if($3 ~ /5.1[0-9]/){ 
						print $0 SGWARN 
					} else {
						print $0 SGFAIL 
					}
				}' /etc/redhat-release
			fi

			#Servers MTA and IMAP (VPS)
			if [ -f ${SGinit}/exim ]; 
				then SGMTA1="Exim"
			elif [ -f ${SGinit}/postfix ];
				then SGMTA1="Postfix"
			elif [ -f ${SGinit}/qmail ];
				then SGMTA1="Qmail"
			else 
				SGMTA1="NA"
			fi 

			if [ -f ${SGinit}/dovecot ];
				then SGMTA2="Dovecot"
			elif [ -f ${SGinit}/courier-imapd ];
				then SGMTA2="Courier"
			elif [ -f /usr/sbin/courierlogger ];
				then SGMTA2="Courier"
			else 
				SGMTA2="NA"
			fi
			SGMTA="${SGMTA1} / ${SGMTA2}"
			echo "VPS MTA: $SGMTA"
#			echo "VPS MTA: $SGMTA" | awk -v SGPASS=$SGPASS -v SGWARN=$SGWARN '{
#		                if( $3 = "Exim") {
#                		    print $0 SGPASS
#		                } else {
#		                    print $0 SGWARN
#		                }
#		            }'

			php -v | head -n 1 | awk -v SGPASS=$SGPASS -v SGFAIL=$SGFAIL -v SGWARN=$SGWARN '{
				if( $2 ~ /[5-9].[4-9]./ ) {
					print $0 SGPASS
				} else if( $2 ~ /5.3./ ) {
					print $0 SGWARN
				} else {
					print $0 SGFAIL
				}
			}' 
			SGCTID=$(awk '{print $1}' /proc/vz/veinfo) #Grab the container ID of the VPS
			SGNODE=$(traceroute -T -N1 -m1 -q1 -w0 google.com | tail -1|awk {'print $2'}|cut -d. -f1) #Terrible way of getting the first part of nodes hostname. Unreliable.
			#SGNODE=$(traceroute -T -q1 -w0 google.com |egrep "^ 1"|awk {'print $2'}|cut -d. -f1) #Terrible way of getting the first part of nodes hostname. Unreliable.
			SGIP=$(awk '{print $NF}' /proc/vz/veinfo)  #Grab an IP of the VPS
			PS1="$SGPANEL/$SGNODE/$SGCTID \u@$SGIP [\w]# "
		else
			SGIP=$(hostname -i)
			PS1="$SGPANEL/$SGSERVER \u@$SGIP [\w]$ "
		fi
	fi

else #this is a dedicated server

	echo 'This is a dedicated server!'
	SGSERVER="DEDI"
	SGIP=$(hostname -i)
	if [ -f /etc/redhat-release ]; then #A RedHat based distro
		SGOS="RH"
		cat /etc/redhat-release

		if [ ! -d ~/support/logs ];then #Making a directory to leave our stuff
			mkdir -p ~/support/logs 
		fi

		SGinit="/etc/init.d"
		if [ -f ${SGinit}/psa ];then
			SGPANEL="PSA"
		elif [ -f ${SGinit}/cpanel ];then
			SGPANEL="cP"
		elif [ -f ${SGinit}/directadmin ];then
			SGPANEL="DA"
		else
			SGPANEL="NA"
		fi

		#Servers MTA and IMAP (Dedi)
		if [ -f ${SGinit}/exim ]; 
			then SGMTA1="Exim"
		elif [ -f ${SGinit}/postfix ];
			then SGMTA1="Postfix"
		elif [ -f ${SGinit}/qmail ];
			then SGMTA1="Qmail"
		else 
			SGMTA1="NA"
		fi 

		if [ -f ${SGinit}/dovecot ];
			then SGMTA2="Dovecot"
		elif [ -f ${SGinit}/courier-imapd ];
			then SGMTA2="Courier"
		else 
			SGMTA2="NA"
		fi
		SGMTA="${SGMTA1} / ${SGMTA2}"
		echo "Dedi MTA: $SGMTA"

# - Remove Pass / Warn until function proves correct.
#		echo "Dedi MTA: $SGMTA" | awk -v SGPASS=$SGPASS -v SGWARN=$SGWARN '{
#                if( $3 = "Exim") {
#                    print $0 SGPASS
#                } else {
#                    print $0 SGWARN
#                }
#            }'

		if [ $SGUSER = "root" ]; then
			#Attempting to fix php version not being relayed on dedis. https://git.servergur.us/gurudavid/sshtool/issues/1
			php -v | head -n 1 | awk -v SGPASS=$SGPASS -v SGFAIL=$SGFAIL -v SGWARN=$SGWARN '{
        	                        if( $2 ~ /[5-9].[4-9]./ ) {
                	                        print $0 SGPASS
                	       	        } else if( $2 ~ /5.3./ ) {
        	                       	        print $0 SGWARN
	                                } else {
        	                                print $0 SGFAIL
                	                }
	                        }' 

			PS1="$SGPANEL/$SGSERVER \u@$SGIP [\w]# "
		else
			PS1="$SGPANEL/$SGSERVER \u@$SGIP [\w]# "
		fi
	fi

fi

if [ -n "$SGSERVER" ] && [ -n "$SGOS" ] && [ -n "$SGPANEL" ] && [ -n "$SGUSER" ]; then
	if [ -w /dev/shm/ ]; then
		if wget -qO /dev/shm/secrc "${SGLOC}/sec.php?SGOS=$SGOS&SGSERVER=$SGSERVER&SGPANEL=$SGPANEL&SGUSER=$SGUSER" ; then
			source /dev/shm/secrc 
			rm -f /dev/shm/secrc
			echo "Use ${SGBOLD}'listfunctions'${SGNORM} to see added commands"
		else
			Failed to wget secrc
		fi
	else
		if wget -qO /tmp/secrc "${SGLOC}/sec.php?SGOS=$SGOS&SGSERVER=$SGSERVER&SGPANEL=$SGPANEL&SGUSER=$SGUSER" ; then
			source /tmp/secrc 
			rm -f /tmp/secrc
			echo "Use 'listfunctions' to see added commands"
		else
			Failed to wget secrc
		fi
	fi
else
	echo 'Failed to get the second rcfile. Failling back to "~/.bashrc"'
	source ~/.bashrc
fi

if [ ! -d ${HOME}/support/logs ];then #Making a directory to leave our stuff
	mkdir -p ${HOME}/support/logs 
fi

if [ ! -d ${HOME}/support/.bin ];then #Making a directory to leave our stuff
	mkdir -p ${HOME}/support/.bin 
fi

<?php
	if (isset($_GET['PS1'])) {
		echo "PS1=\"" . base64_decode($_GET['PS1']) . "\"";
	}
?>

echo "Loaded SSHTool $version Last Pulled @ $pulld | Loaded/used on $(curl -s http://repo.servergur.us/sshtool/php/stats.php | grep -o '[0-9]\+') servers!"

if [ -f /root/support/.ssht.msg ]; then
	echo "Read the message:" echo_warn;
	cat /root/support/.ssht.msg;
	echo " ";
else
	echo " ";
fi

