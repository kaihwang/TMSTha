#!/bin/bash
# script for group analysis of MTD regression. using 3dMEMA taking within subject GLT to group level


for contrast in MTD_DF-CO MTD_DF-FP; do
	echo "cd /home/despoB/kaihwang/Rest/NKI/
	3dMEMA -prefix /home/despoB/kaihwang/Rest/TMS_Thalamus/Group/NKI_${contrast}_groupMEMA \\
	-set ${contrast} \\" > /home/despoB/kaihwang/Rest/TMS_Thalamus/Group/${contrast}.sh

	cd /home/despoB/kaihwang/Rest/NKI/


	for s in $(/bin/ls -d *); do
		echo "${s} /home/despoB/kaihwang/Rest/NKI/${s}/MNINonLinear/${contrast}_stats_REML+orig[6] /home/despoB/kaihwang/Rest/NKI/${s}/MNINonLinear/${contrast}_stats_REML+orig[7] \\" >> /home/despoB/kaihwang/Rest/TMS_Thalamus/Group/${contrast}.sh
	done

	echo "-Rio -mask /home/despoB/kaihwang/Rest/TMS_Thalamus/Group/mask_rs+orig" >> /home/despoB/kaihwang/Rest/TMS_Thalamus/Group/${contrast}.sh

	#qsub -l mem_free=3G -V -M kaihwang -m e -e ~/tmp -o ~/tmp /home/despoB/kaihwang/Rest/TMS_Thalamus/Group/${contrast}.sh
	. /home/despoB/kaihwang/Rest/TMS_Thalamus/Group/${contrast}.sh

	3drefit -view tlrc /home/despoB/kaihwang/Rest/TMS_Thalamus/Group/NKI_${contrast}_groupMEMA+orig

done






