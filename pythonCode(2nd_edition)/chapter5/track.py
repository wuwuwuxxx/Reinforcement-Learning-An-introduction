import numpy as np

def track():
	t = np.zeros((39, 25))
	t[3, 6:12] = 2
	t[4:6, 6:12] = 1
	t[6:13, 5:12] = 1
	t[13:21, 4:12] = 1
	t[21:28, 3:12] = 1
	t[28, 3:13] = 1
	t[29:31, 3:19] = 1
	t[31, 4:19] = 1
	t[32:34, 5:19] = 1
	t[34, 6:19] = 1
	t[29:35, 19] = 3
	t[29:35, 20:25] = 4
	return t

if __name__ == '__main__':
	import matplotlib.pyplot as plt
	from matplotlib import cm
	plt.figure()
	plt.imshow(np.flipud(track()), interpolation='none')
	plt.show()