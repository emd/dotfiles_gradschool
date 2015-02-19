# GA's tcsh environment is a black hole swirling with shit... but we're
# stuck with it for the moment. This is my slightly modified login script
# that sources .cshrc (again!?) at the end to ensure that $PATH is correctly
# set as specified in .cshrc

# 20090608 tbt Put $path at the end of path = so any path set in start.login
#              remains. Put . first.
# 20081120 tbt Test for csh_environment existance.

#source /etc/dt/local_architecture/csh_environment # IMPORTANT FOR CDE USERS

if ( -e /etc/dt/local_architecture/csh_environment ) then
     source /etc/dt/local_architecture/csh_environment # IMPORTANT FOR CDE USERS
endif

source /d/global/start.login

umask  022

setenv PRINTER hplj5 # REPLACE hplj5 WITH THE PRINTER YOU WANT FOR YOUR DEFAULT

setenv ACT_ROOT

if ( -e /act/sge/bin/lx24-amd64/qmon ) then
   setenv ACT_ROOT /act/sge/bin/lx24-amd64
endif

set path = ( . /bin /usr/bin /usr/local/bin /usr/contrib/bin \
             /usr/dt/bin /usr/bin/X11 /usr/contrib/bin/X11 \
              /link/bin /link/tools /link/codes /c/run \
             /d/$OSPATH/bin /d/$OSPATH/tools /d/$OSPATH/codes /link/efit \
             $HOME/bin  /opt/fortran90/bin /opt/aCC/bin /usr/ccs/bin \
             /opt/langtools/bin /opt/imake/bin /opt/dynatext/bin \
             $NCARG_ROOT/bin /usr/local/lsf/bin $ACT_ROOT $path )

if ( ! $?DT ) then
  stty erase "^?" kill "^U" intr "^C" eof "^D" susp "^Z" \
       hupcl ixon ixoff echoe echok
  echo ""
  echo ----------------------------------------------------------------
  echo ""
  /bin/ps -u $LOGNAME
  echo ""
  echo ----------------------------------------------------------------
  echo ""
  if ( `find ~/purgatory -name .moved_files -mtime -7 -print | wc -w` < 1 ) then
    ( /d/$OSPATH/tools/cleanup |& mailx -s "CLEANUP on `uname -n`" $LOGNAME & )
    echo "CLEANUP will be run this time."
  else
    echo "CLEANUP will NOT be run this time; the last CLEANUP was too recent."
  endif
  echo ""
# source /d/global/return_to_lastdir # TO BE RETURNED TO YOUR LAST DIRECTORY
endif

setenv CLASSPATH /d/java/classes
setenv IDL_PATH +/usr/local/rsi/idl/lib:+/usr/local/rsi/idl/examples:/link/idl

source /d/global/end.login

# Source .cshrc (again!?) to ensure $PATH set as specified in .cshrc
source .cshrc
