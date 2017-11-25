# Locating subverbs and executing code #

AS a framework fur command-execution there are multiple places, wherer
custom code can be injected. More information about variables noted here,
can be looked up in [[Variables]].

## Configuration file ##

Each application can have a system-wide configuration file. This will
be searched in the `$SV_CONFIG_DIR` (usually /etc) under the name of the
command.

This file is expected to be a shell-fragment - which is used to set
environment variables.

## subverb binary ##

The command to execute will be searched within `$SV_SUBCMD_DIR` (usually
/usr/lib). There a directory named like the command and a subdirectory
named subverb should exist. Within this directory a file named
`COMMAND-SUBVERB` is searched, if this isn't found `SUBVERB` will
be used instead.

So for a command `foo` the subverb `bar` should be accessable within
`/usr/lib/foo/subverb/foo-bar` or `/usr/lib/foo/subverb/bar`.

## wrapper binary ##

to modify further aspects of the system, it is also possible
to generate a wrapper-application (or shellscript), which
sets up the environment [[Variables]] and executes (or sources)
the subverb binary itself. See [[Deployment]] for more information
on this mechanism.

As subverb uses some bash-features, it reexecutes the
current binary under bash, if it was started using another shell.
This occurs only, if a wrapper binary is used or a shell is used explicitly
to start and has two side-effects:
* a perfomrance penalty
* code in the wrapper binary (before sourcing subverb) is executed twice

