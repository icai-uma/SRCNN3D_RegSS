#!/bin/bash
# This script executes a DEMO for the RegSS-SRCNN3D method
# Author:
#  	Karl Thurnhofer Hemsi
#   Department of Computer Languages and Computer Sciences
#   University of Málaga (Spain)

SRCNN3D_Path=../../../SRCNN3D
ImagesPath=./Images
RegSSImagesPath=./RegSSImages
SRImagesPath=./SR_RegSSImages
ZoomFactor=2

FICHEROS=`find $ImagesPath/*.nii -maxdepth 0`
for fich in $FICHEROS; 
do
	path=${fich%/*}
	file=${fich##*/}
	base=${file%%.*}

	echo "Processing image: ${base}"

	# Downsample HR image to obtain a LR image (if it is available)
	if [[ ${base} != *"_LR"* ]]; then
		suffix='_LR'
		matlab -nojvm -nodisplay -nosplash -r "HR2LR('$fich',$ZoomFactor); exit();"
	else
		suffix=''
	fi

	# Create regular shifts for this image
	mkdir -p $RegSSImagesPath
	matlab -nojvm -nodisplay -nosplash -r "CreateRegularShifts('${path}/${base}${suffix}.nii','$RegSSImagesPath'); exit();"


	# Define SRCNN model path
	NumStepsModel=470000
	TestPath=${SRCNN3D_Path}/Test
	Model=${TestPath}/caffe_model/Iter_${NumStepsModel}

	# Create results directory
	mkdir -p $SRImagesPath

	# Execute a loop to store the SRCNN3D input
	SUBFICHEROS=`dir $RegSSImagesPath/${base}*.nii`
	ENTRADA=''
	for subfich in $SUBFICHEROS; 
	do
		subfile=${subfich##*/}
		subbase=${subfile%%.*}
		ENTRADA="${ENTRADA} -t ${subfich} -r ${SRImagesPath}/${subbase}_SRCNN3D.nii"
	done

	# Run the SRCNN3D
	echo "Performing SRCNN3D tests"
	python ${TestPath}/demo_SRCNN3D.py $ENTRADA -m ${Model}/SRCNN3D_iter_${NumStepsModel}.caffemodel -n ${Model}/SRCNN3D_deploy.prototxt -g True -s "${ZoomFactor},${ZoomFactor},${ZoomFactor}"

	# Reconstruct final image using upsampled shifted images
	matlab -nojvm -nodisplay -nosplash -r "ReconstructImages('${path}','${base}','$RegSSImagesPath','${SRImagesPath}',${ZoomFactor}); exit();"


done