'''
Scott Holley
High level Build tool for 470 Project 2
November 4th, 2019
Using python3.7
'''
import subprocess

def compile():
    '''
    Use the subprocess module to compile programs
    '''
    print("Compiling Server.java . . .")
    subprocess.call(['javac', 'Server.java'])

    print("Compiling Receiver.java . . .")
    subprocess.call(['javac', 'Receiver.java'])


def main():
    '''
    Call all subprocesses
    '''
    compile()

if __name__ == "__main__":
    main()