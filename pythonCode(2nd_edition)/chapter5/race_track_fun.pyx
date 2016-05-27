import numpy as np

def generate_start_state():
    return (3, np.random.randint(6, 12), 0, 0)

# \eps soft policy, \eps=0.1
def generate_action(int action, double eps):
    if np.random.random() < eps:
        return np.random.randint(5)
    return action

def game_over(int final_r, int final_c, double[:,:] rt):
    return rt[final_r, final_c]==4

def outside(int final_r, int final_c, double[:,:] rt):
    return rt[final_r, final_c]==0

def change_velocity(int vv, int vh, int action):
    if action==0:
        return vv, vh
    elif action==1:
        return min(4, vv+1), vh
    elif action==2:
        return vv, max(vh-1, 0)
    elif action==3:
        return max(0, vv-1), vh
    else:
        return vv, min(vh+1, 4)

def generate_reward_and_next_state(int row, int col, int vv, int vh, int action, double[:,:] rt):
    cdef int final_r, final_c
    final_r = row + vv
    final_c = col + vh
    if game_over(final_r, final_c, rt):
        return 0, final_r, final_c, 0, 0
    elif outside(final_r, final_c, rt):
        return -100, row, col, 0, 0
    vv, vh = change_velocity(vv, vh, action)
    return -1, final_r, final_c, vv, vh

def generate_episode(policy, race_track, double eps):
    cdef int row, col, vv, vh
    row, col, vv, vh = generate_start_state()
    seen = []
    cdef int epi_reward = 0
    cdef int action
    while True:
        action = generate_action(policy[row, col, vv, vh], eps)
        seen.append((row, col, vv, vh, action))
        # print row, col, vv, vh
        r, row, col, vv, vh = generate_reward_and_next_state(row, col, vv, vh, action, race_track)
        epi_reward += r
        if r == 0:
            break
    return seen, epi_reward