'''
Placement for new bill itemiser
'''


def rent(rent_bill: float) -> float:
    '''
    Function will return the rent ratio for Scott
    Our rent includes water. This function goes
    to whoever has the bigger room
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

def rInsurance(rent_insurance: float) -> float:
    '''
    Function will return the rent insurance for each
    tenant
    '''
    return rent_insurance * .5



def totals(x: int, y: float, w: float, z: float) -> float:
    '''
    Function will return the totals for both paying members
    '''
    total = x + y + w + z
    return total



def main():
    rent_total = 1115.0
    utility = float(input("Utility bill for this month: "))
    internets = 70

    Scott_rent = rent(rent_total)
    Roy_rent = 1115.0 - Scott_rent
    Renters_insurance = 12.75
    renters_payment = rInsurance(Renters_insurance)

    utility_payment = utilities(utility)
    internet_payment = internet(internets)



    print("*************************************** Menu Portal ***************************************")
    make_app = int(input("Enter 1 to see the bill calculations for this month: "))

    if make_app == 1:
        print("Rent for the month (total) is: ", rent_total)
        print("Utility bill for the month (total) is: ", utility)
        print("Internet bill for the month (total) is: ", internets)
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


        print("---- Renters Insurance Breakdown ----")
        print("Scott insurance bill: ", renters_payment)
        print("Roy insurance bill: ", renters_payment)
        print("---- Renters Insurance Breakdown ----\n")

        
        print("----------------- Total amount owed by both parties -----------------")
        print("Scott total for month: ", totals(Scott_rent, utility_payment, internet_payment, renters_payment))
        print("Roy total for month: ", totals(Roy_rent, utility_payment, internet_payment, renters_payment))


if __name__ == "__main__":
    main()
    



