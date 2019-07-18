# Scott Holley
# Program 1 example, CS104
# Date: June 12th, 2019
# Run and Tested on Python 3.7.3 Anaconda
# Purpose: To calculate the BMI given a user entered height and weight
# Another comment added to see if the repo works


''' Start of program '''

# The convert stats function takes two parameters, x and y.
# it returns the converted metric version of what the user enters
# when called on the user entered integers in the main function
def convert_stats(x, y):
    return x / 2.20462, y / 39.3701


# The BMI function takes to parameters, a weight and height, both integers.
# the function will return the correct BMI output based on the BMI formula
def BMI(weight: int, height: int):
    return weight/height**2

# In main, we are asking the user for both their pound and height measurement
# Based on what they give, we convert to metric using the convert stats function on
# the two integers that the user enters. Since the values are now converted, I save them into
# a new set of variables named converted_x and converted_y. These two contain the metric converted 
# values for what the user enters. Then those values are used in my BMI calculation function,
# which will return the correct value. There is a check for the range of the BMI_Calculation value
# and the printout is adjusted accordingly based on the value
def main():
    user_pounds = int(input("\nPlease enter your weight (in pounds): "))
    user_inches = int(input("\nPlease enter your height (in inches): "))
    # the convert function converts imperical to metric, so the 
    # two variables are named metric_x or metric_y to reflect the conversion
    metric_x, metric_y = convert_stats(user_pounds,user_inches)
    BMI_Calculation = BMI(metric_x, metric_y)

    # A conditional check to give output based on value of BMI
    if BMI_Calculation < 18.5: 
        status = "Underweight"
    # from 18.5 to under 25
    elif BMI_Calculation >= 18.5 and BMI_Calculation < 25.0:
        status = "Normal"
    # from 25 to under 30
    elif BMI_Calculation >= 25.0 and BMI_Calculation < 30.0:
        status = "Overweight"
    else:
    # over 30 
        status = "Obese"
    # show output to the user based on what condition they satisfy
    print("\nYour current BMI is: ", BMI_Calculation, "which is", status)


# Set up for the program to run
# Print a welcome message
# call main function
# Print goodbye message
if __name__ == "__main__":
    print("Welcome to the BMI calculator.\nBelow, you will be asked to enter your height and weight.")
    main()
    print("\nThank you.\nGoodbye!")

''' End of program '''