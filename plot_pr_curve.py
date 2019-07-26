from sklearn.metrics import precision_recall_curve
from sklearn.metrics import roc_curve, auc

import matplotlib.pyplot as plt
import csv
import sys
import numpy as np

resfile = sys.argv[1]
#res = csv.reader(resfile)
#res = np.loadtxt('pred_results.txt', delimiter='\t')
res = np.loadtxt(resfile, delimiter='\t')

y_test = res[:,0]
y_score = res[:,1]
#precision, recall, _ = precision_recall_curve(y_test, y_score)

fpr, tpr, _ = roc_curve(y_test, y_score)
lw = 2
#plt.step(recall, precision, color='b', alpha=0.2, where='post')
plt.plot(fpr, tpr, color='darkorange',
         lw=lw, label='ROC curve')
plt.show()
