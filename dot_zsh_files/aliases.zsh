#!/usr/bin/env zsh

# Faster navigation
alias ..='cd ..'
alias ...='cd ../..'

# Git Shortcuts
alias g='git'
alias gpa="GH_FORCE_TTY=100% gh pr list | fzf -m --ansi --preview 'GH_FORCE_TTY=100% gh pr view {1}' --header-lines 4 | awk '{print \$1}' | xargs -n1 gh pr merge -m"

# Neovim Shortcuts
alias v='nvim'

alias cat='bat --paging=never'

alias watch='hwatch '

# Detect which `ls` flavor is in use
if ls --color > /dev/null 2>&1; then # GNU `ls`
	colorflag="--color"
	export LS_COLORS='no=00:fi=00:di=01;31:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'
else # macOS `ls`
	colorflag="-G"
	export LSCOLORS='BxBxhxDxfxhxhxhxhxcxcx'
fi

# List all files colorized in long format
alias l="ls -lF ${colorflag}"

# List all files colorized in long format, excluding . and ..
alias la="ls -lAF ${colorflag}"

# List only directories
alias lsd="ls -lF ${colorflag} | grep --color=never '^d'"

# Always use color output for `ls`
alias ls="command ls ${colorflag}"

# Always enable colored `grep` output
# Note: `GREP_OPTIONS="--color=auto"` is deprecated, hence the alias usage.
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Enable aliases to be sudo’ed
alias sudo='sudo '

# Get week number
alias week='date +%V'

# Get macOS Software Updates, and update installed Ruby gems, Homebrew, npm, and their installed packages
alias update='sudo softwareupdate -i -a; brew update; brew upgrade; brew cleanup; npm install npm -g; npm update -g; sudo gem update --system; sudo gem update; sudo gem cleanup'

# IP addresses
alias pubip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en0"
alias ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"
alias ns="nslookup"

# Docker shortcuts
alias dc="docker compose"
alias dup="docker compose up -d"
alias ddo="docker-compose down"
alias dps="docker ps"
alias dkac="docker kill \$(docker ps -q)"
alias drmc="docker rm \$(docker ps -a -q)"
alias drmi="docker rmi \$(docker images -q -f dangling=true)"
alias td4a="docker run --rm -d -p 5000:5000 --name td4a ghcr.io/tigattack/td4a:2.0.6"

# Terraform shortcuts
alias tf="terraform"
alias tfi="terraform init"
alias tfp="terraform plan"
alias tfa="terraform apply"

# NPM shortcuts
alias npms="npm start"
alias npmr="npm run"
alias npmu="npm update"

# Ansible shortcuts
alias a="ansible -i $HOME/code/iac/ansible/inventory/"
alias ap="ansible-playbook"
alias ainv="ansible-inventory"
alias ac="ansible-console -i $HOME/code/iac/ansible/inventory/"

# Zsh shortcuts
alias zedit="vim ~/.zshrc"
alias zsrc="source ~/.zshrc"

# Pet shortcuts
alias p="pet"
alias pn="pet new"
alias pc="pet configure"
alias pchk="pet search"

# Terraform shortcuts
alias tf="terraform"
alias tfp="terraform plan"
alias tfa="terraform apply"
alias tfau="terraform apply -auto-approve"

# Shell Shortcuts
alias myip="curl http://ipecho.net/plain; echo"
alias stream="viddy "
alias vd1="viddy -n 1 "
alias vd2="viddy -n 2 "

# MacOS Shortcuts
alias d="cd ~/Documents"
alias dl="cd ~/Downloads"
alias dt="cd ~/Desktop"
alias p="cd ~/GitHub"

# macOS has no `md5sum`, so use `md5` as a fallback
command -v md5sum > /dev/null || alias md5sum="md5"

# macOS has no `sha1sum`, so use `shasum` as a fallback
command -v sha1sum > /dev/null || alias sha1sum="shasum"

# Trim new lines and copy to clipboard
alias c="tr -d '\n' | pbcopy"

# Recursively delete `.DS_Store` files
alias cleanup="find . -type f -name '*.DS_Store' -ls -delete"

# Empty the Trash on all mounted volumes and the main HDD.
# Also, clear Apple’s System Logs to improve shell startup speed.
# Finally, clear download history from quarantine. https://mths.be/bum
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl; sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent'"

# Show/hide hidden files in Finder
alias show="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
alias hide="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"

# Hide/show all desktop icons (useful when presenting)
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"

# URL-encode strings
alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1]);"'

# Merge PDF files, preserving hyperlinks
# Usage: `mergepdf input{1,2,3}.pdf`
alias mergepdf='gs -q -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -sOutputFile=_merged.pdf'

# Stuff I will never use but behn has it here and it's funny: http://xkcd.com/530/
alias turnitdown="osascript -e 'set volume output muted true'"
alias turnitup="osascript -e 'set volume output volume 100'"

# Lock the screen (when going AFK)
alias afk="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"

# Reload the shell (i.e. invoke as a login shell)
alias reload="exec ${SHELL} -l"

# Flush DNS
alias flushdns="dscacheutil -flushcache && sudo killall -HUP mDNSResponder"

# Misc
alias bcr='curl -s -X GET -H "Authorization: Bearer $BWS_ACCESS_TOKEN" "http://mgmt-srv-01:5000/reset"'

