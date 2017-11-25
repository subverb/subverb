# Configuration files #

Most applications need configuration. For multiverb-applications, these
usually share a common configuration file.
As each subverb application might be a seperate application, the easiest
way to share the configuration tokens is via environment variables.
To provide a most flexble environment, `subverb` will interprete
configuration files as shell fragments.

Each application can have a system-wide configuration file and/or a
directory of configuration files. According to [[Variables]], 
`$SV_SYSCONFIG` (usually resulting in `/etc/<app>`) or `$<APP>_SYSCONFIG`
will be used to locate these. If this is a plain file, it is read directly,
if it is a directory itself, or if there is a directory named like `<app>.d`,
every file suffixed by `.conf` in there will be sourced by subverb.

