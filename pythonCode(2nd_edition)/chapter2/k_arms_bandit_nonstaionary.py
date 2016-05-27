import numpy as np
import matplotlib.pyplot as plt

arms = 10
seed = np.random.randint(0, 100)
# max = 2.24
variance = 1
mean = np.zeros(10)
Q_table = np.zeros(10)
Q_steps = np.zeros(10)

total_steps = 20000
avg_reward = 0.0
step = 0

def walk_mean(mean):
	for i in xrange(len(mean)):
		if np.random.random() > 0.5:
			mean[i] += 1
		else:
			mean[i] -= 1
	return mean

def greedy_update(avg_reward, step, Q_table, mean):
	mean = walk_mean(mean)
	choice = np.argmax(Q_table)
	step += 1
	reward = np.random.normal(mean[choice], variance)
	avg_reward += (reward-avg_reward)/step
	Q_steps[choice] += 1
	Q_table[choice] += (reward-Q_table[choice])/Q_steps[choice]
	return avg_reward, step, Q_table, mean

def fix_greedy_update(avg_reward, step, Q_table, mean):
	mean = walk_mean(mean)
	choice = np.argmax(Q_table)
	step += 1
	reward = np.random.normal(mean[choice], variance)
	avg_reward += (reward-avg_reward)/step
	Q_table[choice] += (reward-Q_table[choice])/10
	return avg_reward, step, Q_table, mean

def e_greedy_update(avg_reward, step, Q_table, p, mean):
	flag = np.random.random()
	if flag <= p:
		mean = walk_mean(mean)
		choice = np.random.randint(0, 10)
		step += 1
		reward = np.random.normal(mean[choice], variance)
		avg_reward += (reward-avg_reward)/step
		Q_steps[choice] += 1
		Q_table[choice] += (reward-Q_table[choice])/Q_steps[choice]
	else:
		avg_reward, step, Q_table, mean = greedy_update(avg_reward, step, Q_table, mean)
	return avg_reward, step, Q_table, mean

def fix_e_greedy_update(avg_reward, step, Q_table, p, mean):
	flag = np.random.random()
	if flag <= p:
		mean = walk_mean(mean)
		choice = np.random.randint(0, 10)
		step += 1
		reward = np.random.normal(mean[choice], variance)
		avg_reward += (reward-avg_reward)/step
		Q_table[choice] += (reward-Q_table[choice])/10
	else:
		avg_reward, step, Q_table, mean = fix_greedy_update(avg_reward, step, Q_table, mean)
	return avg_reward, step, Q_table, mean

# e-greedy with e=0.1
np.random.seed(seed)
r = []
for i in xrange(total_steps):
	avg_reward, step, Q_table, mean = e_greedy_update(avg_reward, step, Q_table, 0.1, mean)
	r.append(avg_reward)
print Q_table
print Q_steps
one, = plt.plot(r, label='e_greedy_0.1')

# e-greedy with e=0.1
Q_table = np.zeros(10)
Q_steps = np.zeros(10)
mean = np.zeros(10)
avg_reward = 0.0
step = 0
np.random.seed(seed)
r = []
for i in xrange(total_steps):
	avg_reward, step, Q_table, mean = fix_e_greedy_update(avg_reward, step, Q_table, 0.1, mean)
	r.append(avg_reward)
print Q_table
print Q_steps
two, = plt.plot(r, label='fix_e_greedy_0.1')


plt.legend(handles=[one, two])

plt.show()