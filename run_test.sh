#!/bin/bash

. conf

java -jar BoostSRL.jar -i -test test/ -model train/model_${SUFFIX} -target $TARGETS -trees $NUMTREES -modelSuffix $SUFFIX > log/test${SUFFIX}.log 2>&1 &

