genma
=====

`genma` is **G**o (virtual) **EN**vironment **MA**nager,
inspired by Python [virtualenvwrapper][].

[virtualenvwrapper]: https://bitbucket.org/dhellmann/virtualenvwrapper

Why
---

As [Go][] doesn't have [virtualenv][] like Python does,
managing Go workspaces manually is quite tedious.
`genma` aims to automate this process.

[virtualenv]: www.virtualenv.org
[Go]: http://golang.org/

How
---

*   Install:

        $ git clone git://github.com/iromli/genma.git /path/to/genma
        $ source /path/to/genma/genma.sh

*   Usage:

        $ genma -h

    You should see this:

        Go (virtual) ENvironment MAnager v0.1.0

        Usage: genma <command> [<args>]

        Commands:
          deactivate              Disable active virtualenv.
          lsvirtualenv            List available virtualenv.
          mkvirtualenv <name>     Create and activate new virtualenv.
          rmvirtualenv <name>     Delete existing virtualenv.
          workon <name>           Activate or switch to a virtualenv.

        Options:
          -h, --help              Show help and exit.
          -v, --version           Show version and exit

Copyright
---------

`genma` is offered under MIT license. See `LICENSE.txt` for details.
