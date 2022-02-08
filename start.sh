#!/bin/sh
DATE=`date +%Y%m%d%H%M%S`
export JAVA_OPTS="$AGENT_OPTS $JAVA_OPTS"
. ./env.sh

PID=`ps -ef | grep java | grep "DDOMAIN_GROUP_NAME=$DOMAIN_GROUP_NAME " | grep "=$SERVER_NAME " | awk '{print $2}'`
echo $PID

if [ e$PID != "e" ]
then
echo "HyperFrame - $SERVER_NAME is already RUNNING..."
exit;
fi

UNAME=`id -u -n`
if [ e$UNAME != "e$JBOSS_USER" ]
then
echo "Use $JBOSS_USER account to start HyperFrame - $SERVER_NAME..."
exit;
fi

#
echo $JAVA_OPTS

if [ ! -d "$JBOSS_LOG_DIR/nohup" ];
then
mkdir -p $JBOSS_LOG_DIR/nohup
fi

if [ ! -d "$JBOSS_LOG_DIR/gclog" ];
then
mkdir -p $JBOSS_LOG_DIR/gclog
fi

if [ ! -d "$JBOSS_LOG_DIR/dump" ];
then
mkdir -p $JBOSS_LOG_DIR/dump
fi

if [ ! -d "$JBOSS_LOG_DIR/heapdump" ];
then
mkdir -p $JBOSS_LOG_DIR/heapdump
fi

mv $JBOSS_LOG_DIR/nohup/$SERVER_NAME.out $JBOSS_LOG_DIR/nohup/$SERVER_NAME.out.$DATE

#nohup $JBOSS_HOME/bin/standalone.sh -DSERVER=$SERVER_NAME -b $BIND_ADDR -u $MULTICAST_ADDR -P=$DOMAIN_BASE/$SERVER_NAME/bin/env.properties -c $CONFIG_FILE >> $SERVER_NAME.out 2>&1 &
nohup $JBOSS_HOME/bin/standalone.sh -DSERVER=$SERVER_NAME -P=$DOMAIN_BASE/$SERVER_NAME/bin/env.properties -c $CONFIG_FILE >> $JBOSS_LOG_DIR/nohup/$SERVER_NAME.out 2>&1 &

if [ e$1 = "etail" ]
then
tail -f $JBOSS_LOG_DIR/nohup/$SERVER_NAME.out
fi
