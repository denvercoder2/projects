''' Program to Fix Read Dead Redemption 2 '''
import subprocess
import os
import time

def fix() -> list:
    os.chdir('C:\\Users\River\Documents\Rockstar Games\Red Dead Redemption 2\Settings\\')
    file_list = os.listdir()

    return file_list
    
def delFiles(file_list: list):
    try:
        for file in file_list:
            if file.startswith("sga"):
                os.remove(file)
    except(FileNotFoundError):
        time.sleep(90)    

def main():
    time.sleep(5)
    file_list = fix()
    delFiles(file_list)

if __name__ == "__main__":
    while(True):
        main()
    