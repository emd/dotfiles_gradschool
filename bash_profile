# Mac OSX runs a login shell (and thus sources `.bash_profile`) by default
# for each new terminal window. However, in general, Linux will only
# source `.bash_profile` when the user logs into a shell (i.e. enters
# username and password); otherwise, when opening new terminals when
# already logged in, Linux will source `.bashrc`
#
# To avoid maintaining two separate configuration files, we simply place
# all of the configuration options in `.bashrc` (so that the options apply
# to non-login shells) and then source `.bashrc` from `.bash_profile`
# (so that the configuration options also apply to login shells)
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi
