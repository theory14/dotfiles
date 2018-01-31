#!/bin/sh

METHOD=$1

install_bash() {
	mkdir -p "${HOME}/.bash" 2>/dev/null
	cp bash/* "${HOME}/.bash/"
	ln -f "${HOME}/.bash/_bashrc" "${HOME}/.bashrc"
	ln -f "${HOME}/.bash/_bash_profile" "${HOME}/.bash_profile"
}

install_zsh() {
	mkdir -p "${HOME}/.zsh" 2>/dev/null
	cp zsh/* "${HOME}/.zsh/"
	ln -f "${HOME}/.zsh/_zshrc" "${HOME}/.zshrc"
}

install_common() {

    # Get dofiles
	for FILENAME in common/_*
	do
		NEWNAME=$(basename "${FILENAME}" | tr _ .)
		cp "${FILENAME}" "${HOME}/${NEWNAME}"
	done

}

install_vim() {

	cp vim/_vimrc "${HOME}/.vimrc"

	# Get vim directory
	if [ -d "${HOME}/.vim" ]; then
		cp -r vim/* "${HOME}/.vim/"
	fi

}

install_fvwm() {
	if [ -d "${HOME}/.fvwm" ]; then
		cp -r fvwm/* "${HOME}/.fvwm/"
	fi
}


case "$METHOD" in
    fvwm)
        install_fvwm
        ;;
    vim)
        install_vim
        ;;
    zsh)
        install_zsh
        ;;
    common)
        install_common
        ;;
    all)
        install_vim
		install_fvwm
        install_zsh
        install_common
        ;;
    *)
        echo "Usage: $0 {all|zsh|common|fvwm|vim}"
        exit 1
esac

exit 0

