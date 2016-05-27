import numpy as np
import math

def pdf(int lamb, int k):
	return (lamb**k)*math.exp(-lamb)/(math.factorial(k))

cdef int max_car = 20
# look up table
cdef double[:] rent1 = np.zeros(max_car+1)
cdef double[:] return1 = np.zeros(max_car+1)
cdef double[:] rent2 = np.zeros(max_car+1)
cdef double[:] return2 = np.zeros(max_car+1)
cdef int i

cdef int rental1 = 3
cdef int rental2 = 4
cdef int return_1 = 3
cdef int return_2 = 2

for i in xrange(max_car+1):
	rent1[i] = pdf(rental1, i)
for i in xrange(max_car+1):
	return1[i] = pdf(return_1, i)
for i in xrange(max_car+1):
	rent2[i] = pdf(rental2, i)
for i in xrange(max_car+1):
	return2[i] = pdf(return_2, i)



def car_and_reward(int first, int second, int action, double[:,:] V):
	first -= action
	second += action
	if first*second<0:
		return 0
	cdef double r = 0.0
	cdef int q, w, e, t
	cdef int reward = 10
	cdef int move_cost = 2
	cdef double gamma = 0.9
	cdef int next_fir, next_sec
	cdef int rented1, rented2
	cdef int temp_reward
	for q in xrange(max_car+1):
		for w in xrange(max_car+1):
			for e in xrange(max_car+1):
				for t in xrange(max_car+1):
					rented1 = min(q, first)
					rented2 = min(w, second)
					temp_reward = (rented1+rented2)*reward - abs(action)*move_cost
					# print temp_reward
					next_fir = min(first - rented1 + e, max_car)
					next_sec = min(second - rented2 + t, max_car)
					r += rent1[q]*rent2[w]*return1[e]*return2[t]*(temp_reward+gamma*V[next_fir, next_sec])
					# print temp
	# print r
	return r