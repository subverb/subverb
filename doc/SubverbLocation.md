# Locating subverbs and executing code #

AS a framework fur command-execution there are multiple places, wherer
custom code can be injected. More information about variables noted here,
can be looked up in [[Variables]].

## Configuration file ##

Configuration files are expected to be shell-fragments - used to set
environment variables. But they can be used for other purposes as well.
See [[Configuration]] for more inforamtion.

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

## shebang evaluation ##

When the subverb implementing file provides a shebang, which references
the main command, this will be interpreted, as if the subverb
was called from the main-command. So if the file
`/usr/lib/foo/subverb/bar.sh` starts with the line

	#!/usr/bin/foo

The following invocations will have the same result

	$ foo bar
	$ /usr/lib/foo/subverb/bar.sh

Subverbs which aren't sourced (where the file has the `.sh`-extension),
have to provide an extended header giving the interpreter for the subverb
itself, like

	#!/usr/bin/foo
	# SV_SHEBANG: /bin/sh

Otherwise a loop-hole on calling the main application will occur. The
`SV_SHEBANG` must be located in the second line. For sourced subverb,
this will be simply ignored.

For compiled subverbs (executables without a shebang), the decision, wether
to call the main application, must be done within the application.

## common library handling ##

Before the subverb is executed, a common library file (`-pre`) is sourced
and executed, if it exists. This can be used to prepare the environment,
test some common conditions (which must met for _all_ subverbs) and
for sourced subverbs provide some common library functions.

Another library file (`-configured`) is exectuded, after all
configuration files have been read.

Similar, there is a library file (`-post`), which is called after the
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

