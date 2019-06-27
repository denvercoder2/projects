# Scott Holley
# Lab 5 part 1
# June 27th, 2018

# def factorial_func(N: int):
#     factorial = 1
#     while N > 1:
#         factorial = factorial * N
#         N -= 1
#     return factorial


# def main_part_1():
#     N = int(input("Please input a value for N: \n"))
#     print("The factorial value for", N, "is: ", factorial_func(N))


# if __name__ == "__main__":
#     main_part_1()

# ''' output '''
# '''
# Please input a value for N: 
# 10
# The factorial value for 10 is:  3628800
# '''
# 1 

num = int(input("Please give a value for the num: "))
while num != 0:
    if num % 2 == 0:
        print(num, "is Even")
    else:
        print(num, "is Odd")
    num = int(input("Please input another number: "))
    if num == 0:
        print("\nYou entered 0. Goodbye")

    


        


