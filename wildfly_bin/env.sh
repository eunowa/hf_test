#!/bin/sh
DATE=`date +%Y%m%d_%H%M%S`

##### JBOSS Directory Setup #####
export JBOSS_HOME=/app/hfwas/wildfly
export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.322.b06-1.el7_9.x86_64
export DOMAIN_GROUP_NAME=WWW
export DOMAIN_BASE=/app/hfwas/hf_instance
export SERVER_NAME=INS11
export JBOSS_LOG_DIR=$DOMAIN_BASE/$SERVER_NAME/log

##### Configration File #####
export HOST_NAME=`hostname`
export NODE_NAME=$SERVER_NAME
export CONFIG_FILE=standalone-ha.xml
export PORT_OFFSET=0
export JBOSS_USER=hfwas

##### Bind Address #####
export BIND_ADDR=`hostname`
export MULTICAST_ADDR=230.0.0.4
#export MULTICAST_PORT=55200
export MODCLUSTER_MULTICAST_ADDR=224.0.1.105
export MGMT_ADDR=$BIND_ADDR
export CONTROLLER_IP=$MGMT_ADDR

let CONTROLLER_PORT=9990+$PORT_OFFSET
export CONTROLLER_PORT
let CONSOLE_PORT=9990+$PORT_OFFSET
export CONSOLE_PORT
let HTTP_PORT=8080+$PORT_OFFSET
export HTTP_PORT
export LAUNCH_JBOSS_IN_BACKGROUND=true

##### JBoss System module and User module directory #####
export JBOSS_MODULEPATH=$JBOSS_HOME/modules:$JBOSS_HOME/modules.ext

export JAVA_OPTS="$JAVA_OPTS -Djava.util.logging.manager=org.jboss.logmanager.LogManager"
export JBOSS_LOGMANAGER_DIR="$JBOSS_HOME/modules/system/layers/base/org/jboss/logmanager/main"
#export JBOSS_LOGMANAGER_DIR="$JBOSS_HOME/modules/system/layers/base/.overlays/layer-base-jboss-eap-7.3.4.CP/org/jboss/logmanager/main"
export JBOSS_LOGMANAGER_JAR=`cd "$JBOSS_LOGMANAGER_DIR" && ls -1 *.jar`
export JBOSS_WILDCOMMON_DIR="$JBOSS_HOME/modules/system/layers/base/org/wildfly/common/main"
#export JBOSS_WILDCOMMON_DIR="$JBOSS_HOME/modules/system/layers/base/.overlays/layer-base-jboss-eap-7.3.4.CP/org/wildfly/common/main"
export JBOSS_WILDCOMMON_JAR=`cd "$JBOSS_WILDCOMMON_DIR" && ls -1 *.jar`
export JAVA_OPTS="$JAVA_OPTS -Xbootclasspath/p:$JBOSS_LOGMANAGER_DIR/$JBOSS_LOGMANAGER_JAR:$WILDFLY_COMMON_JAR:$JBOSS_WILDCOMMON_DIR/$JBOSS_WILDCOMMON_JAR"
export JAVA_OPTS=" $JAVA_OPTS -noverify"

