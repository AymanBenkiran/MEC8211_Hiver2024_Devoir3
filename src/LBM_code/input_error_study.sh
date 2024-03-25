#!/bin/bash
#set -ex
# But: Ce script effectue les simulations necessaires pour
#      effectuer une analyse sur l'incertitude relative aux
#      donnees d'entrees.
#
# Exemple: ./input_error_study.sh <number of samples (int > 0)>
# Ce fichier doit etre lance a partir du dossier LBM_code

# messages
#---------
  USAGE="Usage: ./input_error_study.sh <number of samples (int > 0)>"
#
#====================================================================
# Verify if the script has the right number of arguments (1) or abort
#====================================================================
  if test $# -ne 1
  then echo "Wrong number of arguments: $USAGE"
       exit
  fi

#====================================================================
# Script:
#====================================================================
MATLAB_CODE_PATH="./launch_simulationLBM_input.m"
RESULTS_FOLDER="../../results/input_error_study"
DATA_FOLDER="../../data/input_error_study"
DATA_FILE="$DATA_FOLDER/input_error_study.csv"

# Get number of samples
NUMBER_OF_SAMPLES=$1

echo "*****************************************************"
echo "*****************************************************"
echo " Running simulation for:"
echo "  Number of porosity samples = $NUMBER_OF_SAMPLES samples"

# Check if results directory of the study already exists before creating
echo "*****************************************************"
if [ ! -d "$RESULTS_FOLDER" ]; then
    # If the directory doesn't exist, create it
    mkdir -p "$RESULTS_FOLDER"
    echo " Directory created: $RESULTS_FOLDER"
else
    echo " Directory already exists: $RESULTS_FOLDER"
fi
# Check if data directory of the study already exists before creating
if [ ! -d "$DATA_FOLDER" ]; then
    # If the directory doesn't exist, create it
    mkdir -p "$DATA_FOLDER"
    echo " Directory created: $DATA_FOLDER"
else
    echo " Directory already exists: $DATA_FOLDER"
fi

# Write header in data file
echo "dx,NX,imposed_poro,k_in_micron2,effective_poro" > $DATA_FILE
echo "*****************************************************"

# Loop over multiplier to generate cases
for ((i = 1; i <= $NUMBER_OF_SAMPLES; i++))
do
  echo "Sample #$i"

  # Run matlab code for the case
  matlab -nodisplay -nodesktop -nosplash -noFigureWindows -r "try launch_simulationLBM_input(\"$RESULTS_FOLDER\",\"$DATA_FILE\"); catch; end; quit;"
  echo "*****************************************************"
done

# Postprocess results
echo "*****************************************************"
echo " Postprocessing results"
echo "*****************************************************"
python3 ../postprocessing/input_error_postprocessing.py
echo "*****************************************************"
echo "*****************************************************"
echo " Done! :D"
echo "*****************************************************"
echo "*****************************************************"