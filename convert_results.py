#!/usr/bin/python

import re

resfile = 'test/results_autism_gene.db'
resfile = open(resfile)

predfile = 'pred_results.txt'
predfile = open(predfile, 'w')

regex = re.compile('.*\((.*)\)')

for res in resfile:
	row = res.split()
	flag = (row[0][0] == '!')
	value = float(row[1])

	if flag:
		#continue
		score = 1-value
	else:
		score = value
	
	protid = regex.match(row[0]).group(1)
	# print(protid, score)
	predfile.write("%s\t%f\n" % (protid, score))




