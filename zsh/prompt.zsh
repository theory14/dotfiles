# Configure PS1 prompt

# we need colors
autoload -U colors && colors # Enable colors in prompt
# allow our dynamic prompt
setopt promptsubst



# get hostname in lowercase If connected to Active Directory, you often get
# stuck with an ugly all-CAPS hostname.
HN="$(hostname | tr '[:upper:]' '[:lower:]' | cut -d. -f1)"

# Prompt component definitions
P_AT="%{$fg_bold[white]%}@%{$reset_color%}"
P_COLON="%{$fg_bold[white]%}:%{$reset_color%}"
P_USER="%{$fg[green]%}%n%{$reset_color%}"
P_HOSTNAME="%{$fg[green]%}${HN}%{$reset_color%}"
P_PWD="%{$fg[blue]%}%4~%{$reset_color%}"

# Change the color of the prompt character based on UID
# root gets a red prompt, everyone else, bold white
if [ "${UID}" -ne 0 ]; then
	P_CHAR="%{$fg_bold[white]%}%#%{$reset_color%}"
else
	P_CHAR="%{$fg_bold[red]%}%#%{$reset_color%}"
fi

GIT_P_AHEAD="%{$fg[cyan]%}+NUM%{$reset_color%}"
GIT_P_BEHIND="%{$fg[cyan]%}-NUM%{$reset_color%}"
GIT_P_MERGING="%{$fg_bold[magenta]%}⚡︎%{$reset_color%}"
GIT_P_UNTRACKED_COLOR="%{$fg[red]%}"
GIT_P_MODIFIED_COLOR="%{$fg[magenta]%}"
GIT_P_STAGED_COLOR="%{$fg_bold[magenta]%}"
GIT_P_CLEAN_COLOR="%{$fg[green]%}"

# Show Git branch/tag, or name-rev if on detached head
parse_git_branch() {
    (git symbolic-ref -q HEAD || git name-rev --name-only --no-undefined --always HEAD) 2> /dev/null
}

# determine commits ahead/behind from upstream
parse_git_commit_status() {
    # num commits ahead
    local NUM_AHEAD="$(git log --oneline @{u}.. 2> /dev/null | wc -l | tr -d ' ')"
    if [ "$NUM_AHEAD" -gt 0 ]; then
        echo "$GIT_COUNT${GIT_P_AHEAD//NUM/$NUM_AHEAD} "
    fi
    # num commits behind
    local NUM_BEHIND="$(git log --oneline ..@{u} 2> /dev/null | wc -l | tr -d ' ')"
    if [ "$NUM_BEHIND" -gt 0 ]; then
        echo "$GIT_COUNT${GIT_P_BEHIND//NUM/$NUM_BEHIND} "
    fi
}

git_merge_status() {
    # merging
    local GIT_DIR="$(git rev-parse --git-dir 2> /dev/null)"
    if [ -n $GIT_DIR ] && test -r $GIT_DIR/MERGE_HEAD; then
        echo "$GIT_P_MERGING "
    fi
}

# Show different symbols as appropriate for various Git repository states
git_state_color() {

    #  default to everything clean
    local GIT_STATE_COLOR=$GIT_P_CLEAN_COLOR
    # untracked
    if [[ -n $(git ls-files --other --exclude-standard 2> /dev/null) ]]; then
        GIT_STATE_COLOR=$GIT_P_UNTRACKED_COLOR
    # modified
    elif ! git diff --quiet 2> /dev/null; then
        GIT_STATE_COLOR=$GIT_P_MODIFIED_COLOR
    # staged
    elif ! git diff --cached --quiet 2> /dev/null; then
        GIT_STATE_COLOR=$GIT_P_STAGED_COLOR
    fi
    #spit it out
    if [[ -n $GIT_STATE_COLOR ]]; then
        echo "$GIT_STATE_COLOR"
    fi

}

# If inside a Git repository, print its branch and state
git_prompt_string() {
  local git_where
  local GIT_COLOR
  git_where="$(parse_git_branch)"
  GIT_COLOR="$(git_state_color)"
  [ -n "$git_where" ] && echo " ${GIT_COLOR}[$(parse_git_commit_status)$(git_merge_status)${GIT_COLOR}${git_where#(refs/heads/|tags/)}]%{$reset_color%}"
}

prompt_string() {
	echo "${P_USER}${P_AT}${P_HOSTNAME}${P_COLON}${P_PWD}"
}

PS1='$(prompt_string)$(git_prompt_string) ${P_CHAR} '
