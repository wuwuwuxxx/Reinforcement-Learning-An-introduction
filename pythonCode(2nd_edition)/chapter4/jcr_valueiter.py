"""
solving jack's car with value iteration(
is much slower than policy iteration,
at least in jack's car example.)
"""
import numpy as np
from mpl_toolkits.mplot3d import Axes3D
import matplotlib.pyplot as plt
from matplotlib import cm
import math
from update import car_and_reward

max_car = 20
V = np.zeros((max_car+1, max_car+1))
pi = np.zeros((max_car+1, max_car+1))

rental1 = 3
rental2 = 4
return_1 = 3
return_2 = 2
gamma = 0.9
reward = 10
move_cost = 2
max_move = 5



def policy_iter():
	while True:
		delta = 0
		for i in xrange(max_car+1):
			for j in xrange(max_car+1):
				# print i,j
				temp = V[i, j]
				rewardlist = np.zeros(11)
				index = 0
				for k in xrange(-max_move, max_move+1):
					rewardlist[index] = car_and_reward(i, j, k, V)
					index += 1
				V[i, j] = np.amax(rewardlist)
				delta = max(delta, abs(temp-V[i, j]))
		if delta < 1e-9:
			break

def generate_policy():
	policy_stable = True
	for i in xrange(max_car+1):
		for j in xrange(max_car+1):
			rewardlist = np.zeros(11)
			index = 0
			for k in xrange(-max_move, max_move+1):
				rewardlist[index] = car_and_reward(i, j, k, V)
				index += 1
			pi[i, j] = np.argmax(rewardlist)-5
X = np.arange(0, max_car+1)
Y = np.arange(0, max_car+1)
X, Y = np.meshgrid(X, Y)

policy_iter()
generate_policy()

fig = plt.figure()
ax = fig.gca(projection='3d')
surf = ax.plot_surface(X, Y, V)

plt.figure()
plt.imshow(np.flipud(pi), interpolation='none')
plt.show()