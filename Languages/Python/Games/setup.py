''' Game setup environment '''
import subprocess
import platform

def subprocess_cmd(command: str):
    ''' Function to call multiple batch commands''' 
    process = subprocess.Popen(command,stdout=subprocess.PIPE, shell=True)
    proc_stdout = process.communicate()[0].strip()
    print (proc_stdout)


def main():
    ''' Main Function '''
    print("Python Version: ")
    subprocess.call(["py",  "--version"])
    system = platform.platform()
    print("Downloading pip for: ", system, " . . . ")
    subprocess_cmd("python3.7 -m pip install --upgrade pip")
    print("Installing Pygame . . .")
    subprocess_cmd("python3.7 -m pip install pygame")

    print ("\n====================================================\n"
            "Requirements for pygame have been installed."
            "\nYou are now ready to make games"
            "\n====================================================\n")

if __name__ == "__main__":
    main()