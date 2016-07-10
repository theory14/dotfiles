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

	# Get vim directory
	if [ -d "${HOME}/.vim" ]; then
		cp common/vim/* "${HOME}/.vim/"
	fi
}

case "$METHOD" in
    bash)
        install_bash
        ;;
    zsh)
        install_zsh
        ;;
    common)
        install_common
        ;;
    all)
        install_bash
        install_zsh
        install_common
        ;;
    *)
        echo "Usage: $0 {bash|zsh|all}"
        exit 1
esac

exit 0

