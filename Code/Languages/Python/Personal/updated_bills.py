# # Scott
# # Bill program with csv viewing application
# # written in conda base 3.7.3
# import csv
  
# def get_utils()-> float:
#     '''
#     Function will return the utility bill for the month
#     '''
#     utilities = float(input("What was the utility bill this month?: "))

#     return utilities * .5


# def rent(rent: int) -> int:
#     '''
#     Function returns the rent share
#     '''
#     return rent * .523

# def water(water: int) -> int:
#     '''
#     Function returns the water share
#     '''
#     return water * .5

# def internet(internet: int) -> int:
#     '''
#     Function returns the internet share
#     '''
#     return internet * .618



# def bill_list() -> list:
#     '''
#     Function returns sorted bills list 
#     '''
#     utils = get_utils()
#     bills = [785, 40, utils, 90]
#     bills_sorted = sorted(bills)


#     return bills_sorted





# def main():
#     '''
#     Main function setup
#     '''
#     bill_list_main = bill_list()
#     sum_of_bills = sum(bill_list_main)
#     with open ('monthly_bills.csv', 'w') as outfile:
#         outfile.writelines("Total Bills for the month: ",str(sum_of_bills) )



# if __name__ == "__main__":
#     main()