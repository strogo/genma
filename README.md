genma
=====

`genma` is **G**o (virtual) **EN**vironment **MA**nager,
inspired by Python [virtualenvwrapper][].

[virtualenvwrapper]: https://bitbucket.org/dhellmann/virtualenvwrapper

As [Go][] doesn't have [virtualenv][] like Python does,
managing Go workspaces manually is quite tedious.
`genma` is aimed to automate this process.

[virtualenv]: http://www.virtualenv.org/
[Go]: http://golang.org/

Install
-------

Preferred setup (using stable version):

    $ git clone git://github.com/iromli/genma.git ~/.genma
    $ git tag -l | tail -1 | xargs git checkout
    $ source ~/.genma/genma.sh

Usage
-----

See available commands and options:

    $ genma -h

Some useful `genma` subcommands are:

*   `mkvirtualenv <name>`

    Create and activate new virtualenv.

        $ genma mkvirtualenv env
        (g:env)$

    If you notice, your shell prompt is prefixed with `(g:env)`.
    It tells you're in a genma virtualenv.

    Each virtualenv is placed under `$GENMA_HOME`
    (default to `~/.genma/virtualenv`).
    Hence if you want a custom path, simply set `$GENMA_HOME` pointed
    to somewhere else before `genma.sh` is loaded.

*   `deactivate`

    Disable active virtualenv.

        (g:env)$ genma deactivate

*   `lsvirtualenv`

    List available virtualenv.

        $ genma lsvirtualenv

*   `rmvirtualenv <name>`

    Delete existing virtualenv.

        $ genma rmvirtualenv env

    However you can't remove a currently-used virtualenv.

*   `workon <name>`

    Activate or switch to a virtualenv.

        $ genma workon new-env

Copyright
---------

`genma` is offered under MIT license. See `LICENSE.txt` for details.
