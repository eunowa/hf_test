#/bin/sh
HTTPD_HOME=$HOME/httpd
OPTIONS="-f $HTTPD_HOME/conf/httpd.conf"
PATH=$HTTPD_HOME/sbin:$PATH
LD_LIBRARY_PATH=$HTTPD_HOME/lib:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH HTTPD_HOME PATH
if [ `ps -ef | grep httpd | grep "root" | grep -v "grep" | wc -l` -eq 0 ]; then
    echo -e "\nhttpd process is stoped.\n"
else
    sudo $HTTPD_HOME/sbin/apachectl ${OPTIONS} -k stop
    sleep 1
    if [ `ps -ef | grep "/sbin/httpd" | grep "root" | grep -v "grep" | wc -l` -eq 0 ]; then
          echo -e "\nhttpd process is stoped.\n"
    else
          echo -e "\nApache Status = $(ps -ef | grep "/sbin/httpd" | grep "root" | grep -v grep | awk '{print "\tPID : " $2, "\tLocation : "$8}')"
          echo -e "httpd process is running.\n"
    fi
fi
