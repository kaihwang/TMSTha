#!/bin/bash

WD='/home/despoB/kaihwang/Rest/TMS_Thalamus/'

for s in 608; do

	for site in Pre; do

		for run in 1 2; do

			if [ -d ${WD}/${s}/${site}/Run${run} ]; then

				cd ${WD}/${s}/${site}/Run${run}

				if [ ! -e ${WD}/${s}/${site}/Run${run}/nswktm_functional_4.nii.gz ]; then
					
					preprocessFunctional -dicom "IM*" \
					-mprage_bet ${WD}/${s}/Pre/MPRAGE/mprage_bet.nii.gz \
					-warpcoef ${WD}/${s}/Pre/MPRAGE/mprage_warpcoef.nii.gz \
					-func_refimg ${WD}/${s}/${site}/SBRef/*.dcm \
					-tr 1.0 \
					-rescaling_method 100_voxelmean \
					-template_brain MNI_2mm \
					-func_struc_dof bbr \
					-warp_interpolation spline \
					-constrain_to_template y \
					-4d_slice_motion \
					-no_hp \
					-cleanup \
					-custom_slice_times detect \
					-delete_dicom archive \
					-smoothing_kernel 4
					#preprocessFunctional -resume

				fi
			fi
		done
	done
done


#-dicom "IM*" \