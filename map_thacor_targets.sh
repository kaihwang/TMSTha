

WD='/home/despoB/kaihwang/Rest/NKI/'
cd ${WD}


for s in $(/bin/ls -d *); do


	cd ${WD}/${s}/MNINonLinear/

	# 3dNetCorr -prefix ${WD}/${s}/MNINonLinear/netcorr_tha_plus_gordonROIs \
	# -in_rois /home/despoB/kaihwang/Rest/TMS_Thalamus/ROIs/Tha_MTD_ROI_plus_Gordon_RPI.nii.gz \
	# -inset ${WD}/${s}/MNINonLinear/rfMRI_REST_mx_645_ncsreg.nii.gz

	cat ${WD}/${s}/MNINonLinear/netcorr_tha_plus_gordonROIs_000.netcc | tail -n 334 > ${WD}/${s}/MNINonLinear/cormat_tha_plus_gordonROIs


done