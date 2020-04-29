#!/bin/bash
# shellcheck disable=SC2046
# dos2unix start.sh
# shellcheck disable=SC2006
# shellcheck disable=SC2164
SCRIPT_PATH=$(cd `dirname $0`; pwd)
cd "${SCRIPT_PATH}"
APP_HOME_PATH=$(dirname "$PWD")
JAVA_HOME=/usr/jdk1.8.0_221
LOG_CONF_FILE=${APP_HOME_PATH}/conf/log4j2.xml
START_LOG=${APP_HOME_PATH}/logs/start.log

for i in ${APP_HOME_PATH}/lib/*;
  do CLASSPATH=$i:"$CLASSPATH";
done

JAVA_OPTIONS="-Xms1024m -Xmx2048m"
JAVA_OPTIONS="$JAVA_OPTIONS -XX:+HeapDumpOnOutOfMemoryError"
# shellcheck disable=SC2027
#log4j2支持自动重新配置,如果配置了monitorInterval，那么log4j2每隔一段时间就会检查一遍这个文件是否修改。最小是5s
JAVA_OPTIONS="$JAVA_OPTIONS -Dlog4j.configurationFile=file:"${LOG_CONF_FILE}""
nohup $JAVA_HOME/bin/java -server "${JAVA_OPTIONS}" -classpath "${CLASSPATH}" com.datafusion.maven.assembly.Main >> $START_LOG 2>&1 &