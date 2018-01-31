# Set Terminal window title bar

# macOS terminals
printf '\e]0;\a'
printf '\e]7;\a'
precmd () {
	print -Pn "\e]2;%n@%m:%~\a"
}
