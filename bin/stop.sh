#!/bin/bash

#---------------------------------------------------
# Licensed to the China UnionPay License (UPL)
# https://github.com/liningwonder
# All rights reversed
#---------------------------------------------------

# shellcheck disable=SC2046
APP_HOME_PATH=$(cd `dirname $0`; pwd)

cd "${APP_HOME_PATH}"

APP_NAME=app.jar

get_pid(){
  JAVA_PID=`ps -ef | grep java | grep ${APP_NAME} | grep -v grep | awk '{print $2}'`
  echo $JAVA_PID;
}

PID_FILE=${APP_HOME_PATH}/bin/app.pid

if [ ! -f "${PID_FILE}" ];then
	echo "app is not running. exists"
	exit
fi

pid=`get_pid`

echo -e "`hostname`: stopping app $pid ... "
kill $pid