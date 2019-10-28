# upper level script to run all code for bill report
import subprocess
import os
import platform

def run(cpp_path:str, python_path: str):
    '''
    Function to call cpp program for output
    then call python program to format data
    '''
    # run the bills program 1st
    os.chdir(cpp_path)
    subprocess.call(['g++', 'dist.cpp'])
    subprocess.call('./main')

    # call python to convert it
    os.chdir(python_path)
    subprocess.call(['python3.7', 'bill_formatter.py'])


def main():
    '''
    Call to other functions 
    '''
    # if platform.system() == 'Linux':
    #     print("Compiled on Linux . . .")
    #     cpp_path = '/home/river/Desktop/Git_projects/Languages/C++/General/'
    #     python_path = '/home/river/Desktop/Git_projects/Languages/Python/Personal/'
    #     run(cpp_path, python_path)
    # else:
    print("Compiled on Windows . . .")
    cpp_path = '\\Users\River\Desktop\Code\projects\Languages\C++\General\\'
    python_path = 'C:\\Users\River\Desktop\Code\projects\Languages\Python\Personal\\'
    run(cpp_path, python_path)

if __name__ == "__main__":
    main()