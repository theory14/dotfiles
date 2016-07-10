# Set bash prompt up
#

# source color definitions
source "${HOME}/.bash/color_def.sh"

# Show Git branch/tag, or name-rev if on detached head
parse_git_branch() {
    (git symbolic-ref -q HEAD || git name-rev --name-only --no-undefined --always HEAD) 2> /dev/null
    #(git name-rev --name-only --no-undefined --always HEAD) 2> /dev/null
}

GIT_PROMPT_AHEAD="\[$CYAN\]+NUM"
GIT_PROMPT_BEHIND="\[$CYAN\]-NUM"
GIT_PROMPT_MERGING="\[$CYAN\]⚡︎"

# determine commits ahead/behind from upstream
parse_git_commit_status() {
    # num commits ahead
    local NUM_AHEAD="$(git log --oneline @{u}.. 2> /dev/null | wc -l | tr -d ' ')"
    if [ "$NUM_AHEAD" -gt 0 ]; then
        echo "$GIT_COUNT${GIT_PROMPT_AHEAD//NUM/$NUM_AHEAD} "
    fi
    # num commits behind
    local NUM_BEHIND="$(git log --oneline ..@{u} 2> /dev/null | wc -l | tr -d ' ')"
    if [ "$NUM_BEHIND" -gt 0 ]; then
        echo "$GIT_COUNT${GIT_PROMPT_BEHIND//NUM/$NUM_BEHIND} "
    fi
}

git_merge_status() {
    # merging
    local GIT_DIR="$(git rev-parse --git-dir 2> /dev/null)"
    if [ -n "${GIT_DIR}" ] && test -r "${GIT_DIR}/MERGE_HEAD"; then
        echo "$GIT_PROMPT_MERGING "
    fi
}

# Show different symbols as appropriate for various Git repository states
git_state_color() {

    #  default to everything clean
    local GIT_STATE_COLOR=$GREEN

    # untracked
    if [[ -n $(git ls-files --other --exclude-standard 2> /dev/null) ]]; then
        GIT_STATE_COLOR=$RED
    # modified
    elif ! git diff --quiet 2> /dev/null; then
        GIT_STATE_COLOR=$MAGENTA
    # staged
    elif ! git diff --cached --quiet 2> /dev/null; then
        GIT_STATE_COLOR=$B_MAGENTA
    fi

    #spit it out
    if [[ -n $GIT_STATE_COLOR ]]; then
        echo "\[$GIT_STATE_COLOR\]"
    fi
}

# build the full git prompt
git_prompt_string() {
    local GIT_WHERE="$(parse_git_branch)"
    if [ -n "$GIT_WHERE" ]; then
        local GIT_COLOR="$(git_state_color)"
        #$GIT_WHERE=${GIT_WHERE#(refs/heads/|tags/)}
        echo "$GIT_COLOR[$(parse_git_commit_status)$(git_merge_status)$GIT_COLOR${GIT_WHERE/refs\/heads\/}] "
    fi
}

# the basic prompt
base_prompt() {
    local HN=$(hostname | tr [:upper:] [:lower:] | cut -d. -f1)
    # basic prompt (user@host:prompt)
    echo "\[$GREEN\]\u\[$B_WHITE\]@\[$GREEN\]$HN\[$B_WHITE\]:\[$BLUE\]\w "
}

# the prompt character
prompt_char() {
    if [[ $UID == "0" ]]; then
        PROMPT_STRING="\[$RED\]#"
    else
        PROMPT_STRING="\[$B_WHITE\]$"
    fi
    echo "$PROMPT_STRING"
}

# apple terminal update
terminal_title() {

    # reset everything!
    printf '\e]0;\a'
    printf '\e]7;\a'
    # if a Mac Terminal
    if [ "$TERM_PROGRAM" == "Apple_Terminal" ] && [ -z "$INSIDE_EMACS" ]; then
        local SEARCH=' '
        local REPLACE='%20'
        local PWD_URL="file://$HOSTNAME${PWD//$SEARCH/$REPLACE}"
        printf '\e]7;%s\a' "$PWD_URL"
    else
        # non-Mac terminal
        printf "\033]0;%s@%s:%s\033\\" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/~}"
    fi

}

# what is called from PROMPT_COMMAND
__prompt_command() {

    # reset the prompt
    PS1=""

    # update terminal title
    terminal_title

    # if we have git, then include git stuff in the prompt
    if [ "${BASH_VERSINFO[0]}" -lt "4" ]; then
        local HN=$(hostname | tr [:upper:] [:lower:] | cut -d. -f1)
        PS1="\u@$HN:\w \\$ "
    elif [ -n "$(which git 2>/dev/null)" ]; then
        PS1="$(base_prompt)$(git_prompt_string)$(prompt_char) \[$NO_COLOR\]"
    else
        PS1="$(base_prompt)$(prompt_char) \[$NO_COLOR\]"
    fi
}

#
# build prompt
#
##############

PROMPT_COMMAND=__prompt_command
export $PROMPT_COMMAND
