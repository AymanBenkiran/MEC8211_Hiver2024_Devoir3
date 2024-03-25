#!/bin/bash
#set -ex
# But: Ce script effectue les simulations necessaires pour
#      effectuer une analyse de convergence en espace.
#
# Exemple: ./spatial_order_convergence_study.sh
# Ce fichier doit etre lance a partir du dossier LBM_code

# messages
#---------
  USAGE="Usage: ./spatial_order_convergence_study.sh"
#
#====================================================================
# Verify if the script has the right number of arguments (2) or abort
#====================================================================
  if test $# -ne 0
  then echo "Wrong number of arguments: $USAGE"
       exit
  fi

#====================================================================
# Script:
#====================================================================
MATLAB_CODE_PATH="./launch_simulationLBM.m"
RESULTS_FOLDER="../../results/spatial_order_convergence_study"
DATA_FOLDER="../../data/spatial_order_convergence_study"
DATA_FILE="$DATA_FOLDER/spatial_order_convergence_study.csv"

# For computing dx and NX values
MULTIPLIERS=(1 2 3 4 6 8)
INITIAL_DX=0.000004000
INITIAL_NX=50

echo "*****************************************************"
echo "*****************************************************"

# Check if results directory of the study already exists before creating
if [ ! -d "$RESULTS_FOLDER" ]; then
    # If the directory doesn't exist, create it
    mkdir -p "$RESULTS_FOLDER"
    echo "Directory created: $RESULTS_FOLDER"
else
    echo "Directory already exists: $RESULTS_FOLDER"
fi
# Check if data directory of the study already exists before creating
if [ ! -d "$DATA_FOLDER" ]; then
    # If the directory doesn't exist, create it
    mkdir -p "$DATA_FOLDER"
    echo "Directory created: $DATA_FOLDER"
else
    echo "Directory already exists: $DATA_FOLDER"
fi

# Write header in data file
echo "dx,NX,imposed_poro,k_in_micron2,effective_poro" > $DATA_FILE
echo "*****************************************************"

# Loop over multiplier to generate cases
for MULT in "${MULTIPLIERS[@]}"
do
  # Compute current dx and NX values
  CURRENT_DX=$(echo "scale=10; $INITIAL_DX/$MULT" | bc)
  CURRENT_NX=$(echo "$INITIAL_NX*$MULT" | bc)
  echo " Running simulation for:"
  echo "  dx = $CURRENT_DX m"
  echo "  Nx = $CURRENT_NX"

  # Change values in matlab script
  DX_LINE=$(grep "dx=" $MATLAB_CODE_PATH)
  NX_LINE=$(grep "NX=" $MATLAB_CODE_PATH)
  DX_NEW_LINE=$(echo "    dx= $CURRENT_DX  ; % grid size in m")
  NX_NEW_LINE=$(echo "    NX= $CURRENT_NX;")
  awk -v line="$DX_NEW_LINE" "/$DX_LINE/ {print line} 1" "$MATLAB_CODE_PATH" > tmp_file && mv tmp_file "$MATLAB_CODE_PATH"
  awk -v line="$NX_NEW_LINE" "/$NX_LINE/ {print line} 1" "$MATLAB_CODE_PATH" > tmp_file && mv tmp_file "$MATLAB_CODE_PATH"
  awk "!/$DX_LINE/" "$MATLAB_CODE_PATH" > tmp_file && mv tmp_file "$MATLAB_CODE_PATH"
  awk "!/$NX_LINE/" "$MATLAB_CODE_PATH" > tmp_file && mv tmp_file "$MATLAB_CODE_PATH"

  # Run matlab code for the case
  matlab -nodisplay -nodesktop -nosplash -noFigureWindows -r "try launch_simulationLBM(\"$RESULTS_FOLDER\",\"$DATA_FILE\"); catch; end; quit"
  echo "*****************************************************"
done

# Postprocess results
echo "*****************************************************"
echo " Postprocessing results"
echo "*****************************************************"
python3 ../postprocessing/spatial_order_convergence_postprocessing.py
echo "*****************************************************"
echo "*****************************************************"
echo " Done! :D"
echo "*****************************************************"
echo "*****************************************************"