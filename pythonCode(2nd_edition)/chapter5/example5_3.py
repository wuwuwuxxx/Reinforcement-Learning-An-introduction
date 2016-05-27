import numpy as np
from mpl_toolkits.mplot3d import Axes3D
import matplotlib.pyplot as plt
from matplotlib import cm
from jk_function import next_card, hand_value, reward
import time

start = time.time()
Q = np.zeros((10, 10, 2, 2))
policy = np.zeros((10, 10, 2))
policy[:, 8:, :] = 1 # 1 means stick, 0 means hit
returns = np.zeros((10, 10, 2, 2))

# takes about 1.5 hour on my laptop
for k in xrange(100000000):
    dealer_hand = []
    player_hand = []
    states_seen = []
    dealer_hand.append(next_card())
    dealer_hand.append(next_card())
    player_hand.append(next_card())
    player_hand.append(next_card())
    ph, useable = hand_value(player_hand)
    dh, _ = hand_value(dealer_hand)
    while ph < 12:
        player_hand.append(next_card())
        ph, useable = hand_value(player_hand)
    state4 = np.random.randint(0, 2)
    states_seen.append((dealer_hand[0]-1, ph-12, useable, state4))
    # do state4
    while ph < 22:
        if state4 == 0:
            player_hand.append(next_card())
            ph, useable = hand_value(player_hand)
            if ph < 22:
                state4 = policy[dealer_hand[0]-1, ph-12, useable]
                states_seen.append((dealer_hand[0]-1, ph-12, useable, state4))
        else:
            break
    while dh < 17:
        dealer_hand.append(next_card())
        dh, _ = hand_value(dealer_hand)
    reward_value = reward(ph, dh)
    
    for state in states_seen:
        returns[state] += 1
        Q[state] += (reward_value-Q[state])/returns[state]
    policy = np.argmax(Q, axis=3)
print time.time()-start

plt.figure()
plt.imshow(np.flipud(policy[:,:,0]), interpolation='none')
plt.figure()
plt.imshow(np.flipud(policy[:,:,1]), interpolation='none')
plt.show()