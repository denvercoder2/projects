# Scott Holley
# Calculator example in python


'''
These are functions. They take parameters (a, b), in python you
don't have to give them a type, but you can if you want.
'''
def add(a, b):
    return a + b

def sub(a, b):
    return a - b

def multiply(a, b):
    return a * b

def divide(a, b):
    return a / b

'''
This main program asks for the user to give the two numbers
and asks which operation that they want to perform on the two numbers.
Depending on what they pick, the operation is done on imput one and input two
then returned 
'''
def main():
    input_one = float(input("Enter the first number: "))
    input_two = float(input("Enter the second number: "))

    choice = int(input("Choose an operation: \n1)Addition\n2)Subtraction\n3)Multipliction\n4)Division \n"))

    if choice == 1:
        print("The answer is: ", add(input_one, input_two))
    elif choice == 2:
        print("The answer is: ", sub(input_one, input_two))
    elif choice == 3:
        print("The answer is: ", multiply(input_one, input_two))
    else:
        print("The answer is: ", divide(input_one, input_two))


if __name__ == "__main__":
    main()