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

matlab -nodisplay -nodesktop -noFigureWindows -r "run $MATLAB_CODE_PATH; exit";

