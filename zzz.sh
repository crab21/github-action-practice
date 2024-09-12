# Filename: mycommand_completion.sh

# Define the completion function for Bash
_mycommand_completion_bash() {
    local cur prev
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"

    local subcommands="start stop status"
    local start_options="--force --verbose"
    local stop_options="--timeout --force"
    local status_options="--details --brief"

    if [[ ${COMP_CWORD} -eq 1 ]]; then
        COMPREPLY=( $(compgen -W "${subcommands}" -- ${cur}) )
    elif [[ ${COMP_WORDS[1]} == "start" ]]; then
        COMPREPLY=( $(compgen -W "${start_options}" -- ${cur}) )
    elif [[ ${COMP_WORDS[1]} == "stop" ]]; then
        COMPREPLY=( $(compgen -W "${stop_options}" -- ${cur}) )
    elif [[ ${COMP_WORDS[1]} == "status" ]]; then
        COMPREPLY=( $(compgen -W "${status_options}" -- ${cur}) )
    fi
}

# Define the completion function for Zsh
_mycommand_completion_zsh() {
    local -a subcommands
    local -a start_options
    local -a stop_options
    local -a status_options

    subcommands=(
        'start:Start the service'
        'stop:Stop the service'
        'status:Show status'
    )

    start_options=(
        '--force:Force start'
        '--verbose:Verbose output'
    )

    stop_options=(
        '--timeout:Set timeout'
        '--force:Force stop'
    )

    status_options=(
        '--details:Show detailed status'
        '--brief:Show brief status'
    )

    _arguments \
        '1:subcommand:_values "subcommands" $subcommands' \
        '*::options:_values "${words[1]}" $([ "$words[1]" = "start" ] && echo "$start_options" || ([ "$words[1]" = "stop" ] && echo "$stop_options") || ([ "$words[1]" = "status" ] && echo "$status_options"))'
}

# Detect the shell and set up the appropriate completion function
if [ -n "$BASH_VERSION" ]; then
    # Bash
    complete -F _mycommand_completion_bash mycommand
elif [ -n "$ZSH_VERSION" ]; then
    # Zsh
    echo "zsh......."
    compdef _mycommand_completion_zsh mycommand
fi