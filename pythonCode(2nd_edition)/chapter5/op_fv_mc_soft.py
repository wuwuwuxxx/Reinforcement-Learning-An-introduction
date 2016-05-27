# on-policy first-visit MC control algorithm for \eps-soft policies
import numpy as np
import matplotlib.pyplot as plt
from matplotlib import cm
from jk_function import next_card, hand_value, reward, pro_action
import time

start = time.time()

Q = np.zeros((10, 10, 2, 2))
returns = np.zeros((10, 10, 2, 2))
policy = np.zeros((10, 10, 2))

# \eps = 0.01
# it takes me 1.5 hours to run 100000000 episodes on my laptop
steps = 100000000
for x in xrange(steps):
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
    action = pro_action(policy[dealer_hand[0]-1, ph-12, useable])
    states_seen.append((dealer_hand[0]-1, ph-12, useable, action))
    while ph < 22:
        if action == 0:
            player_hand.append(next_card())
            ph, useable = hand_value(player_hand)
            if ph < 22:
                action = pro_action(policy[dealer_hand[0]-1, ph-12, useable])
                states_seen.append((dealer_hand[0]-1, ph-12, useable, action))
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
Y = np.arange(1, 11)
X = np.arange(12, 22)
X, Y = np.meshgrid(X, Y)

plt.figure()
plt.imshow(np.flipud(policy[:,:,0]), interpolation='none')
plt.figure()
plt.imshow(np.flipud(policy[:,:,1]), interpolation='none')
plt.show()