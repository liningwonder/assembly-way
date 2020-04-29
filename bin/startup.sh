#!/bin/bash

#---------------------------------------------------
# Licensed to the China UnionPay License (UPL)
# https://github.com/liningwonder
# All rights reversed
#---------------------------------------------------

# shellcheck disable=SC2046
APP_HOME_PATH=$(cd `dirname $0`; pwd)

cd "${APP_HOME_PATH}"

echo "current home path is " "${APP_HOME_PATH}"

#需要显示修改
JAVA_HOME=/usr/java/jdk1.8.0_131
#java命令
#JAVA=$(which java)
JAVA_CMD=${JAVA_HOME}/bin/java

PID_FILE=${APP_HOME_PATH}/bin/app.pid

get_pid(){
  JAVA_PID=`ps -ef | grep java | grep ${APP_NAME} | grep -v grep | awk '{print $2}'`
  echo $JAVA_PID;
}

pid=`get_pid`

if [ -f ${PID_FILE} ] ; then
	echo "Found pid file, Please run stop.sh first, then startup.sh" 2>&2
  exit 1
fi

for i in ${APP_HOME_PATH}/lib/*;
  do CLASSPATH=$i:"$CLASSPATH";
done

JAVA_OPTS="-server -Xms2048m -Xmx2048m -XX:+HeapDumpOnOutOfMemoryError"

LOG_FILE=${APP_HOME_PATH}/conf/log4j2.xml

if [ -e ${LOG_FILE} ] ; then
  ${JAVA_CMD} ${JAVA_OPTS} -classpath .:${CLASSPATH} com.datafusion.maven.assembly.Main >> ${APP_HOME_PATH}/bin/nohup.out 2>&1 &
  echo $! > ${PID_FILE}
else
	echo "log configration file(${LOG_FILE}) is not exist,please create then first!"
fi


