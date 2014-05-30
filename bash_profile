# Set PATH
PATH=/usr/local/bin:$PATH  # Homebrew
PATH=$HOME/bin:$PATH       # Vim
export PATH


# Python 2.7
export PYTHONPATH=/usr/local/lib/python2.7/site-packages:$PYTHONPATH


# User specific aliases
alias ls='ls -F -G'
alias ll='ls -lh'


# Source git scripts
# curl https://github.com/git/git/raw/master/contrib/completion/git-completion.bash -OL
# curl https://github.com/git/git/raw/master/contrib/completion/git-prompt.sh -OL
source ~/.git-completion.bash
source ~/.git-prompt.sh


# ANSI Color codes

# Regular
Red="\[\033[0;31m\]"
Green="\[\033[0;32m\]"
Yellow="\[\033[0;33m\]"
Blue="\[\033[0;34m\]"
Purple="\[\033[0;35m\]"
Cyan="\[\033[0;36m\]"
Gray="\[\033[1;30m\]"

# Bold
BRed="\[\033[1;31m\]"
BGreen="\[\033[1;32m\]"
BYellow="\[\033[1;33m\]"
BBlue="\[\033[1;34m\]"
BPurple="\[\033[1;35m\]"
BCyan="\[\033[1;36m\]"

# Turn off colors
Color_Off="\[\033[0m\]"


# Set up command prompt
function __prompt_command()
{
    # Print command history number, with color corresponding to
    # the exit status of last command
    EXIT="$?"
    PS1=""
    if [ $EXIT -eq 0 ]; then
        #PS1+="\[$Green\][\!]\[$Color_Off\] "
        PS1+="${Green}[\!]${Color_Off} "
    else
        PS1+="${Red}[\!]${Color_Off} "
    fi


    # If logged in via ssh, show the IP of the client
    if [ -n "$SSH_CLIENT" ]; then
        PS1+="${Yellow}("${SSH_CLIENT%% *}")${Color_Off} "
    fi


    # Basic information (user:path)
    PS1+="${Gray}\u:${Blue}\W${Color_Off}"


    # If in a git repo, output git status information
    local git_status="`git status -unormal 2>&1`"
    if ! [[ "$git_status" =~ Not\ a\ git\ repo ]]; then
        # Parse the porcelain output of git status
        if [[ "$git_status" =~ nothing\ to\ commit ]]; then
            local Color_On=${BGreen}
        elif [[ "$git_status" =~ nothing\ added\ to\ commit\ but\ untracked\ files\ present ]]; then
            local Color_On=${BPurple}
        elif [[ "$git_status" =~ Changes\ to\ be\ committed ]]; then
            local Color_On=${BYellow}
        else
            local Color_On=${BRed}
        fi

        # git-prompt.sh is required to use `__git_ps1`
        branch=$(__git_ps1)

        PS1+="${Color_On}$branch${Color_Off}"
    fi


    PS1+=" \$ "
}

PROMPT_COMMAND=__prompt_command
