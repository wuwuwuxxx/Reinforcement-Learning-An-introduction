"""
I think the race track program will perform better if
it's implemented using TD algorithm(after reading chapter
6 and 7). Currently it's using a MC method.

The best method I found is Q-learning. It's fast and the policy seems
to be optimal.
"""
from track import track
import numpy as np
import matplotlib.pyplot as plt
from matplotlib import cm
import time
from race_track_fun import generate_episode, generate_reward_and_next_state

race_track = track()
height, width = race_track.shape
n_vv = 5 # vertical velocity change from 0 to 4
n_vh = 5 # horizontal velocity change from 0 to 4
actions = 5 # in fact, only five actions are valid(suppose V can only be up or right for simplicity)
# Q = np.ones((height, width, n_vv, n_vh, actions))*-999999999 # use -inf
Q = np.zeros((height, width, n_vv, n_vh, actions))
returns = np.zeros((height, width, n_vv, n_vh, actions))
"""
actions:
0 means stay where you are or keep moving
1 means move up
2 means move left
3 means move down
4 means move right
"""
# policy derived from Q
policy = np.argmax(Q, axis=4)

def run(k):
    row, col, vv, vh = (3, k, 0, 0)
    seen = []
    step = 0
    while True:
        step += 1
        if step > 1000:
            break
        action = policy[row, col, vv, vh]
        seen.append((row, col))
        # print row, col, vv, vh
        r, row, col, vv, vh = generate_reward_and_next_state(row, col, vv, vh, action, race_track)
        if r == 0:
            break
    return seen

start = time.time()
eps = 0.1
for k in xrange(1000):
    # print eps, k
    state_seen, reward = generate_episode(policy, race_track, eps)
    for state in state_seen:
        returns[state] += 1
        Q[state] += (reward-Q[state])/returns[state]
    policy = np.argmax(Q, axis=4)
print time.time()-start

for k in xrange(6, 12):
    race_track = track()
    been = run(k)
    for state in been:
        race_track[state] = 5
    plt.figure()
    plt.imshow(np.flipud(race_track), interpolation='none')
plt.show()