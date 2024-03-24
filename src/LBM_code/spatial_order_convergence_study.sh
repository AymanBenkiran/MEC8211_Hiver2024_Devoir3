#!/bin/bash
#set -ex
# But: Ce script effectue lance les simulations necessaire pour
#      effectuer une analyse de convergence en espace.
#
# Exemple: mon_premier_script repertoire1 repertoire2
#

# messages
#---------
  USAGE="Usage: spatial_order_convergence_study.sh"
#
#====================================================================
# verify if the script has the right number of arguments (2) or abort
#====================================================================
#  if test $# -ne 2
#  then echo "Wrong number of arguments: $USAGE"
#       exit
#  fi

#
# Script:
#

MATLAB_CODE_PATH="./launch_simulationLBM.m"
CURRENT_DX=0.000016000
CURRENT_NX=12.5

echo "*****************************************************"

for i in {1..4}
do
  # Compute current dx value
  CURRENT_DX=$(echo "$CURRENT_DX*0.5" | bc)
  CURRENT_NX=$(echo "$CURRENT_NX*2" | bc)
  echo " Running simulation for:"
  echo "  dx = $CURRENT_DX m"
  echo "  Nx = $CURRENT_NX"

  # Change values in matlab script
  DX_LINE=$(grep "dx=" $MATLAB_CODE_PATH)
  NX_LINE=$(grep "NX=" $MATLAB_CODE_PATH)
  DX_NEW_LINE=$(echo "dx= $CURRENT_DX  ; % grid size in m")
  NX_NEW_LINE=$(echo "NX= $CURRENT_NX")
  awk -v line="$DX_NEW_LINE" "/$DX_LINE/ {print line} 1" "$MATLAB_CODE_PATH" > tmp_file && mv tmp_file "$MATLAB_CODE_PATH"
  awk -v line="$NX_NEW_LINE" "/$NX_LINE/ {print line} 1" "$MATLAB_CODE_PATH" > tmp_file && mv tmp_file "$MATLAB_CODE_PATH"
  awk "!/$DX_LINE/" "$MATLAB_CODE_PATH" > tmp_file && mv tmp_file "$MATLAB_CODE_PATH"
  awk "!/$NX_LINE/" "$MATLAB_CODE_PATH" > tmp_file && mv tmp_file "$MATLAB_CODE_PATH"

  matlab -nodisplay -nodesktop -noFigureWindows -r "run $MATLAB_CODE_PATH; exit";
done