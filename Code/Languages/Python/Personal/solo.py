# An attempt at automated solo generation
# Version 1.0
# Scott Holley

import random
import threading
import time

def key_list() -> list:
    '''
    Sample function for key of e
    '''
    # key_of_eMajor = ['E', 'F#', 'G#', 'A', 'B', 'C#', 'D#']
    key_of_eBlues = ['E', 'G', 'A', 'Bb', 'B', 'D', 'E']

    return key_of_eBlues

def solo_generator(notes: list) -> str:
    '''
    Function will pick a note from the scale to display
    '''
    for note in notes:
        note_choice = random.choice(notes)
    
    return note_choice


def bars(bars_count: int):
    '''
    Function will keep track of bars
    '''
    count = 0
    while count < bars_count:
        count += 1

    return count


def main():
    solo_list = key_list()
    bar = int(input("How many bars? "))
    timer = threading.Timer(4.0, bars)
    while timer:
        solo = solo_generator(solo_list)
        time.sleep(4)
        print(solo + "\n")
    


    
if __name__ == "__main__":
    main()