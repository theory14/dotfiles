#
# common aliases
#

# homebrew update
#alias brewup='brew update && brew upgrade && brew cleanup'
alias brewup='brew update && brew cask update && brew upgrade --all && brew cleanup && brew cask cleanup'

# FreeBSD pkg update
alias packup='pkg update && pkg upgrade && pkg clean'

# Update python packages with pip
alias pipup='pip install --upgrade pip setuptools && pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U'
