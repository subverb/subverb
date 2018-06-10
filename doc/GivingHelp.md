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

A short description, of what the application is meant to be for
can be given by declaring [[Variables|$<SV>_DESCRIPTION]], for
example within a wrapper or via the applications `subverb-pre.sh`
extensions. If this is present, it will be presented to the user
as a major part of the description.

If a multiline description is wanted, the variable should be declared
via an here-document.

After that main description, a list of known subverbs is generated
and printed grouped by their `$SV_GROUP` specifications.

### Subverb-specific messages ###

When the default subverb `help` is called with an parameter, the subverb`s 
help wiil be displayed instead.

This is done by printing the `SV_HELP` declared within that subverb.
This can be done either by declaring that variable as an here-text or by
declaring a comment containing the string `SV_HELP`, providing the help
string on the following lines and closing with another `SV_HELP`-line.
The lines between will get one leading hashmark '#' stripped and the
result is printed to the user.

