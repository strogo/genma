# Init all the things!!
if [[ "${GENMA_HOME}" = "" ]]; then
    export GENMA_HOME=$HOME/.genma
fi

if [[ ! -z $(command -v goenv) ]]; then
    if [[ "${GOENV_ROOT}" = "" ]]; then
        export GOENV_ROOT=$(dirname $(command -v goenv) | xargs dirname)
    fi
    export GOROOT=$GOENV_ROOT/versions/$(goenv version)
fi


genma() {
    local do_func version
    version="0.1.0"

    case "$1" in
        ""|"-h"|"--help")
            _genma_help
            ;;
        "-v"|"--version")
            echo "genma v${version}"
            echo
            ;;
        *)
            do_func="_genma_do_$1"

            if [[ ! -z $(command -v "${do_func}") ]]; then
                shift 1
                $do_func "$@"
            else
                echo "ERROR: Unknown '$1' command"
                echo
            fi
            ;;
    esac
}


_genma_help() {
    echo "Go (virtual) ENvironment MAnager v${version}"
    echo
    echo "Usage: genma <command> [<args>]"
    echo
    echo "Commands:"
    echo "  deactivate              Disable active virtualenv."
    echo "  lsvirtualenv            List available virtualenv."
    echo "  mkvirtualenv <name>     Create and activate new virtualenv."
    echo "  rmvirtualenv <name>     Delete existing virtualenv."
    echo "  workon <name>           Activate or switch to a virtual environment."
    echo
    echo "Options:"
    echo "  -h, --help              Show help and exit."
    echo "  -v, --version           Show version and exit"
    echo
}


_genma_do_workon() {
    if [[ -z $1 ]]; then
        echo "ERROR: Requires virtualenv"
        echo
    else
        local virtualenv="${GENMA_HOME}/$1"

        if [[ -d "${virtualenv}" ]]; then
            _genma_do_deactivate

            export GOPATH=$virtualenv

            # add marker into shell prompt so we'll
            # know we are in virtual environment
            export PS1="(g:$1)$PS1"
        else
            echo "ERROR: Unable to find '$1' virtualenv"
            echo
        fi
    fi
}


_genma_do_lsvirtualenv() {
    for x in $GENMA_HOME/*; do
        [[ ! -d ${x} ]] || echo $(basename ${x})
    done
}


_genma_do_deactivate() {
    if [[ ! -z "$GOPATH" ]]; then
        local marker="(g:$(basename $GOPATH))"

        # remove genma's marker in shell prompt, if any
        export PS1=${PS1//$marker/}

        unset GOPATH
    fi
}


_genma_do_mkvirtualenv() {
    if [[ -z $1 ]]; then
        echo "ERROR: Requires virtualenv name"
        echo
    else
        _genma_do_deactivate

        local virtualenv=$GENMA_HOME/$1
        mkdir -p $virtualenv
        export GOPATH=$virtualenv

        # add marker into shell prompt so we'll
        # know we are in virtual environment
        export PS1="(g:$1)$PS1"
    fi
}


_genma_do_rmvirtualenv() {
    if [[ -z $1 ]]; then
        echo "ERROR: Requires virtualenv name"
        echo
    else
        local virtualenv=$GENMA_HOME/$1

        if [[ ! -z $GOPATH && $GOPATH == $virtualenv ]]; then
            echo "ERROR: Cannot remove active virtualenv"
            echo
        else
            if [[ -d $virtualenv ]]; then
                rm -rf $virtualenv
            else
                echo "ERROR: Unable to find '$1' virtualenv"
            fi
        fi
    fi
}


_genma_tab_completion() {
    COMPREPLY=()
    local cur prev opts

    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    opts="deactivate lsvirtualenv mkvirtualenv rmvirtualenv workon"

    if [[ "$COMP_CWORD" -eq 1 ]]; then
        COMPREPLY=($(compgen -W "${opts}" -- ${cur}))
    else
        case "${prev}" in
            workon|rmvirtualenv)
                COMPREPLY=($(compgen -W "$(_genma_do_lsvirtualenv)" -- ${cur}))
                return 0
                ;;
            deactivate|mkvirtualenv|lsvirtualenv)
                return 0
                ;;
        esac
    fi
}


complete -o default -F _genma_tab_completion genma
