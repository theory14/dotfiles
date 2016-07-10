# Set Terminal window title bar

# macOS terminals
if [ "${TERM_PROGRAM}" = "Apple_Terminal" ]; then
	printf '\e]0;\a'
	printf '\e]7;\a'
	precmd () {
		print -Pn "\e]2;%~\a"
	}

else
	# non-Mac terminal
	printf "\033]0;%s@%s:%s\033\\" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/~}"
fi

