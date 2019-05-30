#!/bin/bash

. conf

java -jar BoostSRL.jar -i -model train/models -test test/ -target $TARGETS -trees $NUMTREES

