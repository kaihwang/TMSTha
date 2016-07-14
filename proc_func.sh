#!/bin/bash

WD='/home/despoB/kaihwang/Rest/TMS_Thalamus/'

for s in 614; do

	if [ ! -e ${WD}/${s}/Pre/MPRAGE/mprage_final.nii.gz]; then
		
		cd ${WD}/${s}/Pre/MPRAGE/	
		preprocessMprage -r MNI_2mm -b "-R -f 0.2 -g -0.3" -d a -no_bias -o mprage_final.nii.gz -p "IM*"
	fi

	for site in Pre S1 IPL; do

		for run in 1 2 3; do

			if [ -d ${WD}/${s}/${site}/Run${run} ]; then

				cd ${WD}/${s}/${site}/Run${run}

				if [ ! -e ${WD}/${s}/${site}/Run${run}/brnswktm_functional_4.nii.gz ]; then
					
					preprocessFunctional -dicom "IM*" \
					-mprage_bet ${WD}/${s}/Pre/MPRAGE/mprage_bet.nii.gz \
					-warpcoef ${WD}/${s}/Pre/MPRAGE/mprage_warpcoef.nii.gz \
					-func_refimg ${WD}/${s}/${site}/SBRef/*.dcm \
					-tr 1.0 \
					-bandpass_filter 0.009 0.08 \
					-rescaling_method 100_voxelmean \
					-template_brain MNI_2mm \
					-func_struc_dof bbr \
					-warp_interpolation spline \
					-constrain_to_template y \
					-4d_slice_motion \
					-custom_slice_times detect \
					-delete_dicom archive \
					-motion_censor fd=0.3,dvars=20 \
					-nuisance_file nuisance_regressors.txt \
					-nuisance_regression 6motion,d6motion,csf,dcsf,wm,dwm \
					-cleanup \
					-smoothing_kernel 4
					#preprocessFunctional -resume

				fi
			fi
		done
	done
done


#-dicom "IM*" \
