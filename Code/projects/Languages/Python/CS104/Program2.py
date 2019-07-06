# --------------- Introductory --------------#
# Scott Holley
# Program 2, CS104
# Date: June 25th, 2019
# Run and Tested on Python 3.7.3 Anaconda
# Purpose: To compute invoices based on the user input
# --------------- Introductory --------------#

# --------------- Start of Program --------------#


'''
user_invoice function asks the user to input their hourly rate, and returns that value
to be used in other functions
'''
def user_invoice():
    user_invoice.rate = float(input("Please enter the hourly invoice rate: "))
    return user_invoice.rate


'''
gross_income function takes an a pay parameter, that being float, and
returns the product of the hours and the user's inputted rate
'''
def gross_income(pay: float):
    return pay * user_invoice.rate


'''
user_discount function asks the user to choose a discount rate, if applicable.
If no option is chosen, then the default is 0.0.
The original rate (user_discounts.discount_rate) has a value of 0.0 so it can act as a variable to be modified based on the
outcome of the conditional. Depending on what the user input is for their rate, that rate is returned .
'''
def user_discounts():
    user_discounts.discount_code = str(input("Please enter the discount rate: (1: 10%, 2: 12%, 3: 15%): "))
    user_discounts.discount_rate = 0.0

    if  user_discounts.discount_code is '1':
        user_discounts.discount_rate = .10
    elif  user_discounts.discount_code is '2':
        user_discounts.discount_rate = .12
    elif  user_discounts.discount_code is '3':
        user_discounts.discount_rate = .15
    else: 
        user_discounts.discount_code = '0'
        user_discounts.discountrate = 0.00
    
    return user_discounts.discount_rate


'''
In main function, we ask for the user to input their hours to be invoiced.
We then call the user_invoice function in order to return their rate, and we call 
the user_discounts function in order to return their discount percentage.

The actual output of the program begins after that with the INVOICE line.
The variable gross_hours_pay is the result of the users hours * the users rate, as per
the gross_income function's return.

The discount variable is the gross_hours_pay (The total pay) * the discount rate.
The net_hours_pay is the gross_hours_pay - the discount.
From there on out until the user_continue_check is just the formatted output for the invoice

Additionally, "%.2f" is just a formatting option for floats to two decimal places.
I added that to match the float format of the sample execution
'''
def main():
    user_hours = float(input("Please enter the hours invoiced: "))
    user_invoice()
    user_discounts()
    print("\n---------------- INVOICE ----------------\n")
    gross_hours_pay = gross_income(user_hours)
    discount = gross_hours_pay * user_discounts.discount_rate
    net_hours_pay = gross_hours_pay - (discount)
    print("Hours Invoiced: ", user_hours, "\t\tHourly Rate: $", "%.2f" %user_invoice.rate)

    print("\nGross Income: $", "%.2f" %gross_hours_pay,"\n\tDiscount: $","%.2f" %discount,
         "(Discount code: ",user_discounts.discount_code,")" )
    
    print("  Net Invoice: $","%.2f" %net_hours_pay, "(Pay This Amount)")
    print("\n---------------- END INVOICE ----------------\n")
    
    # The user_continue_check variable is nested within main because after the initial
    # invoice finishes, I want to ask if the user would like to do another invoice.
    # If they reply with either a 'Y' or a 'y', then the function will go again, recursively calling itself.
    # If they answer anything other than a 'Y' or 'y', then the program will display the exiting message.
    user_continue_check = str(input("Would you like to compute another invoice? [Y or N] "))
    # print added for matching the samples execution
    print()
    if user_continue_check == "Y" or user_continue_check == "y":
        main()
    else:
        print("\nEnd of Program 2, Goodbye\n")
  


'''
Run the main program with a welcome message.
I put an exit condition here to match the requirements of the project,
but it simply checks to see if the user presses any key, and if they do, 
the program will exit. Since this code is only reached after the user has 
chosen to not do another invoice, this code only happens after the main
functions execution, and is really there just to match the sample output.
'''
if __name__ == "__main__":
    print("Welcome to the invoice calculator.\n")
    main()
    exit_condition = str(input("Press any key to continue . . . "))
    if exit_condition != "":
        exit()
