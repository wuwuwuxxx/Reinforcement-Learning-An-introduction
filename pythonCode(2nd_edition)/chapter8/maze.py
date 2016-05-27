import numpy as np

def init_maze():
	maze = np.zeros((6, 9))
	maze[1:4, 2] = 1
	maze[4, 5] = 1
	maze[0:3, 7] = 1
	return maze

if __name__ == '__main__':
	import matplotlib.pyplot as plt
	plt.imshow(init_maze(), interpolation='none')
	plt.show()