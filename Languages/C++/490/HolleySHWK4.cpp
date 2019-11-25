/*
Scott Holley
CS490: Operating Systems
Homework 4
Due: November 13th, 2019
*/

#include <iostream>
#include <iomanip>
#include <time.h>
#include <fstream>
#include <sstream>
#include <string>
#include <vector>
#include <tuple>
#include <numeric>

/*
=================== Program Overview =================== 
*    Implement the Round Robbin algorithm in C++
*    While calculating and displaying individual
*    and System statistics as mentioned in program
*    requirements. They are as follows:
-------------------------------------------------------------
*    Individual: classification of process.
*    - short (finishes within the first time q), 
*    - medium (finishes within two quanta)
*    - long (requires more than two quanta to complete);  
*       
*    - Display turnaround time and normalized turnaround time -D
*    - Turnaround Time = Completion time - arrival time (Waiting time - Service Time)
*    - Normalized TAT = TAT/Service Time
-------------------------------------------------------------
*    System Statistics:
*    - Length of simulation in clock ticks -D
*    - Total number of processes -D
*    - Number of jobs in each category (short, medium, long);
*    - Average turnaround time and average normalized turnaround time, -D 
*        within each category and for the system as a whole.
-------------------------------------------------------------
*    Important notes:
*    - Service time = an integer that represents the CPU run time required – provided as input data
*    - Arrival time = an integer that represents the time the process entered the system.
*                        To simplify your program assume all processes arrive at t=0.
*    - CPU Time = An integer that represents the amount of CPU run time received so far.
*                    Initially set to 0, but recomputed each time a process “executes”
*
*   - Since we're assuming that arrival times are at 0, turnaround time = completion time
-------------------------------------------------------------
*/

/*
====================================================
*   Function: calcWaitTime
*   --
*   Arguments: std::vector<int> processes, int counter, int burstTime[],
*               int waitTime[], int q
*   --
*   Return type: None (void) 
*   ========== Purpose ==========
*   This function will calculate the
*   waiting time for all given processes
====================================================
*/
int calcWaitTime(std::vector<int> processes, int counter, std::vector<int> burstTime, int waitTime[], int q){

    // we want something to store the Service Times not yet used
    int remaining_burstTime[counter];
    for (int i = 0; i < counter; i++){
        remaining_burstTime[i] = burstTime[i];
    }
    // clocks at 0 initialization
    int e = 0;
    int clock = 0;
    // Continue this until processes are finished
    while (true){
        bool done = true;
        // iterate through all processes one by one
        for (int i = 0; i < counter; i++){
            if (remaining_burstTime[i] > 0){
                done = false;
                if (remaining_burstTime[i] > q){
                    // increment e by quantum
                    e += q;
                    // decriment process by quantum
                    remaining_burstTime[i] -= q;
                    // increment clocks
                    clock += q;
                }
                else{
                    // e is increased to show the time it has been processing
                    e = e + remaining_burstTime[i];

                    // waiting time formula
                    waitTime[i] = e - remaining_burstTime[i];

                    // burstTime should be zero after process
                    // is completely finished executing
                    remaining_burstTime[i] = 0;
                }
            }
        }
        // If all processes are done, then break
        // because there is no more work to be done
        if (done == true){
            // std::cout << "Clocks: " << clock << std::endl;
            break;
        }
    }
        return clock;
}

/*
====================================================
*   Function: calcTAT
*   --
*   Arguments: std::vector<int> processes, int counter, int burstTime[],
*               int waitTime[], int TAT[]
*   --
*   Return type: None (void)          
*   ========== Purpose ==========
*   This function will calculate the
*   Turnaround Time
====================================================
*/
void calcTAT(std::vector<int> processes, int counter, std::vector<int> burstTime, int waitTime[], int TAT[]){

    //calculate the turnaround time
    // process arival is 0, so TAT is = completion time
    for (int i = 0; i < counter; i++){
        TAT[i] = burstTime[i] + waitTime[i];
    }
}

/*
====================================================
*   Function: getLine
*   --
*   Arguments: String Filname
*   --
*   Return type: std::tuple<std::string, std::string>
*   ========== Purpose ==========
*   Function will return a tuple of
*   the input files contents (lines as strings)
====================================================
*/
std::tuple<std::string, std::string> getLine(std::string filename){
    std::ifstream infile(filename);
    std::string line1;
    std::string line2;
    int max = 2;
    if (infile){
        // get both lines of the file
        for (int i = 0; i < max; i++){
            std::getline(infile, line1);
            std::getline(infile, line2);
        }
    }
    else{
        // error check if file can't be opened
        std::cout << "File could not be opened" << std::endl;
    }
    // return the tuple container of both strings (lines)
    return std::make_tuple(line1, line2);
}

/*
====================================================
*   Function: getQuantumTimes
*   --
*   Arguments: std::tuple<std::string, std::string>
*   --
*   Return type: std::vector<std::vector<int>>
*   ========== Purpose ==========
*   Function will return a vector
*   containing the quantum times from file
====================================================
*/
std::vector<int> getQuantumTimes(std::tuple<std::string, std::string> test){
    std::string str1 = std::get<0>(test);

    // Read the string into a sstream object to
    // load into a vector
    std::stringstream stm(str1);
    int value;
    // line 1 vector
    std::vector<int> retmp;
    while (stm >> value){
        retmp.push_back(value);
    }
    // return the vector of string 1
    return retmp;
}

