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

if [[ ${surface} == *"CNT"* ]]; then
    surface_category="CNT"
elif [[ ${surface} == "graphene" ]]; then 
    surface_category="G"
elif [[ ${surface} == *"groove"* ]]; then
    surface_category="G"
elif [[ ${surface} == "graphene3" ]]; then
    surface_category="G"
else exit 1
fi

# 1. Initialization.
cd nvt
rm vacf_plots.${surface_category}.py

# 2， MSD & VACF computation.
cp $HOME/Desktop/analysis/plotting/vacf_plots.${surface_category}.py .
python vacf_plots.${surface_category}.py

# 3. File cleanup.
rm vacf_plots.${surface_category}.py
if [ ! -d $HOME/Desktop/images ]; then
    mkdir $HOME/Desktop/images
fi
if [ ! -d $HOME/Desktop/images/individual_vacf ]; then
    mkdir $HOME/Desktop/images/individual_vacf
fi
mv 2_vacf_plot.png $HOME/Desktop/images/individual_vacf/${system}.png
cd ..
rm 9_1_vacf_plots.sh

