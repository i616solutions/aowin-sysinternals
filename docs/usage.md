# Using `%module_name%`

This document shows the basic command pattern for this template module.
Update the examples as you add real commands.

## Command Format

AOWIN commands use the module name followed by the command name:

```powershell
aowin %module_name% <command-name>
```

## Example Command

The template includes a simple `get-date.ps1` command.

```powershell
aowin %module_name% get-date
```

This should print the current date and time.

## Adding Commands

Add new PowerShell scripts to the `%module_name%` directory.

For example:

```text
%module_name%/
  get-date.ps1
  example-command.ps1
```

Then call the command through AOWIN:

```powershell
aowin %module_name% example-command
```
