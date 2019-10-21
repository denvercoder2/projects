# River Holley
# Budget Maker and checker for python

def bills():
    # items (bills can be added if needed)
    montly_bills = {
        'Car ----->':  214,
        'Car Insurance ----->': 160,
        'Rent ----->': 600,
        'Internet ----->': 55,
        'Phone, ----->': 40,
        'Utilities, ----->': 50,
        'Groceries ----->': 100
    }
    # find the sum of all bills by summing all values in key, value pairs
    bills.sum_bills = sum(montly_bills.values())
    for k,v in montly_bills.items():
        print (k , "bill for this month is :", v)
 
    print("The total for this months bills is : --->", bills.sum_bills)
    
    
        
def main():
    total = int(input("What was the total check for the month? "))
    bills()
    remainder = total - bills.sum_bills
    print("\nAfter bills, you will have --->", remainder, "remaining" )
    
    savings = remainder * .35
    savings_extra = remainder * .5
    print("\nYou should save: ---> ", savings, "this month or more if possible\nExtra savings would be: ", savings_extra)

    
if __name__ == "__main__":
    print("Welcome to the budget planning tool!\n")
    main()    

