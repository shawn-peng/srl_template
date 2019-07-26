#!/bin/bash

SCRITPS="conf.sample convert_results.py perform_cv.sh run_test.sh split_train_test.py start_train.sh utils.py"

for f in $SCRITPS;
do
	echo $f
	cp ../template/$f ./
done

