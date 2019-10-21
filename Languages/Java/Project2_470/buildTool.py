'''
Scott Holley
High level Build tool for 470 Project 2
November 4th, 2019
Using python3.7
'''
import subprocess

def compile_run():
    '''
    Use the subprocess module to compile and run 
    the programs
    '''
    print("Compiling Projector.java . . .")
    subprocess.call(['javac', 'Projector.java'])

    print("Compiling MobileDevices.java . . .")
    subprocess.call(['javac', 'MobileDevice.java'])

    print("\nRunning Projector . . .")
    subprocess.call(['java', 'Projector'])

    print("\nRunning MobileDevices . . .")
    subprocess.call(['java', 'MobileDevice'])



def main():
    '''
    Call all subprocesses
    '''
    compile_run()

if __name__ == "__main__":
    main()