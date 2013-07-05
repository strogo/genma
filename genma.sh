# Init all the things!!
if [[ "${GENMA_HOME}" = "" ]]; then
    export GENMA_HOME=$HOME/.genma
fi

if [[ ! -z $(command -v goenv) ]]; then
    if [[ "${GOENV_ROOT}" == "" ]]; then
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
            echo "genma version ${version}"
            echo
            ;;
        *)
            do_func="_genma_do_$1"

            if [[ ! -z $(command -v "${do_func}") ]]; then
                shift 1
                $do_func "$@"
            else
                echo "ERROR: Unknown \`$1' command"
                echo
            fi
            ;;
    esac
}


_genma_help() {
    echo "Go ENvironment MAnager v${version}"
    echo
    echo "Usage: genma <command> [<args>]"
    echo
    echo "Commands:"
    echo "  deactivate              Disable active virtual environment."
    echo "  lsvirtualenv            List available virtual environments."
    echo "  mkvirtualenv <name>     Create and activate new virtual environment."
    echo "  rmvirtualenv <name>     Delete existing virtual environment."
    echo "  workon <name>           Activate or switch to a virtual environment."
    echo
    echo "Options:"
    echo "  -h, --help              Show help and exit."
    echo "  -v, --version           Show version and exit"
    echo
}


_genma_do_workon() {
    # TODO: implement me!
    echo 'WORKON'
}


_genma_do_lsvirtualenv() {
    for x in $GENMA_HOME/*; do
        [[ ! -d ${x} ]] || echo $(basename ${x})
    done
}


_genma_do_deactivate() {
    # TODO: implement me!
    echo 'DEACTIVATE'
}


_genma_do_mkvirtualenv() {
    echo 'MKVIRTUALENV'
}


_genma_do_rmvirtualenv() {
    # TODO: implement me!
    echo "RMVIRTUALENV"
}


_genma_tab_completion() {
    COMPREPLY=()
    local cur prev opts

    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    opts="deactivate lsvirtualenv mkvirtualenv rmvirtualenv workon"

    case "${prev}" in
        workon|rmvirtualenv)
            COMPREPLY=($(compgen -W "$(_genma_do_lsvirtualenv)" -- ${cur}))
            return 0
            ;;
        lsvirtualenv)
            return 0
            ;;
        deactivate|mkvirtualenv)
            return 0
            ;;
    esac

    COMPREPLY=($(compgen -W "${opts}" -- ${cur}))
}


complete -o default -F _genma_tab_completion genma
