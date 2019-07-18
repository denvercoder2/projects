# --------------- Introductory --------------#
# Scott Holley
# Program 3, CS104
# Date: July 17th, 2019
# Written in Python 3.7.3 Anaconda
# Purpose: To read in and interpret data from a file 
# and send the answer to an outfile
# --------------- Introductory --------------#


def get_file(fileIn: str):
    '''
    This function will take a filename(fileIn) and open it
    It will then place all of the numbers(line) within the file
    into a list. That list is returned so it can be used
    by other functions
    '''
    item_list = []

    with open (fileIn, "r") as fileIn:
        lines = fileIn.readlines()

    for line in lines:
        item_list.append(int(line))

    return item_list


def sort_list(item_list: list):
    '''
    Python's default sort is a timsort
    I've never used it since I had to roll 
    my own most of the time, so this seemed like
    a good time. Seems to be a pretty good option
    considering it's a stable and in place sort
    '''
    item_list.sort()

    return item_list

def grading_scale(score: int):
    '''
    This function will take the grades and assign 
    the grade based on the score given per element in the
    list. This grade is returned.
    '''
    if score >= 90:
        grade = 'A'
    elif score >= 80 and score < 90:
        grade = 'B'
    elif score >= 70 and score < 80:
        grade = 'C'
    elif score >= 60 and score < 70:
        grade = "D"
    else:
        grade = 'F'

    return grade

def letter_grades(grades_list: list):
    '''
    This function will take a list of grades
    and return a list of letter grades corresponding
    to that score. It also returns a count for the
    number of grades in the file.
    The for loop consists of calling another function
    which translates the grades into letters, and
    then appending them to the list to return
    '''
    
    letter_grade_list = []
    for number in grades_list:
        score = grading_scale(number)
        letter_grade_list.append(score)

    return letter_grade_list

def letter_grade_tally(letter_grade_list: list):
    '''
    This function takes a list and returns the
    count of the corresponding letter grades from that list in a set
    denoted by A, B, C, D, and F.
    They all begin at 0 in order to initialize the count at 
    an even start for all grades 
    '''
    A = B = C = D = F = 0
    for grade in letter_grade_list:
        if grade == 'A':
            A += 1
        elif grade == 'B':
            B += 1
        elif grade == 'C':
            C += 1
        elif grade == 'D':
            D += 1
        else:
            F += 1
    
    return A,B,C,D,F


def get_grade_count(grade_list: list):
    '''
    This function takes a list and returns a count of the
    number of elements in the list. Not entirely needed, but
    to keep everything modular, I added it as a function.
    '''
    count = 0
    for element in grade_list:
        count += 1
    
    return count
    

def compute_average_grade(grade_list: list):
    '''
    This function takes a list and adds all
    of the elements together in said list.
    The return value is that sum, divided by the number
    of elements within that list (the length of the list)
    '''
    all_scores = 0
    for element in range(0, len(grade_list)):
        all_scores = all_scores + grade_list[element]

    return all_scores/len(grade_list)

def main():
    '''
    Variable Explanations:
    filein: Asks the user to input a filename to read from
    grades_list: generates a list from the lines in the file specified by the user
    sorted_list: the sorted version of grades_list (low to high)
    letter_grade_list: The letter grade equivalent based on the scale, for each item in sorted list
    grade_count: A count of all the items in grade list
    class_average: The sum of all elements of grades_list, divided by the total number of elements in list
    fileout: Asks the user for a filename to write the report to
    A,B,C,D and F: Corresponding return values for letter_grade_tally function's counts of those grades

    Outfile is opened (user gives name of outfile), and statements are sent there.
    Outfile is closed and saved, then program exits
    '''
    filein = str(input("\n\nPlease enter the name of the file you want to read in: "))
    grades_list = get_file(filein)
    sorted_list = sort_list(grades_list)
    letter_grade_list = letter_grades(sorted_list)
    grade_count = get_grade_count(grades_list)
    class_average = compute_average_grade(grades_list)  
    fileout = str(input("\n\nPlease enter the name of the output data file: "))
    A,B,C,D,F = letter_grade_tally(letter_grade_list)
    with open (fileout, "w") as outfile:
        print('---------------- Test Profile ----------------\n', file = outfile)
        print("There were",grade_count, "test grade(s) read from the input file", file = outfile)
        print("The average is: ","%.2f" %class_average, file = outfile)
        print("The highest test grade was: ", sorted_list[-1], file = outfile)
        print("The lowest test grade was: ", sorted_list[0], file = outfile)
        print("\n\nThe total of each grade is as follows:\n    A:",A, "\n    B:", B, "\n    C:", C, "\n    D:", D, "\n    F:", F, file = outfile)

    outfile.close()

    print("\nReporting Complete - stored in file: ", fileout, "\nExiting Program 3")


if __name__ == "__main__":
    print("\nWelcome to the test profiler.",
    "\nThis program will read your test results from an input data file.",
    "\nIt will produce a count of the A's, B's, etc., along with the",
    "\ntest average and the highest and lowest grades in the set."
    )
    main()
