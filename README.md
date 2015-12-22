# Watcher

A simple tool that watches on inofity events and runs a shell command if a file
was modified.

`NOTE`: For now this uses the hinotify package which will on work on Linux machines.
There are currently no plans for supporting Mac OSX or BSD.

## Installation

Please see [Releases page](https://github.com/denibertovic/watcher/releases).

## USAGE

    watcher --help
    watcher - File INotify wathcer

    Usage: watcher-exe --file PATH --command COMMAND
      Watches files for changes and executes a command on change

    Available options:
      -h,--help                Show this help text
      --file PATH              Absolute path to file to watch for changes
      --command COMMAND        Command to run when file changes


## Example use-case

To listen on source code changes and reload a dev web server. (If the
dev server doesn't support this already).

Production environment use-case where it can listen on
config file changes and reload a process so it gets the new changes.

`NOTE`: If deployed to any kind of production setting it should be spawned with
some kind of supervisor (for example: upstart, systemd, supervisord) so it can respawn
the process if it crashed.

## How to contribute

Report issues on the Issue tracker: https://github.com/denibertovic/watcher/issues

1. Clone the repo: git clone git@github.com:denibertovic/watcher.git  (or fork it first and then clone)
2. cd watcher && stack build

