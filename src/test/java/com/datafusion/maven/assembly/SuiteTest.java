package com.datafusion.maven.assembly;

import com.datafusion.maven.testcase.CalculatorTestCase;
import org.junit.runner.RunWith;
import org.junit.runners.Suite;

@RunWith(Suite.class)
@Suite.SuiteClasses({CalculatorTestCase.class})
public class SuiteTest {
}
