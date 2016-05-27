import numpy as np
import matplotlib.pyplot as plt

arms = 10
# np.random.seed(0)
# max = 2.24
variance = 1
mean = np.random.normal(0, variance, arms)
print mean
Q_table = np.ones(10)*5
Q_steps = np.zeros(10)

total_steps = 10000
avg_reward = 0.0
step = 0

def greedy_update(avg_reward, step, Q_table):
	choice = np.argmax(Q_table)
	step += 1
	reward = np.random.normal(mean[choice], variance)
	avg_reward += (reward-avg_reward)/step
	Q_steps[choice] += 1
	Q_table[choice] += (reward-Q_table[choice])/Q_steps[choice]
	return avg_reward, step, Q_table

def e_greedy_update(avg_reward, step, Q_table, p):
	flag = np.random.random()
	if flag <= p:
		choice = np.random.randint(0, 10)
		step += 1
		reward = np.random.normal(mean[choice], variance)
		avg_reward += (reward-avg_reward)/step
		Q_steps[choice] += 1
		Q_table[choice] += (reward-Q_table[choice])/Q_steps[choice]
	else:
		avg_reward, step, Q_table = greedy_update(avg_reward, step, Q_table)
	return avg_reward, step, Q_table
# greedy
np.random.seed(0) 
r = []
for i in xrange(total_steps):
	avg_reward, step, Q_table = greedy_update(avg_reward, step, Q_table)
	r.append(avg_reward)
print Q_table
print Q_steps
one, = plt.plot(r, label='greedy')

# e-greedy with e=0.1
Q_table = np.zeros(10)
Q_steps = np.zeros(10)

avg_reward = 0.0
step = 0
np.random.seed(0) 
r = []
for i in xrange(total_steps):
	avg_reward, step, Q_table = e_greedy_update(avg_reward, step, Q_table, 0.1)
	r.append(avg_reward)
print Q_table
print Q_steps
two, = plt.plot(r, label='e_greedy_0.1')

# e-greedy with e=0.01
Q_table = np.zeros(10)
Q_steps = np.zeros(10)

avg_reward = 0.0
step = 0
np.random.seed(0) 
r = []
for i in xrange(total_steps):
	avg_reward, step, Q_table = e_greedy_update(avg_reward, step, Q_table, 0.01)
	r.append(avg_reward)
print Q_table
print Q_steps
three, = plt.plot(r, label='e_greedy_0.01')

plt.legend(handles=[one, two, three])

plt.show()