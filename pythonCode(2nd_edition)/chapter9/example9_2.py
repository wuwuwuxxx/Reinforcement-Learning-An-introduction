"""
-1.2<=p<=0.5
-0.07<=v<=0.07
use 10 $9\times9$ tilings
"""
import numpy as np
import math
from mpl_toolkits.mplot3d import Axes3D
import matplotlib.pyplot as plt


def init_state():
    return np.random.random()*1.7-1.2, np.random.random()*0.14-0.07


def get_fea_index(p, v, a, poff, voff, pinter, vinter, n):
    indices = np.zeros((10, 10, n, 3))
    for i in xrange(n):
        col = int((p + 1.2 + poff[i]) / pinter)
        row = int((v + 0.07 + voff[i]) / vinter)
        indices[row, col, i, a + 1] = 1
    return indices


def boundp(p):
    return min(max(-1.2, p), 0.5)


def boundv(v):
    return min(max(-0.07, v), 0.07)


def take_action(p, v, a):
    newv = boundv(v + 0.001 * a - 0.0025 * math.cos(3 * p))
    newp = boundp(p + v)
    if newp >= 0.5:
        return newp, newv, 0
    return newp, newv, -1


# def get_action(q):
#     action = np.argmax(q) - 1
#     if np.random.random() < 0.01:
#         k = np.random.randint(-1, 2)
#         return k, q[k + 1]
#     return action, q[action + 1]


p_interval = (0.5 + 1.2) / 9
v_interval = (0.14) / 9

tils = 10
lamb = 0.9
alpha = 0.05
gamma = 1
p_offsets = np.random.random(tils) * p_interval
v_offsets = np.random.random(tils) * v_interval
theta = np.zeros((10, 10, tils, 3))

for k in xrange(10000):
    print k
    e = np.zeros((10, 10, tils, 3))
    p, v = init_state()
    while True:
        temp_q = []
        indices = []
        for j in xrange(-1, 2):
            index = get_fea_index(p, v, j, p_offsets, v_offsets, p_interval, v_interval, tils)
            indices.append(index)
            temp_q.append(np.sum(theta*index))
        astar = np.argmax(temp_q)-1
        a = astar
        # if np.random.random()<0.05:
        #     a = np.random.randint(-1, 2)
        # if a != astar:
        #     e = 0
        newp, newv, reward = take_action(p, v, a)
        delta = reward - temp_q[a+1]
        e = indices[a+1]
        if reward == 0:
            theta += alpha * delta * e
            break
        temp_q = []
        for j in xrange(-1, 2):
            indices = get_fea_index(newp, newv, j, p_offsets, v_offsets, p_interval, v_interval, tils)
            temp_q.append(np.sum(indices * theta))
        delta += gamma * max(temp_q)
        theta += alpha * delta * e
        e *= gamma * lamb
        p = newp
        v = newv

steps = 200
postions = np.linspace(-1.2, 0.5, steps)
velocity = np.linspace(-0.07, 0.07, steps)
value = np.zeros((steps, steps))
for i in xrange(len(postions)):
    for j in xrange(len(velocity)):
        temp_q = []
        for k in xrange(-1, 2):
            indices = get_fea_index(postions[i],
                                    velocity[j], k, p_offsets, v_offsets, p_interval, v_interval, tils)
            temp_q.append(np.sum(indices * theta))
        value[i, j] = max(temp_q)
value = -value
X, Y = np.meshgrid(postions, velocity)
fig = plt.figure()
ax = fig.gca(projection='3d')
surf = ax.plot_surface(X, Y, value)
plt.show()
