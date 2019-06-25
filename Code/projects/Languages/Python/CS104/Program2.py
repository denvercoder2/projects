# --------------- Introductory --------------#
# Scott Holley
# Program 2, CS104
# Date: June 25th, 2019
# Run and Tested on Python 3.7.3 Anaconda
# Purpose: To compute invoices based on the user input
# --------------- Introductory --------------#

# --------------- Start of Program --------------#


def user_invoice():
    user_invoice.rate = float(input("Please enter the hourly invoice rate: "))
    return user_invoice.rate

def user_hour_rate(hours: int):
    return hours * user_invoice.rate

def user_discounts():
    user_discounts.discount_code = int(input("Please enter the discount rate: (1: 10%, 2: 12%, 3: 15%): "))
    user_discounts.discount_rate = 0.0

    if  user_discounts.discount_code is 1:
        user_discounts.discount_rate = .10
    elif  user_discounts.discount_code is 2:
        user_discounts.discount_rate = .12
    elif  user_discounts.discount_code is 3:
        user_discounts.discount_rate = .15
    else: 
        user_discounts.discountrate = 0.0
    
    return user_discounts.discount_rate

def gross_income(pay: float):
    return pay * user_invoice.rate

def main():
    user_hours = int(input("Please enter the hours invoiced: "))
    user_invoice()
    user_discounts()
    print("\n---------------- INVOICE ----------------\n")
    gross_hours_pay = gross_income(user_hours)
    discount = gross_hours_pay * user_discounts.discount_rate
    net_hours_pay = gross_hours_pay - gross_hours_pay * user_discounts.discount_rate
    print("Hours invoiced: ", user_hours, "\t\tHourly Rate: $", user_invoice.rate)

    print("\nGross Income: $", gross_hours_pay,"\n\tDiscount: $",discount,
         "(Discount code: ", user_discounts.discount_code, ")" )
    
    print("  Net Invoice: $",net_hours_pay, "(Pay This Amount)")
    print("\n---------------- END INVOICE ----------------\n")




if __name__ == "__main__":
    print("Welcome to the invoice calculator.\n")
    main()

    # fix where it asks every run
    user_continue = str(input("Would you like to compute another invoice? [Y or N]"))
    while user_continue == "Y" or user_continue == "y":
        main()
        break
    else:
        print("Thank you\nGoodbye")