##### JVM Options #####
export JAVA_OPTS="-server $JAVA_OPTS"
export JAVA_OPTS=" $JAVA_OPTS -XX:+DoEscapeAnalysis"
export JAVA_OPTS=" $JAVA_OPTS -XX:+UseParallelGC"
export JAVA_OPTS=" $JAVA_OPTS -XX:+UseParallelOldGC"
export JAVA_OPTS=" $JAVA_OPTS -Xms2048m -Xmx2048m"
export JAVA_OPTS=" $JAVA_OPTS -XX:MetaspaceSize=256m -XX:MaxMetaspaceSize=256m"
export JAVA_OPTS=" $JAVA_OPTS -Dlog4j2.formatMsgNoLookups=true"
export JAVA_OPTS=" $JAVA_OPTS -verbose:gc"
export JAVA_OPTS=" $JAVA_OPTS -Xloggc:$JBOSS_LOG_DIR/gclog/gc.log.`date +%Y%m%d%H%M%S`"
export JAVA_OPTS=" $JAVA_OPTS -XX:+PrintGCDetails"
export JAVA_OPTS=" $JAVA_OPTS -XX:+PrintGCTimeStamps"
export JAVA_OPTS=" $JAVA_OPTS -XX:+PrintGCApplicationStoppedTime"
export JAVA_OPTS=" $JAVA_OPTS -XX:+HeapDumpOnOutOfMemoryError"
export JAVA_OPTS=" $JAVA_OPTS -XX:HeapDumpPath=$JBOSS_LOG_DIR/heapdump"
#export JAVA_OPTS=" $JAVA_OPTS -XX:+UseCompressedOops"
#export JAVA_OPTS=" $JAVA_OPTS -XX:+UseCompressedClassPointers"
#export JAVA_OPTS=" $JAVA_OPTS -XX:CompressedClassSpaceSize=1024M"
export JAVA_OPTS=" $JAVA_OPTS -Djboss.modules.system.pkgs=org.jboss.byteman,org.jboss.logmanager,org.wildfly.common.net.HostName"
#export JAVA_OPTS=" $JAVA_OPTS -Djboss.modules.system.pkgs=org.jboss.byteman"
export JAVA_OPTS=" $JAVA_OPTS -Djava.awt.headless=true"

export JAVA_OPTS=" $JAVA_OPTS -DDOMAIN_GROUP_NAME=$DOMAIN_GROUP_NAME"
export JAVA_OPTS=" $JAVA_OPTS -Djboss.server.base.dir=$DOMAIN_BASE/$SERVER_NAME"
export JAVA_OPTS=" $JAVA_OPTS -Djboss.socket.binding.port-offset=$PORT_OFFSET"
export JAVA_OPTS=" $JAVA_OPTS -Djboss.node.name=$NODE_NAME"
export JAVA_OPTS=" $JAVA_OPTS -Djboss.bind.address.management=$MGMT_ADDR"
export JAVA_OPTS=" $JAVA_OPTS -Djboss.bind.address.private=$MGMT_ADDR"
export JAVA_OPTS=" $JAVA_OPTS -Djboss.bind.address=$BIND_ADDR"
export JAVA_OPTS=" $JAVA_OPTS -Djgroups.bind_addr=$BIND_ADDR"
export JAVA_OPTS=" $JAVA_OPTS -Djboss.default.multicast.address=$MULTICAST_ADDR"
export JAVA_OPTS=" $JAVA_OPTS -Djboss.messaging.group.address=$JMS_MULTICAST_ADDR"
export JAVA_OPTS=" $JAVA_OPTS -Djboss.modcluster.multicast.address=$MODCLUSTER_MULTICAST_ADDR"
export JAVA_OPTS=" $JAVA_OPTS -Djboss.server.log.dir=$JBOSS_LOG_DIR"
export JAVA_OPTS=" $JAVA_OPTS -Dorg.jboss.as.logging.per-deployment=false"
export JAVA_OPTS=" $JAVA_OPTS -Dsun.util.logging.disableCallerCheck=true"

# jgroups setting
#export JAVA_OPTS=" $JAVA_OPTS -Djboss.default.jgroups.stack=tcp"
#export JAVA_OPTS=" $JAVA_OPTS -Djgroups.tcpping.initial_hosts=192.168.10.161[7600],192.168.10.162[7600]"

echo "============================================================="
echo "===  TmaxSoft HyperFrame Opensource Middlerware Flatform  ==="
echo "============================================================="
echo " - HYPERFRAME_HOME=$JBOSS_HOME"
echo " - INSTANCE_BASE=$DOMAIN_BASE"
echo " - SERVER_NAME=$SERVER_NAME"
echo " - CONFIG_FILE=$CONFIG_FILE"
echo " - BIND_ADDR=$BIND_ADDR"
echo " - PORT_OFFSET=$PORT_OFFSET"
echo " - MULTICAST_ADDR=$MULTICAST_ADDR"
echo " - CONTROLLER=$CONTROLLER_IP:$CONTROLLER_PORT"
echo " - CONSOLE=http://$CONTROLLER_IP:$CONSOLE_PORT"
echo " - SERVICE=http://$BIND_ADDR:$HTTP_PORT"
echo "============================================================="
