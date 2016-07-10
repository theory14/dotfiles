# Set various things to colorize things in the terminal

#
# GNU ls colors
#
DIRCOLORS_CMD=$(which gdircolors 2>/dev/null || which dircolors 2>/dev/null)
if [ -n "${DIRCOLORS_CMD}" ]; then
    eval `${DIRCOLORS_CMD} ~/.dircolors`
fi

#
# BSD ls colors
#
LSCOLORS=exGxFxDxCxDxDxhbadacex
CLICOLOR=1
export LSCOLORS CLICOLOR

#
# grep colors
#
export GREP_COLOR="35"
export GREP_OPTIONS="--color=auto"

#
#  ls output in color
#
GLS=$(which gls 2>/dev/null)
if [ -z "${GLS}" ]; then
    # if there is no $GLS, see if we are linux since we know that should
    # have GNU Coreutils' ls
    if [ `uname -s` == "Linux" ]; then
        alias ls='ls --color=auto'
    fi
else
    # $GLS exists, so use it
    alias ls='gls --color=auto'
fi
# if no $GLS and not linux, then we don't mess with ls
