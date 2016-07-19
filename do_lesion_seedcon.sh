WD='/home/despoB/kaihwang/Rest/NKI'

cd ${WD}
for s in $(/bin/ls -d *); do #$(/bin/ls -d *)

	cd ${WD}/${s}/MNINonLinear/

	3dmaskave -mask /home/despoB/kaihwang/Rest/Thalamus_ROI_connectivity/Lesion_ROIs/168_lesion_mask.nii.gz \
	-q \
	rfMRI_REST_mx_645_ncsreg.nii.gz > Tha_168_lesion.1D

	3dmaskave -mask /home/despoB/kaihwang/Rest/Thalamus_ROI_connectivity/Lesion_ROIs/176_lesion_mask.nii.gz \
	-q \
	rfMRI_REST_mx_645_ncsreg.nii.gz > Tha_176_lesion.1D

	3dfim+ \
	-input rfMRI_REST_mx_645_ncsreg.nii.gz \
	-ideal_file Tha_168_lesion.1D \
	-out Correlation \
	-bucket Tha_168_lesion_seed_cor 

	3dfim+ \
	-input rfMRI_REST_mx_645_ncsreg.nii.gz \
	-ideal_file Tha_176_lesion.1D \
	-out Correlation \
	-bucket Tha_176_lesion_seed_cor



done 