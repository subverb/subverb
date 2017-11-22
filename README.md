# simple subverb execution wrapper #

Many commands need support for different subcommands, which can be seen as
different programs run a in a shared environment. For those programs,
`subverb` can be used to provide a suitable environment.

## Installation ##

The main component of `subverb` is the binary of the same name. This should
be placed at a well-known place on your system, eg. `/usr/bin/`.

## Usage ##

To use a certain suite to use `subverb`, let's name it `EXAMPLE`, here, 
it just has to be assured, that `subverb` is called by that name.
If evrything is at the place exptected, the command

	ln -s subverb EXAMPLE

should  be enough.

Now the configuration-file will be searched at `/etc/EXAMPLE`, 
the different sub-commands should reside within `/usr/lib/EXAMPLE/subverb`

## License ##

`subverb` is licensed under the terms of GPLv3
