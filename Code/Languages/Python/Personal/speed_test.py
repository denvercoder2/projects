# internet speed longevity test
import subprocess

def test_connection(filename: str):
    '''
    Function sets up the connection call
    and returns the results from subprocess
    '''
    with open(filename, 'w') as out:
        try:
            for tries in range(2):
                process = 'speedtest-cli'
                subprocess.call(process, stdout=out)
        except subprocess.CalledProcessError:
            main()

def lineBreak(filepath: str, n: int):
    '''
    This function cleans the output file
    '''
    with open(filepath) as infile:
        lines = infile.readlines()

    with open(filepath, 'w') as outfile:
        test = 0
        for i,line in enumerate(lines):
            outfile.write(line)

            if not i % n:
                outfile.write('\n=======Test #' + str(test) + '=======\n')
                test += 1

 
def get_results(filename: str) -> list:
    '''
    Function reads the file, returns a list of 
    all lines in the file
    '''
    download_speed_list = []
    
    with open(filename, 'r') as file:
        lines = file.readlines()
    
    for line in lines:
        if line.startswith("Download"):
            download_speed_list.append(line)


    return download_speed_list


def sum_list(some_list: list) -> float:
    '''
    Function returns the sum of elements
    of the given list
    '''
    total = 0
    for element in range(0, len(some_list)):
        total = total + some_list[element]

    return total


def main():
    '''
    Main function setup 
    '''
    print("Report Running ...\n")
    test_connection('output.txt')
    lineBreak('output.txt', 8)
    speed_list = get_results('output.txt')
    # stripping unwanted characters in the list
    speed_list = [element.strip('Download:') for element in speed_list]
    speed_list = [element.strip('\n') for element in speed_list]
    speed_list = [element.strip('Mbits/s') for element in speed_list]
    raw_download_mbps = []
    expected = 0
    bill = 90
    for item in speed_list:
        raw_download_mbps.append(float(item))
        if float(item) > 350 and float(item) < 450:
            expected += 1
    average = sum_list(raw_download_mbps) / len(raw_download_mbps)
    suggested_average = 450 / average
    reduced_bill = bill * (suggested_average / 100)

    print("The Average Bandwidth is (sum of all bandwidth tests/ tries): ", average ,"Mbits/s")
    print("That is: ", sum_list(raw_download_mbps), "total, " + "divided by: ", len(raw_download_mbps), "tests")
    print("Our expected speed is 450 Mbits/s, in this test series, we hit around that (350 to 450): ", expected, "times")

    print("We recieve around: ", "%.2f" %suggested_average, "percent of paid for on average.", "\nOur ratio of sevice to bill should be: $","%.2f" %reduced_bill)


    
    
if __name__ == "__main__":
    print("\n----------------------------------Report----------------------------------\n")
    main()
    print("\n----------------------------------End Report------------------------------\n")

