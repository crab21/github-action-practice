#compdef mycommand

_mycommand() {
    local -a commands
    commands=(
        'start:Start the service'
        'stop:Stop the service'
        'restart:Restart the service'
    )

    _describe 'command' commands
}

compdef _mycommand mycommand
