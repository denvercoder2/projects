''' Python implementation for Circumference program '''

def getCircumference(radius: float) -> float:
    ''' Find the circumference given the radius of a function'''
    PI = 3.14159
    circumference = 2 * PI * radius

    return circumference

def main():
    ''' Main Driver'''
    radius = 2.00
    circumference = getCircumference(radius)

    print("Circumference for given radius: ", radius, " is", circumference)

if __name__ == "__main__":
    main()