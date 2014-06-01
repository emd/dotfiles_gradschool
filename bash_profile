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


# Personal Macbook
if [ $HOSTNAME == "evans-mbp" ]
then
    # Set PATH
    PATH=/usr/local/bin:$PATH  # Homebrew
    PATH=$HOME/bin:$PATH       # Vim
    export PATH

    # Python 2.7
    export PYTHONPATH=/usr/local/lib/python2.7/site-packages:$PYTHONPATH
fi


# GA's Venus computer
if [ $HOSTNAME == "venusa" ]
then
    # Set terminal type
    export TERM=xterm-256color

    # PATH
    export PATH=/sw/link/bin:$PATH  # Path for ReviewPlus and EFITviewer

    # Python information
    export PYTHONPATH=$HOME/python:$HOME/python_modules
    export PYTHONSTARTUP=$HOME/startup.py

    # IDL information
    export IDL_DIR=/usr/local/bin/idl           # Needed to make IDL work
    export IDL_STARTUP=$HOME/.idl_startup.pro

    # PCI MDSplus server path
    export pci_path=hermit.gat.com::/trees/~pci
fi


# NERSC
if [ -e /usr/common/usg/bin/nersc_host ]
then
    # Global NERSC settings

    # NERSC specific aliases
    alias ls='ls -F --color=auto'

    # Load relevant modules
    module load python
    module load netcdf4-python
    module load gv

    # Set relevant environmental variables
    export SCRATCH=/scratch2/scratchdirs/emd
    export PYTHONSTARTUP=$HOME/.config/ipython/profile_BOUT/startup/startup.py
    export IDL_STARTUP=$HOME/.idl_startup.pro


    # Host-specific NERSC settings

    # First, determine the NERSC Host
    export NERSC_HOST=`/usr/common/usg/bin/nersc_host`

    # Hopper
    if [ $NERSC_HOST == "hopper" ]
    then
        # BOUT++ home directory
        export BOUT_TOP=$HOME/hopper/BOUT-dev   # Developemnt github repo
        #export BOUT_TOP=$HOME/hopper/BOUT-2.0  # Release for 2013 conference
        #export BOUT_TOP=$HOME/hopper/bout      # NERSC github repo

        # Python
        PYTHONPATH=$HOME/python_modules/hopper/lib/python:$PYTHONPATH
        PYTHONPATH=$BOUT_TOP/tools/pylib:$PYTHONPATH
        PYTHONPATH=$BOUT_TOP/tools/pylib/boutdata:$PYTHONPATH
        PYTHONPATH=$BOUT_TOP/tools/pylib/boututils:$PYTHONPATH
        PYTHONPATH=$BOUT_TOP/tools/pylib/post_bout:$PYTHONPATH
        PYTHONPATH=$HOME/python:$PYTHONPATH
        export PYTHONPATH

        # IDL
        export IDL_PATH=$BOUT_TOP/tools/idllib:$IDL_PATH
    fi

    # Edison
    if [ $NERSC_HOST == "edison" ]
    then
        export BOUT_TOP=$HOME/edison/bout
    fi

    # Carver
    if [ $NERSC_HOST == "carver" ]
    then
        # Swap pgi environment for gnu environment
        module unload pgi openmpi
        module load gcc openmpi-gcc  # use gnu verison < 4.7.1

        # add other necessary modules for BOUT++
        module load fftw/3.3.2-gnu
        module load netcdf-gnu/4.1.1

        export BOUT_TOP=$HOME/carver/bout
    fi
fi
