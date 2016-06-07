WD='/home/despoB/kaihwang/Rest/TMS_Thalamus/'
MTD='/home/despoB/kaihwang/bin/TTD/Models'


for s in 607; do

	cd ${WD}/${s}/Pre/

	3dTcat -prefix func_concat.nii.gz Run1/brnswktm_functional_4.nii.gz Run2/brnswktm_functional_4.nii.gz

	# 3dmaskave -mask ~/Rest/ROIs/community_subject_1500_8.0_25_2mm_filled_shifted.nii \
	# -mrange 0.9 1.1 \
	# -q \
	# func_concat.nii.gz > DF.1D

	# 3dmaskave -mask ~/Rest/ROIs/community_subject_1500_8.0_25_2mm_filled_shifted.nii \
	# -mrange 5.9 6.1 \
	# -q \
	# func_concat.nii.gz > FP.1D

	# 3dmaskave -mask ~/Rest/ROIs/community_subject_1500_8.0_25_2mm_filled_shifted.nii \
	# -mrange 3.9 4.1 \
	# -q \
	# func_concat.nii.gz > CO.1D

	# echo "${WD}/${s}/MNINonLinear/DF.1D ${WD}/${s}/MNINonLinear/FP.1D ${WD}/${s}/MNINonLinear/DF-FP.1D 10" | python ${MTD}/run_MTD.py
	# echo "${WD}/${s}/MNINonLinear/DF.1D ${WD}/${s}/MNINonLinear/CO.1D ${WD}/${s}/MNINonLinear/DF-CO.1D 10" | python ${MTD}/run_MTD.py

	3dmaskave -mask /home/despoB/kaihwang/Rest/TMS_Thalamus/ROIs/Tha_MTD_ROI_2x2x2.nii.gz \
	-q \
	func_concat.nii.gz > Tha.1D

	3dfim+ \
	-input func_concat.nii.gz \
	-ideal_file Tha.1D \
	-out Correlation \
	-bucket Tha_seed_cor 

	ln -s ~/standard/mni_icbm152_nlin_asym_09c/mni_icbm152_t1_tal_nlin_asym_09c_brain.nii template.nii
	ln -s ~/Rest/TMS_Thalamus/ROIs/RIPL.nii.gz RIPL.nii.gz

	rm func_concat.nii.gz

done 