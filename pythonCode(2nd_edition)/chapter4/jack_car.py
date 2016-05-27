import numpy as np
from mpl_toolkits.mplot3d import Axes3D
import matplotlib.pyplot as plt
from matplotlib import cm
import math
from update import car_and_reward
import time

# about 10 mins
start = time.time()

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



def policy_eval():
	while True:
		delta = 0
		for i in xrange(max_car+1):
			for j in xrange(max_car+1):
				temp = V[i, j]
				V[i, j] = car_and_reward(i, j, pi[i, j], V)
				delta = max(delta, abs(temp-V[i, j]))
		if delta < 1e-9:
			break

def policy_improv():
	policy_stable = True
	for i in xrange(max_car+1):
		for j in xrange(max_car+1):
			temp = pi[i, j]
			rewardlist = np.zeros(11)
			index = 0
			for k in xrange(-max_move, max_move+1):
				rewardlist[index] = car_and_reward(i, j, k, V)
				index += 1
			pi[i, j] = np.argmax(rewardlist)-5
			if temp != pi[i, j]:
				policy_stable = False
	return policy_stable

X = np.arange(0, max_car+1)
Y = np.arange(0, max_car+1)
X, Y = np.meshgrid(X, Y)
while True:
	policy_eval()
	policy_stable = policy_improv()
	if policy_stable:
		break
print time.time()-start

fig = plt.figure()
ax = fig.gca(projection='3d')
surf = ax.plot_surface(X, Y, V)

plt.figure()
plt.imshow(np.flipud(pi), interpolation='none')
plt.show()