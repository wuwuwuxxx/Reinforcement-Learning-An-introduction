import numpy as np
import matplotlib.pyplot as plt

Q_mc = np.ones(7)*0.5
Q_mc[0] = 0
Q_mc[6] = 1
Q_td = np.ones(7)*0.5
Q_td[0] = 0
Q_td[6] = 1
gt = np.array([0, 1.0/6, 2.0/6, 3.0/6, 4.0/6, 5.0/6, 1])
alpha = 0.01

def take_random_walk(p):
	if np.random.random() > 0.5:
		return p+1
	return p-1

def generate_episode():
	pos = 3
	seen = []
	seen.append(pos)
	while True:
		pos = take_random_walk(pos)
		seen.append(pos)
		if pos==0:
			return 0, seen
		elif pos==6:
			return 1, seen

def rms_error(q, gt):
	return np.sqrt(np.mean(np.square(q-gt)))

episode = []
err_mc = []
err_td = []
for i in xrange(1000):
	r, state_seen = generate_episode()
	episode.append((r, state_seen))
	for reward, epi in episode:
		for k, state in enumerate(epi):
			if state==0 or state==6:
				continue
			Q_mc[state] += alpha*(reward-Q_mc[state])
			Q_td[state] += alpha*(Q_td[epi[k+1]] - Q_td[state])
	err_mc.append(rms_error(Q_mc, gt))
	err_td.append(rms_error(Q_td, gt))

plt.figure()
q_mc, = plt.plot(Q_mc, label='MC')
q_td, = plt.plot(Q_td, label='TD')
gt, = plt.plot(gt, label='GT')
plt.legend(handles=[q_mc, q_td, gt])
plt.figure()
emc, = plt.plot(err_mc, label='MC')
etd, = plt.plot(err_td, label='TD')
plt.legend(handles=[emc, etd])
plt.show()