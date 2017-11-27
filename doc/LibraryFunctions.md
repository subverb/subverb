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

