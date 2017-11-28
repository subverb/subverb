# Configuration files and options #

Most applications need configuration. For multiverb-applications, these
usually share a common configuration file.
As each subverb application might be a seperate application, the easiest
way to share the configuration tokens is via environment variables.
To provide a most flexble environment, `subverb` will interprete
configuration files as shell fragments.

The configuration scheme is based on multiple instances, an
application-configuration, a system-configuration and a user-configuraion.
Those will be read in that order, each overwriting previous ones.

Additionally commandline-parameters can be used to modify thos parameters
for a single run.

## application configuration ##

The application-wide configuration should be used, to provide reasonable
defaults for the configuration. According to [[Variables]], the configuration
base will constructed from `$SV_SHARED_DIR` (usually resulting in
`/usr/share/<app>`) or `$<APP>_SHARED_DIR`. To that path, the content
of `$<APP>_CONFIGNAME` is added (optionally suffixed by a `.d`).

The resulting file (or every file with the `.conf`-suffix in that directory)
will be read.

## system configuration ##

Each application can have a system-wide configuration file and/or a
directory of configuration files. According to [[Variables]], 
`$SV_SYSCONFIG` (usually resulting in `/etc/<app>`) or `$<APP>_SYSCONFIG`
will be used to locate these. If this is a plain file, it is read directly,
if it is a directory itself, or if there is a directory named like `<app>.d`,
every file suffixed by `.conf` in there will be sourced by subverb.

## user-specific configuration ##

User-specific configuration-files will be searched within the users
`$HOME`-directory, checking for `.<app>`. `.<app>.d`, `.config/<app>`
or `.config/<app>.d`.

## commandline-parameters ##

When a [[SubverbLocation|preparation library]] sets up the [[Variables]]
`$SV_OPTION`, `$SV_SHORT_OPTION` or `$SV_AUTO_OPTIONS` correctly,
global commandline options (which are specified before the concrete
subverb) are parsed automatically _after_ all configuration-files
are read. Options given after the verb will be passed to the
subverb, directly. These can be processed correspondingly using
the [[LibraryFunctions|function]] `$sv_parse_option`.
