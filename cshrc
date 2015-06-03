# User specific aliases
alias ls ls -F --color=auto
alias ll ls -lh
alias tele "echo 'Please go to https://fusion.gat.com/support/directory/ to lookup Energy personnel.'" 

# Source git scripts
# curl https://github.com/git/git/raw/master/contrib/completion/git-completion.bash -OL
# curl https://github.com/git/git/raw/master/contrib/completion/git-prompt.sh -OL
#source ~/.git-completion.bash
#source ~/.git-prompt.sh


# ANSI Color codes

# Regular
set Red    = "%{\033[0;31m%}"
set Green  = "%{\033[0;32m%}"
set Yellow = "%{\033[0;33m%}"
set Blue   = "%{\033[0;34m%}"
set Purple = "%{\033[0;35m%}"
set Cyan   = "%{\033[0;36m%}"
set Gray   = "%{\033[1;30m%}"

# Bold
set BRed    = "%{\033[1;31m%}"
set BGreen  = "%{\033[1;32m%}"
set BYellow = "%{\033[1;33m%}"
set BBlue   = "%{\033[1;34m%}"
set BPurple = "%{\033[1;35m%}"
set BCyan   = "%{\033[1;36m%}"

# Turn off colors
set Color_Off = "%{\033[0m%}"


# -----------------------------------------------------------------------------
# Failed attempts to get an interactive git prompt...
# -----------------------------------------------------------------------------
#
##if ($?prompt) then
##    if ($? == 0) then
##        set EXIT = "${Green}[\!]${Color_Off}"
##    else
##        set EXIT = "${Red}[\!]${Color_Off}"
##    endif
#
##    set name = "%n "
###    alias precmd 'set prompt = $EXIT $name'
###    set prompt = "$EXIT $name"
##endif
#
##alias precmd 'set prompt = "`csh ~/dotfiles/tcsh_functions/get_prompt.csh`"'
##alias precmd 'set prompt = "$EXIT $name"'
##alias precmd 'set git_branch=`~/dotfiles/tcsh_functions/git_branch`'
##set prompt="${Gray}%n:${Blue}%~${Color_Off} (%$git_branch) $ "
#
##if ($?prompt) then
#    #alias precmd 'set prompt = "`csh ~/dotfiles/tcsh_functions/get_prompt.csh`"'
#    #set prompt = ''
#    #set prompt = "`~/dotfiles/tcsh_functions/get_prompt.csh`"
##endif
#
# -----------------------------------------------------------------------------

# Settling on this (lame) prompt for now...
set prompt="${Gray}%n:${Blue}%~${Color_Off} $ "


# GA's Venus computer
if ($HOSTNAME == "venusa") then

    # Set terminal type
    setenv TERM xterm-256color

    # Path
    setenv PATH .:/task/imd/local64/bin:$PATH  # DIII-D Python installation

    # Python information
    setenv PYTHONPATH $HOME/python
    setenv PYTHONSTARTUP $HOME/startup.py
    # "v" is the simplest command on Venus to start a job on a worker node,
    # providing load balancing between worker nodes and passing current
    # environmental variables from the head node to the respective worker node
    alias python "v '/task/imd/anaconda/bin/python'"
    alias ipython "v '/task/imd/anaconda/bin/ipython --pylab'"

    # IDL information
    setenv IDL_STARTUP $HOME/idl_startup.pro

    # PCI MDSplus server path
    setenv pci_path hermit.gat.com::/trees/pci

endif
