# Testing #

Most features are tested using a make-based testing framework.
To add a new test, the following steps should be followed:

* implementing the logic within `t/usr/lib/TESTNAME/subverb/VERB`
* configuration will be searched within `t/etc/TESTNAME`
* Create a test descriptionfile `t/TESTNAME.tmk`

The test will be found and executed automatically during `make check`.
Alternatively it can be executed explicit using `make check-TESTNAME`.

## Test description file ##

The test-description is parsed as a Makefile, so all constructs valid
for GNU make, can be used.

A usual file will look like the following:

	COMMAND=<TESTNAME>
	SUBVERB=<VERB>
	ARGUMENTS=<CMDLINEARGUMENTS>

	define DESCRIPTION
	<short description of what test's testing>
	endef

	define OUTPUT
	<expected STDOUT of the test>
	endef

	include common.mk

The first two lines will define the test-command and command and subverb
to execute. Optionally, commandline-arguments can be given using the
`ARGUMENTS`-Variable.
`DESCRIPTION` and `OUTPUT` should contain text as noted above.
The execution and comparision of the test-result is then done by
`common.mk`.

