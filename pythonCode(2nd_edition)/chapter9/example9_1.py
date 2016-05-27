import numpy as np
import matplotlib.pyplot as plt

narrow = 0.1
medium = 0.3
broad = 0.5

feas = 50
# interval can be narrow, medium, broad
interval = medium

def square_wave(x):
	"""
	0<x<1
	"""
	if 0<x<.33 or .66<x<1:
		return 0
	return 1

def binary_fea(x, interval, feas):
	"""
	0<x<1
	"""
	result = np.zeros(feas)
	l = 0
	h = interval
	interval = (1-interval)/(feas-1)
	index = 0
	while h<=1:
		if h<=x:
			l += interval
			h += interval
			index += 1
		elif l<=x<h:
			result[index] = 1
			l += interval
			h += interval
			index += 1
		elif l>x:
			break
	return result

theta = np.zeros(50)
for k in xrange(100000):
	x = np.random.random()
	g = square_wave(x)
	fea = binary_fea(x, interval, feas)
	if np.sum(fea)==0:
		continue
	alpha = 0.2/np.sum(fea)
	theta += alpha*(g - theta.dot(fea))*fea


x = np.linspace(0, 1, 100)
y = np.zeros(len(x))
for i in xrange(len(x)):
	y[i] = theta.dot(binary_fea(x[i], interval, feas))
plt.plot(x, y)
plt.show()