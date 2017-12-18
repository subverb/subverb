# subverb as library - supported functions #

As part of its own operation, subverb already implements
a couple of shell-functions, which can be re-used by applications.
The functions documented here, are expected to work between
different versions (unless noted). Other functions, which might
be found available, might change without notice.

## `sv_parse_options $@` - parse a list of options ##

The argument given to this function will be parsed for (known)
cmdline-options, until an unknown option or non-option argument
is been found. (In the global context of subverb this mostly
indicates the actual verb).

As noted at the corresponding [[Variables#commandline options|Variables-section]],
the values of `$SV_OPTION`, `$SV_SHORT_OPTION` and `$SV_AUTO_OPTIONS`
is taken into account. These should be set up before calling
the function. Unparsed options will be passed back via `$SV_UNPARSED`.

## `sv_evaldir $NAME $DEFAULT $SUFFIX` - try to evaluate a path from config ##

A quite common task is to check for some configuration file or directory
by checking the following terms and stop after the first match:

1) is there a `$<APP>_<NAME>` defined? Then use that value
2) is there a `$SV_<NAME>` defined? Then append `/$SUFFIX` and use that
3) otherwise use `$DEFAULT/$SUFFIX`

That is exaclty, what this function does.

## `sv_call ${LIST_OF_NAMES[@]}` - call an application ##

This function will go through the list of its arguments and for each
elemet `<ele>` tries to find:

1) a file with name `<ele>.sh` and source it
2) an executable `<ele>` and execute it

The first file found, will break the execution.
The command-line arguments passed to the execution
are read from `${EXARGV[@]}`. The return-value of the executed
command can be checked afterwards via `$RVAL`.
The function will return true, if it has executed something.

## `sv_call_subverb $VERB $@` - call another subverb ##

This function will call the given verb and return afterwards.
If the verb doesn't exists, the application will be exited.

## `sv_help` - print usage ##

calling this function, without parameter will list all available
subverbs, grouped by their resp. [[Variables|$SV_GROUP]]. This can
also be specified within a comment, so

	SV_GROUP=foo
and
	# SV_GROUP: foo
are equivalent

