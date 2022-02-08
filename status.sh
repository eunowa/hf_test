#!/bin/sh
. ./env.sh

echo "===  Process Check                                        ==="
echo "============================================================="
ps -ef | grep java | grep "DDOMAIN_GROUP_NAME=$DOMAIN_GROUP_NAME " | grep "SERVER=$SERVER_NAME "
