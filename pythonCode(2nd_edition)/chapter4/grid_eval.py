"""
solve the grid problem in chapter 4 using value iteration
"""
import numpy as np

State = np.zeros((4,4))
reward = -1
gamma = 1
V = np.zeros((4, 4))

def value_eval(row, col, re, gamma, t):
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
	return max(re_l, re_r, re_u, re_d)

while True:
	delta = 0
	temp = V.copy()
	for row in range(4):
		for col in range(4):
			if row==0 and col==0:
				continue
			if row==3 and col==3:
				continue
			raw_v = temp[row, col]
			V[row, col] = value_eval(row, col, reward, gamma, temp)
			delta = max(delta, abs(raw_v-V[row,col]))
	print V
	if delta < 0.001:
		break
	raw_input("enter")

# output is a value map, you can get a deterministic policy(pi) from the final map.