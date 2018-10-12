# JRuby::Startup

This is a collection of utilities to help improve the startup time of
JRuby-based applications.

## Installation

`gem install jruby-startup`

## Usage

The utilities provided by this gem are described below.

### generate-appcds

The `generate-appcds` command is used to generate an AppCDS, or
"Application-specific Class Data Store" archive on OpenJDK 11 or
higher. This archive pre-processes the classes in JRuby to eliminate
some overhead at startup.

By using this utility and setting some environment variables, many
JRuby commands can be sped up a fair amount.

Running `generate-appcds` alone will generate the AppCDS archive based
on a command line of `-e 1` as passed to JRuby. You can provide a
different command line, in quotes, to the `generate-appcds` command.

```
$ generate-appcds
*** Outputting list of classes at /Users/headius/projects/jruby/lib/jruby.list
...
```

When the command has completed, you will see some environment variables
to set that will enable the use of the AppCDS archive.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jruby/jruby-startup.