/*
====================================================
*  *     Function: getServiceTimes
*   --
*   Arguments: std::tuple<std::string, std::string>
*   --
*   Return type: std::vector<std::vector<int>>
*   ========== Purpose ==========
*   Function will return a vector
*   containing the service times from file
====================================================
*/
std::vector<int> getServiceTimes(std::tuple<std::string, std::string> test){
    // get the second string from the tuple
    std::string str2 = std::get<1>(test);
    // Read the string into a sstream object to
    // load into a vector
    std::istringstream stm2(str2);

    int value;
    // line 2 vector
    std::vector<int> vecStr2;
    // store int values in vector from string
    while (stm2 >> value){
        vecStr2.push_back(value);
    }
    // return the vector of string 2
    return vecStr2;
}

/*
====================================================
*   Function: showReport
*   --
*   Arguments: std::vector<int> processes,int counter,
*               int burstTime[],int q, std::string filename
*   --
*   Return type: None (void)
*   ========== Purpose ==========
*   This function will calculate and show
*   individual and system reports
====================================================
*/
void showReport(std::vector<int> processes, int counter, std::vector<int> burstTime, int q, std::string filename){

    // for getting the clock ticks
    int count;

    // grab the service times from the tuple -> vector
    std::tuple<std::string, std::string> s_tuple = getLine(filename);
    std::vector<int> serviceTimes = getServiceTimes(s_tuple);
    std::vector<int> quantumTimes = getQuantumTimes(s_tuple);

    int waitTime[counter], TAT[counter];
    int totalWait = 0, totalTAT = 0;

    // call function for the waiting time
    int clocks = calcWaitTime(processes, counter, burstTime, waitTime, q);

    // call function for the for Turnaround Time
    calcTAT(processes, counter, burstTime, waitTime, TAT);
    double NTAT;

    std::string classification;
    // all processes arrive at 0
    int arrivalTime = 0;

    // count intitialization
    int shortCount = 0;
    int medCount = 0;
    int longCount = 0;

    std::cout << "| Process # |"
              << " Arrival Time |"
              << " Waiting Time |"
              << " Turnaround Time |"
              << " Service Time |"
              << " Normalized Turnaround Time |"
              << " Classification |\n";

    // Printing out to the screen the
    // System and Individual Statistics
    for (int i = 0; i < counter; i++){
        NTAT = (double)TAT[i] / (double)serviceTimes[i];
        totalWait = totalWait + waitTime[i];
        totalTAT = totalTAT + TAT[i];

        // getting the classification and count

        // one quanta to complete (or less)
        if (serviceTimes[i]/quantumTimes[0] <= 1){
            classification = "Short";
            shortCount += 1;
        }
        // Up to two quantas to complete
        else if (serviceTimes[i]/quantumTimes[0] > 1 && serviceTimes[i]/quantumTimes[0] <= 2){
            classification = "Medium";
            medCount += 1;
        }
        // More than two quanta to complete
        else{
            classification = "Long";
            longCount += 1;
        }

        std::cout << std::fixed << std::setprecision(2) << "  " << i << "\t\t" << arrivalTime << "\t\t "
                  << (double)waitTime[i] << "\t\t " << (double)TAT[i] << "\t\t" << serviceTimes[i] << "\t\t\t"
                  << NTAT << "\t\t\t" << classification << std::endl;
    }
    // get the sum of service times for the system statistics
    int serviceTimeTotal = std::accumulate(serviceTimes.begin(), serviceTimes.end(), 0);

    // display the average times to two decimal places

    std::cout << std::setfill('=') << std::setw(125) << "=" << std::endl;
    std::cout << "\nFor this Quantum Time, Process counts are: "
              << "\nShort Count: "
              << shortCount << "\nMedium Count: " << medCount << "\nLong Count: " << longCount << std::endl;

    std::cout << std::fixed << std::setprecision(2) << "\nAverage System Waiting Time: " << (float)totalWait / (float)counter << std::endl;
    std::cout << std::fixed << std::setprecision(2) << "Average System Turnaround Time: " << (float)totalTAT / (float)counter << std::endl;
    std::cout << std::fixed << std::setprecision(2) << "Average System Normalized Turnaround Time: " << (float)totalTAT / (float)serviceTimeTotal << std::endl;

    std::cout << std::fixed << std::setprecision(2) << "Processes completed with: " << clocks << " clock ticks" << std::endl;
    std::cout << std::setfill('=') << std::setw(125) << "=" << std::endl;

}

/*
====================================================
*   Function: Main
*   --
*   Arguments: None
*   --
*   Return Type: None (0)
*   ========== Purpose ==========
*   To provided a driver for the functions above
*   As well as implement calls, variables etc.. that
*   Complete the program
====================================================
*/

int main(int argc, char *argv[]){
    // service time vector
    std::tuple<std::string, std::string> q_tuple = getLine(argv[1]);
    // quantum time vector
    std::vector<int> q_results = getQuantumTimes(q_tuple);
    //service time vector
    std::vector<int> burstTime = getServiceTimes(q_tuple);
    std::vector<int> processes;
    // process array
    for (int i = 0; i < burstTime.size(); i++){
        processes.push_back(i);
    }

    // initialize counter to use in functions below
    // counter should count 0 - 15 (16 processes)
    int counter = processes.size();

    // setting the output as the second
    // command line argument
    freopen(argv[2],"w",stdout); 

    std::cout << "=================================================================== Report Started "
              << "===================================================================\n";

    // this is all formatting
    for (int i = 0; i < q_results.size(); i++){
        std::cout << " \n============================================== Quantum #" <<
         q_results[i] << " Individual Statistics =================================================================== " << std::endl;

        showReport(processes, counter, burstTime, q_results[i], argv[1]);

        std::cout << "=================================================================== End Quantum #" << 
        q_results[i] << " ===============================================================\n"
                  << std::endl;
    }
    std::cout<< "=================================================================== Report Finished "
              << "===================================================================\n";

    
}
