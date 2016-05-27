import numpy as np

def pro_action(int action):
    # \eps = 0.01
    if np.random.random() < 0.01:
        return np.random.randint(0, 2)
    return action

def next_card():
    nums = np.array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10])
    return np.random.choice(nums)

def hand_value(cards):
    cdef int s, use
    s = sum(cards)
    if np.any(cards) == 1 and s < 12:
        s += 10
        use = 1
    else:
        use = 0
    return s, use

def reward(int ph, int dh):
    if ph > 21:
        return -1
    elif dh > 21:
        return 1
    elif ph > dh:
        return 1
    elif ph < dh:
        return -1
    else:
        return 0