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
    print("Compiling Server.java . . .")
    subprocess.call(['javac', 'Server.java'])

    print("Compiling Client.java . . .")
    subprocess.call(['javac', 'Receiver.java'])

    print("\nRunning Server . . .")
    subprocess.call(['java', 'Server'])

    print("\nRunning Client . . .")
    subprocess.call(['java', 'Receiver'])



def main():
    '''
    Call all subprocesses
    '''
    compile_run()

if __name__ == "__main__":
    main()