#/bin/sh
HTTPD_HOME=$HOME/httpd
OPTIONS="-f $HTTPD_HOME/conf/httpd.conf"
PATH=$HTTPD_HOME/bin:$PATH
LD_LIBRARY_PATH=$HTTPD_HOME/lib:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH HTTPD_HOME PATH
if [ `ps -ef | grep "/bin/httpd" | grep "root" | grep -v " grep" | wc -l` -eq 0 ]; then
    sudo $HTTPD_HOME/bin/apachectl ${OPTIONS} -k start
    sleep 1
    if [ `ps -ef | grep httpd | grep -v "grep" | wc -l` -ge 1 ]; then
          echo -e "\nApache Status = $(ps -ef | grep "/bin/httpd" | grep "root" | grep -v grep | awk '{print "\tPID : " $2, "\tLocation : "$8}')"
          echo -e "httpd process is running.\n"
    else
          echo -e "\nhttpd process is not running.\n"
    fi
else
    echo -e "\nhttpd process is running.\n"
fi
