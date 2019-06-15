# brute force password implementation
from itertools import permutations,combinations
import time

#function will be deprecated in python 3.8
def password_generation():
    # alphabet string
    alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'    
    # for all possible combinations (order doesn't matter) from the alphabet string and n character limit
    possible_pw = [w for w in combinations(alphabet,35)]   
    print(possible_pw)

def driver():
    # time.clock() gives output in seconds, hence the conversion
    run_time = time.clock()
    password_generation()
    ms = (run_time * 1000.00)   #conversion from seconds to milliseconds
    print ("Time in Milliseconds---> :", ms)
driver()
