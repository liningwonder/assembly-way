package com.datafusion.maven.assembly;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.slf4j.MDC;

import java.util.UUID;

public class Main {

    private static final Logger LOG = LoggerFactory.getLogger(Main.class);

    public static void main(String[] args) throws Exception {

        MDC.put("REQUEST_ID", UUID.randomUUID().toString());
        EchoServer.main(args);
    }

}
