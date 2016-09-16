#!/bin/bash

WD='/home/despoB/kaihwang/Rest/TMS_Thalamus/'

for s in 606; do

	#if [ ! -e ${WD}/${s}/Pre/MPRAGE/mprage_final.nii.gz]; then
	#	
	#	cd ${WD}/${s}/Pre/MPRAGE/	
	#	preprocessMprage -r MNI_2mm -b "-R -f 0.2 -g -0.3" -d a -no_bias -o mprage_final.nii.gz -p "IM*"
	#fi

	for site in Pre S1 IPL; do

		for run in 1 2 3; do

			if [ -d ${WD}/${s}/${site}/Run${run} ]; then

				cd ${WD}/${s}/${site}/Run${run}

				if [ ! -e ${WD}/${s}/${site}/Run${run}/nfwktm_functional.nii.gz ]; then
					
					tar -xf functional_dicom.tar.gz

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
					-custom_slice_times detect \
					-delete_dicom archive \
					-motion_censor fd=0.3,dvars=20 \
					-nuisance_compute 6motion,d6motion,csf,dcsf,wm,dwm \
					-cleanup \
					-no_smooth

					3dpc -vmean -mask .template_csf_prob.nii.gz -pcsave 5 -prefix csf_PC nfwktm_functional.nii.gz
					3dpc -vmean -mask .template_wm_prob.nii.gz -pcsave 5 -prefix wm_PC nfwktm_functional.nii.gz

					3dmaskave -quiet \
					-mask /home/despoB/connectome-thalamus/ROIs/Thalamus_surround_cortical_mask_LPI.nii.gz \
					nfwktm_functional.nii.gz > ncs.1D

					3dTproject -input nfwktm_functional.nii.gz \
					-ort csf_PC_vec.1D \
					-ort wm_PC_vec.1D \
					-ort motion.par \
					-passband 0.008 0.09 \
					-automask \
					-prefix preproc_functinal.nii.gz	

				fi
			fi
		done
	done
done


#-dicom "IM*" \
