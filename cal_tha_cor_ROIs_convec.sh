WD='/home/despoB/kaihwang/Rest/TMS_Thalamus/'
MTD='/home/despoB/kaihwang/bin/TTD/Models'


for s in 606; do

	for site in Pre S1 IPL; do

		if [ -d ${WD}/${s}/${site} ]; then
			rm -rf /tmp/${s}_{site}
			mkdir /tmp/${s}_${site}

			cd ${WD}/${s}/${site}/

			if [ -d ${WD}/${s}/${site}/Run3 ]; then
				3dTcat -prefix /tmp/${s}_${site}/func_concat.nii.gz Run1/brnswktm_functional_4.nii.gz Run2/brnswktm_functional_4.nii.gz Run3/brnswktm_functional_4.nii.gz
			else
				3dTcat -prefix /tmp/${s}_${site}/func_concat.nii.gz Run1/brnswktm_functional_4.nii.gz Run2/brnswktm_functional_4.nii.gz
			fi	

			3dNetCorr -prefix ${WD}/${s}/${site}/netcorr_gordonROIs \
			-in_rois ${WD}/ROIs/Gordon_333_cortical_2mm.nii.gz \
			-inset /tmp/${s}_${site}/func_concat.nii.gz
			cat ${WD}/${s}/${site}/netcorr_gordonROIs_000.netcc | tail -n 333 > ${WD}/${s}/${site}/GordonROIs_cormat

			echo "${WD}/${s}/${site}/GordonROIs_cormat" | python /home/despoB/kaihwang/bin/TMSTha/run_mod.py > ${WD}/${s}/${site}/aveQ

			3dNetCorr -prefix ${WD}/${s}/${site}/netcorr_tha_gordonROIs \
			-in_rois ${WD}/ROIs/Tha_MTD_ROI_plus_Gordon.nii.gz \
			-inset /tmp/${s}_${site}/func_concat.nii.gz
			cat ${WD}/${s}/${site}/netcorr_tha_gordonROIs_000.netcc | tail -n 1 > ${WD}/${s}/${site}/Tha_GordonROIs_corrvec

			3dNetCorr -prefix ${WD}/${s}/${site}/netcorr_tha_corticalTargets \
			-in_rois ${WD}/ROIs/Cortical_targets_plus_Tha.nii.gz \
			-inset /tmp/${s}_${site}/func_concat.nii.gz
			cat ${WD}/${s}/${site}/netcorr_tha_corticalTargets_000.netcc | tail -n 1 > ${WD}/${s}/${site}/Tha_corticalTargets_corrvec

			3dNetCorr -prefix ${WD}/${s}/${site}/netcorr_corticalTargets \
			-in_rois ${WD}/ROIs/Cortical_Targets_Gordon.nii.gz \
			-inset /tmp/${s}_${site}/func_concat.nii.gz
			cat ${WD}/${s}/${site}/netcorr_corticalTargets_000.netcc | tail -n 32 > ${WD}/${s}/${site}/CorticalTargets_corrmat

			3dmaskave -mask ${WD}/ROIs/Consensus_communities.nii \
			-mrange 0.9 1.1 \
			-q \
			/tmp/${s}_${site}/func_concat.nii.gz > ${WD}/${s}/${site}/DF.1D

			3dmaskave -mask ${WD}/ROIs/Consensus_communities.nii \
			-mrange 5.9 6.1 \
			-q \
			/tmp/${s}_${site}/func_concat.nii.gz > ${WD}/${s}/${site}/FP.1D

			3dmaskave -mask ${WD}/ROIs/Consensus_communities.nii \
			-mrange 3.9 4.1 \
			-q \
			/tmp/${s}_${site}/func_concat.nii.gz > ${WD}/${s}/${site}/CO.1D

			echo "${WD}/${s}/${site}/DF.1D ${WD}/${s}/${site}/FP.1D ${WD}/${s}/${site}/DF-FP.1D 10" | python ${MTD}/run_MTD.py
			echo "${WD}/${s}/${site}/DF.1D ${WD}/${s}/${site}/CO.1D ${WD}/${s}/${site}/DF-CO.1D 10" | python ${MTD}/run_MTD.py

			rm -rf /tmp/${s}_{site}
		fi
	done
done