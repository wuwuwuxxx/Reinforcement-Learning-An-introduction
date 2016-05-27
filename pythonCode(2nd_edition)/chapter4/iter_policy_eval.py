import numpy as np

V = np.zeros((5, 4))
row = 5
col = 4
reward = -1
gamma = 1

def value_eval(row, col, re, gamma, t):
	if row==4 and col ==1:
		return 0.25*(re+gamma*t[3, 0])+\
			0.25*(re+gamma*t[3, 1])+\
			0.25*(re+gamma*t[3, 2])+\
			0.25*(re+gamma*t[4, 1])
	# left
	r = row
	c = max(col - 1, 0)
	re_l = 0.25*(re+gamma*t[r, c])
	# right
	r = row
	c = min(col + 1, 3)
	re_r = 0.25*(re+gamma*t[r, c])
	# up
	r = max(row - 1, 0)
	c = col
	re_u = 0.25*(re+gamma*t[r, c])
	# down
	r = min(row + 1, 3)
	c = col
	re_d = 0.25*(re+gamma*t[r, c])
	return re_l+re_r+re_u+re_d

while True:
	delta = 0
	for i in xrange(row):
		for j in xrange(col):
			if i==0 and j==0:
				continue
			if i==3 and j==3:
				continue
			if i==4 and j!=1:
				continue
			temp = V[i, j]
			V[i, j] = value_eval(i, j, reward, gamma, V)
			delta = max(delta, abs(V[i, j]-temp))
	if delta < 0.001:
		break
print V