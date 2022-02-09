#!/bin/sh
HTTPD_HOME=$HOME/httpd
OPTIONS="-f $HTTPD_HOME/conf/httpd.conf"
PATH=$HTTPD_HOME/sbin:$PATH
LD_LIBRARY_PATH=$HTTPD_HOME/lib:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH HTTPD_HOME PATH
if [ `ps -ef | grep "/sbin/httpd" | grep "root" | grep -v "grep" | wc -l` -ge 1 ]; then
    sudo $HTTPD_HOME/sbin/apachectl ${OPTIONS} -k graceful
    sleep 1
    echo -e "\nApache Status = $(ps -ef | grep "/sbin/httpd" | grep "root" | grep -v grep | awk '{print "\tPID : " $2, "\tLocation : "$8}')"
    echo -e "httpd processis restarting.\n"
else
    echo -e "\nhttpd process is not running.\n"
fi
