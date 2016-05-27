import numpy as np
import matplotlib.pyplot as plt

goal = 100
gamma = 1

ph = 0.4

pi = np.zeros(99)
value = np.zeros(101)
value[100] = 1

def bellman(s, a, ph, value):
	v = ph*value[min(s+a, 100)] + (1-ph)*value[max(0, s-a)]
	return v

while True:
	delta = 0
	for i in xrange(1, len(value)-1):
		temp = value[i]
		MAX = 0
		for j in xrange(1, min(100-i, i)+1):
			t = bellman(i, j, ph, value)
			if MAX < t:
				MAX = t
		value[i] = MAX
		delta = max(delta, abs(value[i]-temp))
	# plt.figure()
	# plt.plot(value)
	# plt.show()
	# raw_input("enter")
	if delta < 1e-30:
		break

bestval = -1000000
for i in xrange(1, len(pi)+1):
	for j in xrange(1, min(100-i, i)+1):
		temp = bellman(i, j, ph, value)
		# assume that we have to beat an earlier policy
		# by at least 1e-10, this seems to encourage plays with
		# the smallest bets(copy from the matlab version)
		if bestval < temp-1e-10:
			bestval = temp
			pi[i-1] = j

print pi
plt.figure()
plt.plot(value)


plt.figure()
plt.plot(pi)
plt.show()