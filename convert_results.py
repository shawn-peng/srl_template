#!/usr/bin/python

import re

resfile = 'test/results_ann.db'
resfile = open(resfile)

predfile = 'pred_results.txt'
predfile = open(predfile, 'w')

regex = re.compile('.*\((.*)\) ([0-9.]*)')

for res in resfile:
    args = regex.match(res).group(1)
    score = regex.match(res).group(2)
    score = float(score)
    flag = (res[0] == '!')
    if flag:
        #continue
        score = 1-score
    # print(protid, score)
    predfile.write("%d\t%f\n" % (not flag, score))




