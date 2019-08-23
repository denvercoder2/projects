# formatting bills for csv reading (easier via email)
# Scott Holley

def get_file(filename: str) -> list:
    '''
    Function will read in a file and return
    a list containing all lines within the file
    '''
    path = '/home/river/Desktop/Git/projects/Code/Languages/C++/'
    with open (path+filename, "r") as infile:
        lines = infile.readlines()

    return lines

def return_csv(filename: str, lines: list):
    '''
    Function will take in the list and
    print out to a csv file
    '''
    with open (filename, "w") as outfile:
        for line in lines:
            outfile.write(line)
        
def main():
    '''
    Main function setup
    '''
    lines = get_file('output.txt')
    return_csv('bill_report.csv', lines)



if __name__ == "__main__":
    main()