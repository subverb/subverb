# configuration by variables #

Great parts of subverb can be configured by setting up environment
variables accordingly. Within the rest of this document `<APP>` will
be used as a placeholder for the uppercase-name of the application,
subverb is used for. `<app>` will reference the application-name itself.

## directory/file-lookup ##

### `$<APP>_CONFIG_FILE` ###

This variable, if set, will contain the name of the configuration-file,
which is read and should contain system-wide configuration.
If that file isn't present, it will be ignored.

The default is constructed by adding `<app>` to the content of
`$SV_CONFIG_FILE`.

### `$<APP>_SUBCMD_DIR` ###

This variable - if set - specifies the directory, where subverb executables
are searched in.

The default is constructed by using the value of `$SV_SUBCMD_DIR` and adding
the `<app>/subverb`.

### `$SV_CONFIG_FILE` ###

This variable should contain the directory, where systemwide configuration
files for the applications can be found in. The default is `/etc`.

### `$SV_SUBCMD_DIR` ###

This variable should contain the directory, where application-specific
binary files are stored. The default is `/usr/lib`.
