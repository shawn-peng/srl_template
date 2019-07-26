#!/bin/bash

. conf

rm test/results_${SUFFIX}_merged.txt
rm cv_res_${SUFFIX}.txt

for i in `seq 0 $((NFOLDS-1))`;
do
	echo fold $i
	python3 split_train_test.py $NFOLDS $i
	# java -jar BoostSRL.jar -l -combine -train train/ -target ann -trees 10 > log/train.log 2>&1
	java -jar BoostSRL.jar -l -train train/ -model train/model_${SUFFIX} -modelSuffix ${SUFFIX}_${i} -target $TARGETS -trees $NUMTREES > log/train${SUFFIX}_${i}.log 2>&1
	java -jar BoostSRL.jar -i -test test/ -model train/model_${SUFFIX} -modelSuffix ${SUFFIX}_${i} -target $TARGETS -trees $NUMTREES > log/test${SUFFIX}_${i}.log 2>&1
	res=`cat log/test${SUFFIX}_${i}.log | grep "AUC ROC"`
	#echo $res
	auc=`echo $res | sed -e "s/.*AUC ROC = \([0-9.]*\)/\1/"`
	echo $auc
	tail -n 7 log/test${SUFFIX}_${i}.log >> cv_res_${SUFFIX}.txt
	cat test/results_${SUFFIX}_${i}_gdb.db >> test/results_${SUFFIX}_merged.txt
done
