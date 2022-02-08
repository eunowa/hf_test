#!/bin/sh
. ./env.sh

tail -f $JBOSS_LOG_DIR/server.log
