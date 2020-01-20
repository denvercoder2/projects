'''
Random Matrix Generator in Python 3.7
Scott Holley
To make sudoku board for C++ to solve
'''
import random

def make_matrix(rows: int, columns: int) -> list:
    '''
    Function: make_matrix
    Parameters: rows: int, columns: int
    Return Type: list
    Purpose: Create a matrix as a list
    '''
    matrix = []  
    for i in range(rows):
        a =[] 

        for j in range(columns):     
            a.append(random.randint(1, 9)) 

        matrix.append(a)

    return matrix 


def matrixify(row:str) -> str:
    '''
    Function: maTRIXIFY
    Parameters: rows: STR
    Return Type: str
    Purpose: format the matrix as sudoku
    '''
    row = row.replace("[", "")
    row = row.replace("]", "")
    row = row.replace(",", " ")
        
    return row


    
def write_matrix(matrix: list, filename: str) -> None:
    '''
    Function: write_matrix
    Parameters: matrix: list, filename: str
    Return Type: None
    Purpose: Write the formatted matrix to a file
    '''
    # matrix_check = make_sudoku(matrix)
    with open (filename, "w") as outfile:
        for row in matrix:
            row = str(row) + "\n"
            row = matrixify(row)
            outfile.write(row)


def main():
    ''' Main Function '''
    rows = 9
    columns = 9
    matrix = make_matrix(rows,columns)
    filename = "\\Users\R\Desktop\projects\Languages\C++\General\Matrix.txt"
    write_matrix(matrix, filename)



if __name__ == "__main__":
    main()

