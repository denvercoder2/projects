# password generation
import random
import string


def password():
    alphabet = 'ABCDEFGHIJKLMNOPQRSSTUVWXYZ'
    numbers = '0123456789'
    special_char = '!@#$%^&*()_+=-`~'
    # random choice from numbers string
    y = random.choice(numbers)
    # random choice from special characters string
    
    z = random.choice(special_char)

    # start as empty list so I can join the combination gathered
    # by random choice later
    char_list = []
    for i in alphabet:
        x = random.choice(alphabet)
        char_list.append(x)

    # join the random characters selected as well 
    # as choices from both the special characters and numbers strings
    semi = ''
    join = semi.join(char_list)
    # print a randomly generated string password
    print(join + y + z)


if __name__ == "__main__":
    for i in range(10):
        print('---- Randomly generated password ---- #', i)
        password()