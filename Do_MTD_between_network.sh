

MTD='/home/despoB/kaihwang/bin/TTD/Models'
WD='/home/despoB/kaihwang/Rest/NKI/'
cd ${WD}


for s in 0102826_session_1; do


	cd ${WD}/${s}/MNINonLinear/

	3dmaskave -mask ~/Rest/ROIs/community_subject_1500_8.0_25_2mm_filled_shifted.nii \
	-mrange 0.9 1.1 \
	-q \
	${WD}/${s}/MNINonLinear/rfMRI_REST_mx_645.nii.gz > ${WD}/${s}/MNINonLinear/DF.1D

	3dmaskave -mask ~/Rest/ROIs/community_subject_1500_8.0_25_2mm_filled_shifted.nii \
	-mrange 5.9 6.1 \
	-q \
	${WD}/${s}/MNINonLinear/rfMRI_REST_mx_645.nii.gz > ${WD}/${s}/MNINonLinear/FP.1D

	3dmaskave -mask ~/Rest/ROIs/community_subject_1500_8.0_25_2mm_filled_shifted.nii \
	-mrange 3.9 4.1 \
	-q \
	${WD}/${s}/MNINonLinear/rfMRI_REST_mx_645.nii.gz > ${WD}/${s}/MNINonLinear/CO.1D

	echo "${WD}/${s}/MNINonLinear/DF.1D ${WD}/${s}/MNINonLinear/FP.1D ${WD}/${s}/MNINonLinear/DF-FP.1D 10" | python ${MTD}/run_MTD.py
	echo "${WD}/${s}/MNINonLinear/DF.1D ${WD}/${s}/MNINonLinear/CO.1D ${WD}/${s}/MNINonLinear/DF-CO.1D 10" | python ${MTD}/run_MTD.py

	3dDeconvolve \
	-input ${WD}/${s}/MNINonLinear/rfMRI_REST_mx_645.nii.gz \
	-automask \
	-polort A \
	-num_stimts 1 \
	-stim_file 1 ${WD}/${s}/MNINonLinear/DF-FP.1D -stim_label 1 MTD_DF-FP \
	-num_glt 1 \
	-gltsym 'SYM: +0.1*MTD_DF-FP' -glt_label 1 MTD_DF-FP \
	-fout \
	-rout \
	-tout \
	-nocout \
	-bucket ${WD}/${s}/MNINonLinear/MTD_DF-FP_stats \
	-GOFORIT 100 \
	-noFDR \
	-x1D_stop 

	. ${WD}/${s}/MNINonLinear/MTD_DF-FP_stats.REML_cmd

	3dDeconvolve \
	-input ${WD}/${s}/MNINonLinear/rfMRI_REST_mx_645.nii.gz \
	-automask \
	-polort A \
	-num_stimts 1 \
	-stim_file 1 ${WD}/${s}/MNINonLinear/DF-CO.1D -stim_label 1 MTD_DF-CO \
	-num_glt 1 \
	-gltsym 'SYM: +0.1*MTD_DF-CO' -glt_label 1 MTD_DF-CO \
	-fout \
	-rout \
	-tout \
	-nocout \
	-bucket ${WD}/${s}/MNINonLinear/MTD_DF-CO_stats \
	-GOFORIT 100 \
	-noFDR \
	-x1D_stop 

	. ${WD}/${s}/MNINonLinear/MTD_DF-CO_stats.REML_cmd


done