#!/bin/bash

. conf

java -jar BoostSRL.jar -l -combine -train train/ -model train/model_${SUFFIX} -modelSuffix $SUFFIX -target $TARGETS -trees $NUMTREES > log/train${SUFFIX}.log 2>&1 &
#java -jar BoostSRL.jar -l -combine -train train/ -target iris_setosa -trees 10 > log/train.log 2>&1 &
#java -jar BoostSRL.jar -l -combine -train train/ -target autism_gene -trees 3 > log/train.log 2>&1 &

