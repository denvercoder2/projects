# Prelab 5

''' Part one '''

# 1
N = int(input("Please input a value for N: \n"))

# # #2
def question_1(N: int):
    while N > 1:
        N -= 1
        print("Current Number - 1 is: ", N)


#3
# factorial should be initialized to one before starting the loop
# because if it's set at 0, the factorial in the while loop
# will multiply N by 0, returning 0
def factorial_func(N: int):
    factorial = 1
    while N >= 1:
        factorial = factorial * N
        N = N - 1
    return factorial


''' 
output 
Please input a value for N: 
5
120
'''

''' Part 2 '''

# 1 
def checks(x: int):
    # here is part 1 (Check that x isn't 0)
    while x > 0:
        if x % 2 == 0:
            print(x, "is Even and positive")
            break
        else:
            print (x, "is Odd and positive")
            break
    else:
        print("Number given is 0 or negative")
    
    return x



output_part_2 = checks(N)

'''
output
Please input a value for N: 
-1
Number given is 0 or negative
(base) river@riv-laplnx:~/Desktop/Git/projects$ /usr/bin/python3 /home/river/Desktop/Git/projects/Code/projects/Languages/Python/CS104/prelab5.py
Please input a value for N: 
8
8 is Even and positive
(base) river@riv-laplnx:~/Desktop/Git/projects$ /usr/bin/python3 /home/river/Desktop/Git/projects/Code/projects/Languages/Python/CS104/prelab5.py
Please input a value for N: 
3
3 is Odd and positive
'''