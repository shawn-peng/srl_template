#!/bin/bash

. conf

rm test/results_${SUFFIX}_merged.txt
rm cv_res_${SUFFIX}.txt

for i in `seq 0 $((NFOLDS-1))`;
do
	echo fold $i
	python3 split_train_test.py $NFOLDS $i
	java -jar BoostSRL.jar -l -train train/ -model train/model_${SUFFIX} -modelSuffix ${SUFFIX}_${i} -target $TARGETS -trees $NUMTREES > log/train${SUFFIX}_${i}.log 2>&1
	java -jar BoostSRL.jar -i -test test/ -model train/model_${SUFFIX} -modelSuffix ${SUFFIX}_${i} -target $TARGETS -trees $NUMTREES > log/test${SUFFIX}_${i}.log 2>&1
	res=`tail log/test${SUFFIX}_${i}.log | grep "AUC ROC"`
	#echo $res
	auc=`echo $res | sed -e "s/.*AUC ROC = \([0-9.]*\)/\1/"`
	echo $auc
	echo fold $i >> cv_res_${SUFFIX}.txt
	tail -n 8 log/test${SUFFIX}_${i}.log | head -n 6 >> cv_res_${SUFFIX}.txt
	echo >> cv_res_${SUFFIX}.txt

	for t in $TARGETS;
	do
		cat test/results_${SUFFIX}_${i}_${t}.db >> test/results_${SUFFIX}_merged_${t}.txt
	done
done

resdir=results/${SUFFIX}
mkdir -p $resdir
cp cv_res_${SUFFIX}.txt ${resdir}/cv_res.txt
for t in $TARGETS;
do
	python3 convert_results.py test/results_${SUFFIX}_merged_${t}.txt ${resdir}/pred_${t}.txt
done

cp -r train/model_${SUFFIX}/bRDN/Trees train/model_${SUFFIX}/bRDN/dotFiles $resdir

