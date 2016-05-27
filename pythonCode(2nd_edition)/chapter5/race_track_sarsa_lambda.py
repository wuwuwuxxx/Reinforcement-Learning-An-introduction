"""
Solving race track using Sarsa(\lambda), it seems like hard to find the exact optimal policy.
A lot of iteration are needed.
"""
from track import track
import numpy as np
import matplotlib.pyplot as plt
import time
from race_track_fun import generate_start_state, generate_reward_and_next_state, generate_action, game_over

race_track = track()
height, width = race_track.shape
n_vv = 5 # vertical velocity change from 0 to 4
n_vh = 5 # horizontal velocity change from 0 to 4
actions = 5 # in fact, only five actions are valid(suppose V can only be up or right for simplicity)
Q = np.zeros((height, width, n_vv, n_vh, actions))

gamma = 1
alpha = 0.2
lamb = 0.7
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
    E = np.zeros((height, width, n_vv, n_vh, actions))
    row, col, vv, vh = generate_start_state()
    action = generate_action(policy[row, col, vv, vh], eps)
    while True:
        reward, new_row, new_col, new_vv, new_vh = generate_reward_and_next_state(row, col, vv, vh, action, race_track)
        new_action = generate_action(policy[new_row, new_col, new_vv, new_vh], eps)
        delta = reward + gamma*Q[new_row, new_col, new_vv, new_vh, new_action] - Q[row, col, vv, vh, action]
        E[row, col, vv, vh, action] = (1-alpha)*E[row, col, vv, vh, action]+1
        Q = Q + alpha*delta*E
        E = E*alpha*lamb
        policy = np.argmax(Q, axis=4)
        row, col, vv, vh, action = new_row, new_col, new_vv, new_vh, new_action
        if game_over(row, col, race_track):
            break

print time.time()-start

for k in xrange(6, 12):
    race_track = track()
    been = run(k)
    for state in been:
        race_track[state] = 5
    plt.figure()
    plt.imshow(np.flipud(race_track), interpolation='none')
plt.show()