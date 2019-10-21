'''
Placement for new bill itemiser
'''

def rent(rent_bill: int) -> float:
    '''
    Function will return the rent ratio for Scott
    Our rent includes water
    '''
    return rent_bill * .523

def utilities(utility_bill: float) -> float:
    '''
    Function will return what each payer
    has to pay for utilities
    '''
    return utility_bill * .5

def internet(internet_bill: float) -> float:
    '''
    Function will return what each payer
    has to pay for internet
    '''
    return internet_bill * .5


def totals(x: int, y: float, z: float) -> float:
    '''
    Function will return the totals for both paying members
    '''
    total = x + y + z 
    return total

def main():
    rent_total = 1115
    utility = float(input("Utility bill for this month: "))
    internets = 70

    Scott_rent = rent(rent_total)
    Roy_rent = 1115 - Scott_rent

    utility_payment = utilities(utility)
    internet_payment = internet(internets)



    print("*************************************** Menu Portal ***************************************")
    make_app = int(input("Enter 1 to see the bill calculations for this month: "))

    if make_app == 1:
        print("Rent for the month (total) is: ", rent_total)
        print("Utility bill for the month is: ", utility)
        print("Internet bill for the month is: ", internets)
        print("*************************************** Payment breakdown ***************************************")
        print("---- Rent Breakdown ----")
        print("Rent bill for Scott: ", Scott_rent)
        print("Rent bill for Roy: ", Roy_rent)
        print("---- Rent Breakdown ----\n")

        print("---- Utility Breakdown ----")
        print("Scott Utility bill: ", utility_payment)
        print("Roy Utility bill: ", utility_payment)
        print("---- Utility Breakdown ----\n")

        print("---- Internet Breakdown ----")
        print("Scott Internet bill: ", internet_payment)
        print("Roy Internet bill: ", internet_payment)
        print("---- Internet Breakdown ----\n")

        print("----------------- Total amount owed by both parties -----------------")
        print("Scott total for month: ", totals(Scott_rent, utility_payment, internet_payment))
        print("Roy total for month: ", totals(Roy_rent, utility_payment, internet_payment))


if __name__ == "__main__":
    main()
    


