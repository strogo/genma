genma
=====

genma is **G**o (virtual) **EN**vironment **MA**nager,
inspired by Python [virtualenvwrapper][].

[virtualenvwrapper]: https://bitbucket.org/dhellmann/virtualenvwrapper

How To
------

*   Install:

        $ git clone git://github.com/iromli/genma.git /path/to/genma
        $ source /path/to/genma/genma.sh

*   Usage:

        $ genma -h

    You should see this:

        Go (virtual) ENvironment MAnager v0.1.0

        Usage: genma <command> [<args>]

        Commands:
          deactivate              Disable active virtual environment.
          lsvirtualenv            List available virtual environments.
          mkvirtualenv <name>     Create and activate new virtual environment.
          rmvirtualenv <name>     Delete existing virtual environment.
          workon <name>           Activate or switch to a virtual environment.

        Options:
          -h, --help              Show help and exit.
          -v, --version           Show version and exit
