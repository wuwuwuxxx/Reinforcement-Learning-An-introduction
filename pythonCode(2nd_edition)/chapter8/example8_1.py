"""
solving maze using Dyna-Q
"""
import numpy as np
from maze import init_maze
import matplotlib.pyplot as plt
import time

# (2, 0) start
# (0, 8) goal

maze = init_maze()
h, w = maze.shape
actions = 4
Q = np.random.random((h, w, actions))
eps = 0.1
gamma = 0.95
alpha = 0.5
# plan steps
n = 50
policy = np.argmax(Q, axis=2)
seen = {}

def generate_action(a, eps):
	if np.random.random()<eps:
		return np.random.randint(4)
	return a

def take_action(r, c, a, m):
	if a==0:
		row = max(r-1, 0)
		col = c
	elif a==1:
		col = max(c-1, 0)
		row = r
	elif a==2:
		row = min(r+1, 5)
		col = c
	elif a==3:
		col = min(c+1, 8)
		row = r
	if m[row, col]==1:
		return 0, r, c
	elif row==0 and col==8:
		return 1, row, col
	return 0, row, col

def plan(seen, Q, n, alpha, gamma):
	keys = seen.keys()
	for k in xrange(n):
		key = keys[np.random.randint(len(keys))]
		re, row, col = seen[key]
		Q[key] += alpha*(re+gamma*np.amax(Q[row, col, :])-Q[key])
	return Q

start = time.time()
for k in xrange(5):
	row = 2
	col = 0
	while True:
		action = generate_action(policy[row, col], eps)
		reward, new_row, new_col = take_action(row, col, action, maze)
		Q[row, col, action] += alpha*(reward+gamma*np.amax(Q[new_row, new_col, :])-Q[row, col, action])
		seen[(row, col, action)] = (reward, new_row, new_col)
		if len(seen)>n:
			Q = plan(seen, Q, n, alpha, gamma)
		policy[row, col] = np.argmax(Q[row, col, :])
		if reward==1:
			break
		row, col = new_row, new_col
print time.time()-start

row = 2
col = 0
for k in xrange(5):
	step = k
	maze[row, col] = 2
	reward, new_row, new_col = take_action(row, col, policy[row, col], maze)
	if reward==1:
		maze[new_row, new_col] = 2
		break
	row, col = new_row, new_col
print step

plt.imshow(maze, interpolation='none')
plt.show()