#!/usr/bin/env fish

# Conditional abbreviations
for cmd in bat chezmoi kubectl nvim hwatch hx
    if type -q $cmd
        switch $cmd
            case bat
                abbr cat bat
            case chezmoi
                abbr cm chezmoi
            case kubectl
                abbr k kubectl
            case hwatch
                abbr watch hwatch
            case hx
                abbr h hx
        end
    end
end

# Git
abbr gpa 'GH_FORCE_TTY=100% gh pr list | fzf -m --ansi --preview "GH_FORCE_TTY=100% gh pr view {1}" --header-lines 4 | awk "{print \$1}" | xargs -n1 gh pr merge -m'

# IP utilities
abbr pubip 'dig +short myip.opendns.com @resolver1.opendns.com'
abbr localip 'ipconfig getifaddr en0'
abbr ips 'ifconfig -a | grep -o "inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)" | awk "{ sub(/inet6? (addr:)? ?/, \"\"); print }"'

# Maintenance
abbr cleanup 'find . -type f -name "*.DS_Store" -ls -delete'
abbr emptytrash 'sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl; sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* "delete from LSQuarantineEvent"'
abbr flushdns 'dscacheutil -flushcache && sudo killall -HUP mDNSResponder'
