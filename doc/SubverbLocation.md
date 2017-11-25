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
`/usr/lib/foo/subverb/foo-bar.sh`, `/usr/lib/foo/subverb/foo-bar`,
`/usr/lib/foo/subverb/bar.sh` or `/usr/lib/foo/subverb/bar`. 
If multiple of those files exist, the first one found will be
used.

If the file found ends with a .sh-suffix, it will be sourced
instead of executed directly, which gives an performance improvement
and allows an easier handling of (shell-)library functions.

## common library handling ##

Before the subverb is executed, a common library file is sourced
and executedi, if it exists. This can be used to prepare the environment,
test some common conditions (which must met for _all_ subverbs) and
for sourced subverbs provide some common library functions.

Similar, there is a library file, which is called after the
subverb has finished. Be aware, that if the subverb is sourced
and calls `exit()`, this tear-down library will be ignored.

The name of those libraries is computed similar to the subverb
binaries. But instead of looking inside of the `subverb` directory,
a `subverb-pre.sh` or `subverb-pre` resp. a `subverb-post.sh` or
`subverb-post` file is searched. Only the `.sh` variants
are sourced (and provide library functions).

So for a command `foo` by default the file `/usr/lib/foo/subverb-pre`
(with or without a .sh-suffix) will be executed before the subverb.
If the preparation library has a return value indicating a failure
(not zero), the subverb-execution will not take place. This makes
it possible to deny exection, if a major problem occurs.

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

