# Set various things to colorize things in the terminal

#
# GNU ls colors
#
DIRCOLORS_CMD="$(whence gdircolors 2>/dev/null || whence dircolors 2>/dev/null)"
if [ -n "${DIRCOLORS_CMD}" ]; then
	eval $("${DIRCOLORS_CMD}" ~/.dircolors)
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
GLS="$(whence gls 2>/dev/null)"
if [ -z "${GLS}" ]; then
	if [[ "$(uname -s)" == "Linux" ]]; then
		alias ls='ls --color=auto'
	fi
else
    alias ls='gls --color=auto'
fi
