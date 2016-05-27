"""
with 9 actions, however, it cannot be better.
"""
import numpy as np
import matplotlib.pyplot as plt
from matplotlib import cm
import time

start = time.time()
col = 10
row = 7
# world = np.zeros((row, col))
# world[3, 0] = 1
# world[3, 7] = 2
wind = np.zeros((row, col))
wind[:, 3:6] = 1
wind[:, 6:8] = 2
wind[:, 8] = 1

n_actions = 9
Q = np.zeros((row, col, n_actions))
policy = np.argmax(Q, axis=2)

alpha = 0.5
# gamma = 1


def choose_action(action, eps=0.1):
	if np.random.random()<eps:
		return np.random.randint(9)
	return action

def take_action(row, col, action, wind):
	row = max(row-wind[row,col], 0)
	if action==1:
		# up
		row = max(row-1, 0)
	elif action==2:
		# left
		col = max(col-1, 0)
	elif action==3:
		# down
		row = min(row+1, 6)
	elif action==0:
		# right
		col = min(col+1, 9)
	elif action==4:
		# EN
		col = min(col+1, 9)
		row = max(row-1, 0)
	elif action==5:
		# ES
		col = min(col+1, 9)
		row = min(row+1, 6)
	elif action==6:
		# WN
		col = max(col-1, 0)
		row = max(row-1, 0)
	elif action==7:
		# WS
		col = max(col-1, 0)
		row = min(row+1, 6)
	elif action==8:
		pass
	return row, col

for k in xrange(1000):
	# print k
	old_r = 3
	old_c = 0
	while True:
		action = choose_action(policy[old_r, old_c])
		new_r, new_c = take_action(old_r, old_c, action, wind)
		# Q-learning
		Q[old_r, old_c, action] = Q[old_r, old_c, action] + alpha*(-1+np.amax(Q[new_r, new_c, :])-Q[old_r, old_c, action])
		policy[old_r, old_c] = np.argmax(Q[old_r, old_c, :])
		old_r = new_r
		old_c = new_c
		if new_r==3 and new_c==7:
			break
		

print time.time()-start

path = np.zeros((row, col))
action = policy[3, 0]
old_r = 3
old_c = 0
path[3, 0] = 1
for x in xrange(100):
	print x+1
	new_r, new_c = take_action(old_r, old_c, action, wind)
	path[new_r, new_c] = 1
	if new_r==3 and new_c==7:
		break
	new_action = policy[new_r, new_c]
	old_r = new_r
	old_c = new_c
	action = new_action

plt.imshow(path, interpolation='none')
plt.show()