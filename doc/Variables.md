# configuration by variables #

Great parts of subverb can be configured by setting up environment
variables accordingly. Within the rest of this document `<APP>` will
be used as a placeholder for the uppercase-name of the application,
subverb is used for. `<app>` will reference the application-name itself.
The application will be equal to the name of the binary. Just if the
binary name starts with a number followed by a dot, this characters
will be stripped off. This behaviour can be useful for sorting (or
testing). For example, if the binary is named `01.foobar`, application
will be `foobar`.

## directory/file-lookup ##

### `$<APP>_SYSCONFIG` ###

This variable, if set, will contain the name of the configuration-file,
which is read and should contain system-wide configuration.
If that file isn't present, it will be ignored.

The default is constructed by adding `<app>` to the content of
`$SV_SYSCONFIG`.

### `$<APP>_SHARED_DIR` ###

This variable, if set, will contain the name of the directory, were shared
files of the configuration will be searched in.

The default is constructed by adding `<app>` to the content of
`$SV_SHARED_DIR`.

### `$<APP>_CONFIGNAME` ###

This variable will be used to determine the
[[Configuration|Application-wide configurationfile name]]. The default
is `config`.

### `$<APP>_SUBCMD_DIR` ###

This variable - if set - specifies the directory, where subverb executables
are searched in.

The default is constructed by using the value of `$SV_SUBCMD_DIR` and adding
the `<app>/subverb`.

### `$SV_SYSCONFIG` ###

This variable should contain the directory, where systemwide configuration
files for the applications can be found in. The default is `/etc`.

### `$SV_SHARED_DIR` ###

This file should contain the directory, where application shared files
are stored. The default is `/usr/share`

### `$SV_SUBCMD_DIR` ###

This variable should contain the directory, where application-specific
binary files are stored. The default is `/usr/lib`.

### `$SV_ALLOW_UNSAFE_SUBVERB` ###

If this variable is set to a _positive number_, calling subverbs outside
of the default `$SV_SUBCMD_DIR/subverb`. This can be used for testing,
by specifying a full-path subverb [[SubverbLocation|or via subverb evaluation]].

## commandline options ##

The following options are primaly used for parsing commandline-options
and by the [[LibraryFunctions|function]] `sv_parse_option()`.

### `$SV_OPTION` ###

This is a bash associative array. Each key is string, like given on the
command-line to specify the option (but without the leading '--').
The array-value is the name of the environment-variable, were the
currently set option-value is stored at. If that is prefixed by a
double-colon ':', the option is interpreted as a flag and a '1' is
stored, when this option is given.
The value for non-flag options is specified by the next argument.

commandline options, which aren't specified wont alter the variable.

### `$SV_SHORT_OPTION` ###

Similar to `$SV_OPTION` above, this is an associative array and the
values are interpreted accordingly. The keys are just single characters,
each specifying a short-command (without the leading dash '-').

### `$SV_OPTION_HELP` ###

is an associative array. The key is the variable, specified by
`$SV_OPTION` or `$SV_SHORT_OPTION`. The value is used as a
description, of what the corresponding option will affect.

### `$SV_AUTO_OPTIONS` ###

When these variable is set to '1', commandline options, which are
unknown at the moment of execution of `sv_parse_options()`, those
option names will be transferred to uppercase and the resulting
value is used to store the parameter.

The decision, wether such a function is a flag, is made by the first
character of the next parameter. If that is a dash '-', the current
option is interpreted to be a flag.

### `$SV_UNPARSED` ###

This (indexed) array is set `sv_parse_options()` to store the
remaining (unparsed) parameters.

## help and help generation ##

### `$SV_GROUP` ###

the content of this variable can be used to group commands, for listing the available
commands in help-mode

### `$SV_HELP` ###

this variable should be set as a here-text or within a comment and contain a descriptive
text of the resp. sub-command. Eg.

	# SV_HELP
	# this sub command will do something
	# SV_HELP

Be aware, that this currently is parsed only from sourced (.sh) subverbs.

### `SV_HANDLE_HELP` ###

When this isn't set by a subverb, only the `SV_HELP` tag will be evaluated and
printed during help invocation for a subverb.
For more sophisticated help generation, the following other values could be
assigned:

#### sourced ####

will source the subverb, providing the single argument `_help_source_`. If this is
given, the subverb should return before taken any action apart from providing help
output and defining variables.

#### self ####

In this case, the subverb will be executed with the parameter `help`. In this
case the subverb should handle any help-related output.

### `$<APP>_DESCRIPTION` ###

If this is set (via a wrapper-script or using `subverb-pre.sh`, the corresponding will
be printed as a (short) description, of what the application is used to, when
printing the [[GivingHelp|help-text]].

### `$SVH_LONG` (read-only) ###

This variable is set by `sv_help()`, when a long help description should be generated.
Outside of that call, this variable is undefined.

### `$SVH_FORMAT` (read-only) ###

This variable is set by `sv_help()`, to the name of the current output-format.
The currently known values include:
* plain
* man
Outside of that call, this variable is undefined.

### `$SVH_SEE_ALSO` ###

This variable may contain pointers to furhter documents (or man-pages) which are
related to the current application.
