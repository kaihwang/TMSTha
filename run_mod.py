import numpy as np
import bct as BCT
import sys



fn = raw_input()

print(fn)

M = np.loadtxt(fn)

Q_vec = np.zeros(len(np.arange(0.02, 0.21, 0.01)))

for i, th in enumerate(np.arange(0.02, 0.21, 0.01)):
    Q_vec[i] = BCT.modularity_und(BCT.threshold_proportional(M, th))[1]

Q = Q_vec.mean()

print(Q)