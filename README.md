# avdmanager_skin-Repair

Repair the AVD's `config.ini` file to get the correct skin parameters, after the creation using the `avdmanager`.

## Background

If the `avdmanager` is used to create an AVD with the `-d` or `--device` option, it fails to set the correct skin parameters within the `config.ini` file. This results in a misconfigured resolution when starting the AVD with the `emulator` command.


