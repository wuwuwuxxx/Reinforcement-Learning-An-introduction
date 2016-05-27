# blackjack
import numpy as np
from mpl_toolkits.mplot3d import Axes3D
import matplotlib.pyplot as plt

value = np.zeros((10, 10, 2))
returns = {}
for i in xrange(10):
    for j in xrange(10):
        for k in xrange(2):
            returns[(i, j, k)] = []


def next_card():
    nums = np.array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10])
    return np.random.choice(nums)


def hand_value(cards):
    s = sum(cards)
    if np.any(cards) == 1 and s < 12:
        s += 10
        use = 1
    else:
        use = 0
    return s, use


def reward(ph, dh):
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


for k in xrange(500000):
    dealer_hand = []
    player_hand = []
    states_seen = []
    dealer_hand.append(next_card())
    dealer_hand.append(next_card())
    player_hand.append(next_card())
    player_hand.append(next_card())
    ph, useable = hand_value(player_hand)
    dh, _ = hand_value(dealer_hand)
    states_seen.append((dealer_hand[0], ph, useable))
    if ph == 21 and dh == 21:
        reward_value = 0
    elif ph == 21 and dh != 21:
        reward_value = 1
    else:
        while ph < 20:
            player_hand.append(next_card())
            ph, useable = hand_value(player_hand)
            states_seen.append((dealer_hand[0], ph, useable))
        while dh < 17:
            dealer_hand.append(next_card())
            dh, _ = hand_value(dealer_hand)
    reward_value = reward(ph, dh)
    for state in states_seen:
        if state[1] < 12 or state[1] > 21:
            continue
        else:
            returns[(state[0]-1, state[1]-12, state[2])].append(reward_value)

for i in xrange(10):
    for j in xrange(10):
        for k in xrange(2):
            value[i, j, k] = np.mean(returns[(i, j, k)])

Y = np.arange(1, 11)
X = np.arange(12, 22)
X, Y = np.meshgrid(X, Y)
fig = plt.figure()
ax = fig.gca(projection='3d')
surf = ax.plot_surface(X, Y, value[:, :, 0]) # no useable ace
fig = plt.figure()
ax = fig.gca(projection='3d')
surf = ax.plot_surface(X, Y, value[:, :, 1]) # useable ace
plt.show()