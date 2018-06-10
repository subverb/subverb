# Deployment of a subverb application #

If subverb itself is installed, the easiest way to create a seperate
application is to provide a symlink of using the applications name.

	ln -s /usr/bin/subverb /usr/bin/myapplication

The supported subverbs should then be placed, according to
[[Variables]] and/or [[SubverbLocation]]. Usually as seperate
binaries within `/usr/lib/myapplication/subverb`.

If things get more complicated, or a specific variables-setup is needed,
another way is to create a wrapper shellscript, like the following:

	MYAPPLICATION_SUBCMD_DIR=/usr/share/myapp

	. /usr/bin/subverb

This will change the path, where subverbs are looked for permanently
for that single application.
Care has to be taken, not to alter the name, the application is called
as, as this is the source for looking up different pathes and files.

## listing installed subverbs ##

To list all subverbs, the current application can utilize, the builtin
subverb `list` can be used.
