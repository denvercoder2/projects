# Scott Holley
# Lab 6 programs

# Part 2a

# Hypotenuse function takes two parameters (a, b)
# and returns the value of c, which is the square root of a squared + b squared
def hypotenuse(a, b):
    c = (a**2 + b**2)**.5
    return c


# Main program to test the calculation
sideA = float(input("Enter the length of side A: "))
sideB = float(input("Enter the length of side B: "))

hyp = hypotenuse(sideA, sideB)
print("For a right triangle with sides of length", sideA, "and", sideB)
print("The length of the hypotenuse is", hyp)


# part 2b
# returns the minimum of two numbers given the two parameters a and b
def minimum(a, b):
    if a > b:
        return b
    else:
        return a


print("The smallest side of your triangle has a length of: ", minimum(sideA, sideB))