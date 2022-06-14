#!/bin/bash

###############################
adsorbate=`cut -d'/' -f5 <<< "$(pwd)"`
surface=`cut -d'/' -f6 <<< "$(pwd)"`
system="${adsorbate}_${surface}"
surface=`cut -d'_' -f1 <<< ${surface}`

if [[ ${surface} == *"CNT"* ]]; then
    surface_category="CNT"
elif [[ ${surface} == "graphene" ]]; then 
    surface_category="G"
elif [[ ${surface} == *"BNNT"* ]]; then
    surface_category="BNNT"
elif [[ ${surface} == *"boronnitride"* ]]; then 
    surface_category="BN"
elif [[ ${surface} == *"groove"* ]]; then
    surface_category="groove"
elif [[ ${surface} == "graphene3" ]]; then
    surface_category="graphene3"
else exit 1
fi
###############################

# 1. Initialization.
cd nvt
export MODEL_DIR="$HOME/Desktop/models"
if [ ! -d ${MODEL_DIR} ] 
then
    echo "Error: Directory MODEL_DIR does not exist."
    rm surpressed_output.txt
    cd ..
    return
fi
rm msd_vacf.${surface}.py msd_vacf.out

# 2， MSD & VACF computation.
cp $HOME/Desktop/analysis/after_simulation/msd_vacf.${surface_category}.py .
python msd_vacf.${surface_category}.py 1000
rm msd_vacf.${surface_category}.py

# 3. File cleanup.
cd ..
rm 7_msd_vacf.sh

