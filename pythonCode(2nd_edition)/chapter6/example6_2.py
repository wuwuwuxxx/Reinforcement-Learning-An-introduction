import numpy as np
import matplotlib.pyplot as plt

"""
a implementation like example 6.3 is nicer.(but I'll leave it as it is.)
"""

Q_mc = np.ones(5)*0.5
Q_td = np.ones(5)*0.5
gt = np.array([1.0/6, 2.0/6, 3.0/6, 4.0/6, 5.0/6])
alpha = 0.001

def take_random_walk(p):
	if np.random.random() > 0.5:
		return p+1
	return p-1

def generate_episode_mc():
	pos = 2
	seen = []
	while True:
		seen.append(pos)
		pos = take_random_walk(pos)
		if pos==-1:
			return 0, seen
		elif pos==5:
			return 1, seen

def rms_error(q, gt):
	return np.sqrt(np.mean(np.square(q-gt)))

# MC
np.random.seed(1)
error_mc = []
for i in xrange(10000):
	r, state_seen = generate_episode_mc()
	for state in state_seen:
		Q_mc[state] += alpha*(r-Q_mc[state])
	error_mc.append(rms_error(Q_mc, gt))

# TD(0)
np.random.seed(1)
error_td = []
for i in xrange(10000):
	old = 2
	while True:
		new = take_random_walk(old)
		r = 0
		if new == 5:
			Q_td[old] += alpha*(1-Q_td[old])
		elif new == -1:
			Q_td[old] += alpha*(0-Q_td[old])
		else:
			Q_td[old] += alpha*(Q_td[new]-Q_td[old])
		old = new
		if old==-1 or old==5:
			break
	error_td.append(rms_error(Q_td, gt))

plt.figure()
q_mc, = plt.plot(Q_mc, label='MC')
q_td, = plt.plot(Q_td, label='TD')
gt, = plt.plot(gt, label='GT')
plt.legend(handles=[q_mc, q_td, gt])
plt.figure()
emc, = plt.plot(error_mc, label='MC')
etd, = plt.plot(error_td, label='TD')
plt.legend(handles=[emc, etd])
plt.show()