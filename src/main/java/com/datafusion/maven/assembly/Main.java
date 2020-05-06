package com.datafusion.maven.assembly;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.slf4j.MDC;

import java.util.UUID;

public class Main {

    private static final Logger LOG = LoggerFactory.getLogger(Main.class);

    public static void main(String[] args) throws Exception {
        //配置JVM参数 -Dlog4j.configurationFile=D:\\assembly-tar\\conf\\log4j2.xml
        String path = System.getProperty("log4j.configurationFile", " ");
        MDC.put("REQUEST_ID", UUID.randomUUID().toString());
        LOG.warn("the default log4j2 configuration file is " + path);
        EchoServer.main(args);
    }

}
