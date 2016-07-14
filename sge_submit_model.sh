#!/bin/bash

#for SGE jobs

#mkdir tmp;
#WD='/home/despoB/kaihwang/Rest/NKI/'
SCRIPTS='/home/despoB/kaihwang/bin/TMSTha'
WD='/home/despoB/kaihwang/Rest/TMS_Thalamus/'

cd ${WD}

for Subject in 606 607 608 609 610 611 612; do

	# if [ ! -e ${WD}/${Subject}/gPPI_PPA_Full_model_stats_REMLvar+tlrc.HEAD ]; then
	# 	sed "s/s in 503/s in ${Subject}/g" < ${SCRIPTS}/run_PPI_model.sh> ~/tmp/PPI_${Subject}.sh
	# 	qsub -l mem_free=5G -V -M kaihwang -m e -e ~/tmp -o ~/tmp ~/tmp/PPI_${Subject}.sh
	# fi	

	#if [ ! -e ${WD}/${Subject}/${Subject}_FIR_FH_errts.nii.gz ]; then
	# sed "s/s in 503/s in ${Subject}/g" < ${SCRIPTS}/run_sc_motor_model.sh> ~/tmp/rsmm_${Subject}.sh
	# qsub -l mem_free=5G -V -M kaihwang -m e -e ~/tmp -o ~/tmp ~/tmp/rsmm_${Subject}.sh

	#sed "s/s in 0102826_session_1/s in ${Subject}/g" < ${SCRIPTS}/Do_MTD_between_network.sh > ~/tmp/doMTD${Subject}.sh
	#qsub -l mem_free=7G -V -M kaihwang -m e -e ~/tmp -o ~/tmp ~/tmp/doMTD${Subject}.sh

	sed "s/s in 606/s in ${Subject}/g" < ${SCRIPTS}/cal_tha_cor_ROIs_convec.sh > ~/tmp/doMTD${Subject}.sh
	qsub -l mem_free=10G -V -M kaihwang -m e -e ~/tmp -o ~/tmp ~/tmp/doMTD${Subject}.sh
	#fi	
done
