#!/bin/bash
current_path=`pwd`
bin_abs_path=$(readlink -f $(dirname $0))
base=${bin_abs_path}/..

LOG4J_CONFIG_FILE= $base/conf/log4j.xml


if [ -f $base/bin/app.pid ] ; then
	echo "found app.pid , Please run stop.sh first ,then startup.sh" 2>&2
  exit 1
fi

if [ ! -d $base/logs ] ; then
	mkdir -p $base/logs
fi

START_LOG=$base/logs/start.log

if [ ! -f $START_LOG ] ; then
	echo "" > $START_LOG
fi


JAVA_HOME=/usr/jdk1.8.0_221
JAVA=$JAVA_HOME/bin/java
JAVA_OPTS="-server -Xms2048m -Xmx2048m"
JAVA_OPTS="$JAVA_OPTS -XX:+HeapDumpOnOutOfMemoryError"
JAVA_OPTS="$JAVA_OPTS -XX:+UseG1GC -XX:MaxGCPauseMillis=250 -XX:+UseGCOverheadLimit -XX:+ExplicitGCInvokesConcurrent -XX:+PrintAdaptiveSizePolicy -XX:+PrintTenuringDistribution"
JAVA_OPTS="$JAVA_OPTS -Djava.awt.headless=true -Djava.net.preferIPv4Stack=true -Dfile.encoding=UTF-8 -Dlog4j.configurationFile=${LOG4J_CONFIG_FILE}"

for i in $base/lib/*;
    do CLASSPATH=$i:"$CLASSPATH";
done

CLASSPATH="$base/conf:$CLASSPATH";

cd $bin_abs_path

$JAVA $JAVA_OPTS -classpath .:$CLASSPATH com.datafusion.maven.assembly.Main >>$START_LOG 2>&1 &

echo $! > $base/bin/admin.pid

cd $current_path
