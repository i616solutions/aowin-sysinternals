# Installing `%module_name%`


## Get the Package

Download or clone this repository to your local machine.

```powershell
git clone https://github.com/i616solutions/%module_name%
```

## Add the Module to AOWIN

Add the `%module_name%` directory to the `commands` directory in your AOWIN deployment.

You can either copy the directory:

```powershell
Copy-Item -Recurse .\%module_name% <path-to-aowin>\commands\%module_name%
```

Or create a symlink while developing:

```powershell
New-Item -ItemType SymbolicLink `
    -Path <path-to-aowin>\commands\%module_name% `
    -Target .\%module_name%
```

Using a symlink is helpful while building the module because changes in this
repository are available to AOWIN immediately.

## Configure the Module

Configure any module-specific values required by your implementation.

Example placeholders:

```powershell
%module_name%.enabled = true
%module_name%.setting_name = "example-value"
```

Replace these with the real configuration keys for your module.

## Verify the Install

Run a sample command from the module:

```powershell
aowin %module_name% get-date
```

If the command runs and prints the current date, the template module is available
to your AOWIN deployment.


