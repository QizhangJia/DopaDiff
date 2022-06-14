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
rm com_distn_plots.${surface_category}.py

# 2， MSD & VACF computation.
cp $HOME/Desktop/analysis/plotting/com_distn_plots.${surface_category}.py .
python com_distn_plots.${surface_category}.py

# 3. File cleanup.
rm com_distn_plots.${surface_category}.py
if [ ! -d $HOME/Desktop/images ]; then
    mkdir $HOME/Desktop/images
fi
if [ ! -d $HOME/Desktop/images/individual_com_distn ]; then
    mkdir $HOME/Desktop/images/individual_com_distn
fi
mv 3_com_distn_plot.png $HOME/Desktop/images/individual_com_distn/${system}.png
cd ..
rm 10_com_distn_plots.sh

