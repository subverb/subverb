## providing help for an application ##

Every application should be able to provide some assisting
information, what it is good for and how it is called.
For applications providing sub-commands this is true even
more. Because of that, a couple of mechanisms have been included
to subverb to integrate those information.

### application-wide messages ###

If no explicit subverb named help is implemented,
the default will call [[LibraryFunctions.md|sv_help()]].
The following lines will describe that function's behaviour.
Any implementation of a subverb called `help` will overwrite
these.

#### Calling help ####

When the `help` subverb (or more exaclty `sv_help()` is called,
the following options are supported:

* `--long` will set [[Variables|$SVH_LONG]] to enable long help-texts.
* `--man` can be used to create man-pages. This will set `$SVH_LONG`
and `$SVH_FORMAT` accordingly.

#### Creating help-texts ####

A short description, of what the application is meant to be for
can be given by declaring [[Variables|$<SV>_DESCRIPTION]], for
example within a wrapper or via the applications `subverb-pre.sh`
extensions. If this is present, it will be presented to the user
as a major part of the description.

If a multiline description is wanted, the variable should be declared
via an here-document.

After that main description, a list of known subverbs is generated
and printed grouped by their `$SV_GROUP` specifications.
This list will be followed by the supported global commandline options.

Finally, when `$SVH_LONG` is set, an extensive application description, 
can be displayed from `doc/<application>/HELP.md` - 
if that file isn't found, `doc/<application>/README.md` is used
instead. This should include more detailed information for the user.

### Subverb-specific messages ###

When the default subverb `help` is called with an parameter, the subverb`s 
help wiil be displayed instead.

If the subverb provides any help-related tasks, it should contain
a definition of `SV_HANDLE_HELP`. This can either be a parameter
definition or a comment. For compiled subverbs, even mentioning
this within the text section (by defining a appropriate string)
should be ok.

This might be one of the following:

	SV_HANDLE_HELP=sourced
	SV_HANDLE_HELP : self
	# just for subverb: SV_HANDLE_HELP = self

The currently handled values are `self` and `sourced` (and the empty
string, which is used, when no definition has been made).

Subverbs using the definition `self` will be called with the parameter
`help` and should handle any help-output by themselve.

For all other defintions, the value of `SV_HELP` declared within the subverb
is used.
This can be done either by declaring that variable as an here-text or by
declaring a comment containing the string `SV_HELP`, providing the help
string on the following lines and closing with another `SV_HELP`-line.
The lines between will get one leading hashmark '#' stripped and the
result is printed to the user.
`sourced` subverbs can use other computations to define the variable, as
well. In that case comment would be ignored.

For `sourced` subverbs afterwards, the supported commandline-options will be printed.

In any case, a help-file in the doc-folder can be generated. This must be
named like the `<subverb>.md` (optionally `<app>-<subverb>.md`), which will be displayed
after the aforementioned text has been generated.

### commandline options ###

Commandline options can be specified by [[Variables|$SV_OPTION and $SV_SHORT_OPTION]].
To provide a description of those options, a corresponding `$SV_OPTION_HELP`
should be defined, giving a description, of what this option does.

`sv_option_help()` will use this information to create corresponding
help-texts.

	SV_OPTION[foo]=VAR_FOO
	SV_SHORT_OPTION[f]=VAR_FOO
	SV_OPTION_HELP[VAR_FOO]="will frobnicate the output"

will generate a helpline like:

	--foo, -f=<param>	will frobnicate the output

