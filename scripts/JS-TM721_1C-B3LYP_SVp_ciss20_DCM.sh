#! /bin/bash

##############################################################################
#                Job Setup for Turbomole 7.2.1 - Theo Keane                  #
##############################################################################

# Set the names of the relevant input files
JSTM721DEF="1C_B3LYP_SVp.input"
# This must be a bash array, i.e. ("adgone.sh" "adgtwo.sh" "adgthree.sh")
JSTM721ADG=("ciss_soes-20.sh" "x2c_1C.sh")
JSTM721COS="DCM.input"


# Check for environment variables
if [ -z "$TURBODIR" ]; then
  echo -e "\$TURBODIR is not set - something is probably wrong"
  exit 1
elif [ -z "$JSTM721" ]; then
  echo -e "The environment variable \$JSTM721 must be"\
          "set to the path to JOB-SETUP_TM721"
  exit 1
fi

# Check the requested files actually exist
if [ ! -f $JSTM721/define/$JSTM721DEF ]; then
  echo "The define template $JSTM721DEF does not exist"
  exit 1
elif [ ! -f $JSTM721/adg/$JSTM721ADG ]; then
  echo "The adg template $JSTM721ADG does not exist"
  exit 1
elif [ ! -f $JSTM721/cosmoprep/$JSTM721COS ]; then
  echo "The cosmoprep template $JSTM721COS does not exist"
  exit 1
fi

# Check for coord
if [ ! -f coord ]; then
  echo -e "A coord file must be provided"
  exit 1
fi

# Warn if control already exists
if [ -f control ]; then
  echo -e "A control file already exists - better use adg instead!"
  exit 1
fi

# Define first
echo "Running define using $JSTM721DEF"
# run define, hide stdout from terminal and redirect stderr to a file
DEFERROR="/tmp/$JSTM721DEF.$$.error"
define < $JSTM721/define/$JSTM721DEF >/dev/null 2>$DEFERROR
# check for error, if not remove DEFERROR
if grep -q "define ended abnormally" $DEFERROR; then
  echo "An error occured, check $DEFERROR for further details"
  exit 1
else
  rm -f $DEFERROR
fi

# Then adg
for ADG in "${JSTM721ADG[@]}"; do
  echo "Altering control with $ADG"
  $JSTM721/adg/$ADG
done

# Finally cosmoprep
echo "Running cosmoprep using $JSTM721COS"
# run cosmoprep, hide stdout from terminal and redirect stderr to a file
COSERROR="/tmp/$JSTM721COS.$$.error"
cosmoprep < $JSTM721/cosmoprep/$JSTM721COS >/dev/null 2>$COSERROR
# check for error, if not remove COSERROR
if grep -q "cosmoprep ended abnormally" $COSERROR; then
  echo "An error occured, check $COSERROR for further details"
  exit 1
else
  rm -f $COSERROR
fi

# Everything worked
echo "Make sure to use adg to make any final adjustments!"
