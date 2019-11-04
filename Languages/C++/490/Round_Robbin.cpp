/*
Scott Holley
CS490: Operating Systems
Homework 4
Due: November 14th, 2019
*/ 

#include <iostream>
#include <time.h>
#include <fstream>
#include <sstream> 
#include <string>
#include <vector>
#include <tuple>
#include <numeric>
#include <bits/stdc++.h> 

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
*    - Turnaround Time = Completion time - arrival time (Waiting time - Burst Time)
*    - Normalized TAT = TAT/Service Time
-------------------------------------------------------------
*    System Statistics:
*    - Length of simulation in clock ticks -D
*    - Total number of processes -D
*    - Number of jobs in each category (short, medium, long);
*    - Average turnaround time and average normalized turnaround time, -D 
*        within each category and for the system as a whole.

*    Important notes:
*    - Service time = an integer that represents the CPU run time required – provided as input data
*    - Arrival time = an integer that represents the time the process entered the system.
*                        To simplify your program assume all processes arrive at t=0.
*    - CPU Time = An integer that represents the amount of CPU run time received so far.
*                    Initially set to 0, but recomputed each time a process “executes”
*/


/*
====================================================
*   Function: calcWaitTime
*   --
*   Arguments: int processes[], int counter, int burstTime[],
*               int waitTime[], int q
*   --
*   Return type: None (void) 
*   ========== Purpose ==========
*   This function will calculate the
*   waiting time for all given processes
====================================================
*/
void calcWaitTime(int processes[], int counter, int burstTime[], int waitTime[], int q){

    // we want something to store the burst times not yet used
    int remaining_burstTime[counter];
    for (int i = 0; i < counter; i++){
        remaining_burstTime[i] = burstTime[i];
    }
    // clocks at 0 initialization
    int e = 0;
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
        // If all processes are done
        if (done == true){
            break;
        }
    }
}

/*
====================================================
*   Function: calcTAT
*   --
*   Arguments: int processes[], int counter, int burstTime[],
*               int waitTime[], int TAT[]
*   --
*   Return type: None (void)          
*   ========== Purpose ==========
*   This function will calculate the
*   Turnaround Time
====================================================
*/
void calcTAT(int processes[],int counter,int burstTime[],int waitTime[],int TAT[]){

    //calculate the turnaround time
    for(int i = 0; i < counter; i++){
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
    std::ifstream infile (filename);
    std::string line1;
    std::string line2;
    int max = 2;
    if (infile){

        for(int i = 0; i < max; i++){
            std::getline(infile, line1);
            std::getline(infile, line2);

        }
    }
    else{
        // error check if file can't be opened
        std::cout << "File could not be opened" << std::endl;
    }
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

    // container for other vectors
    std::stringstream stm(str1);
    // std::istringstream stm2(str2);
    
    int value;
    // line 1 vector
    std::vector<int> retmp;
    while(stm >> value){
        retmp.push_back(value);
    }
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
    std::istringstream stm2(str2);
    
    int value;
    // line 2 vector
    std::vector<int> vecStr2;
    // store int values in vector from string
    while(stm2 >> value){
        vecStr2.push_back(value);
    }

    return vecStr2;
}

/*
====================================================
*   Function: showReport
*   --
*   Arguments: int processes[],int counter,int burstTime[],int q
*   --
*   Return type: None (void)
*               S
*   ========== Purpose ==========
*   This function will calculate and show
*   individual and system reports
====================================================
*/
void showReport(int processes[],int counter,int burstTime[],int q){

    // grab the service times from the tuple -> vector
    std::tuple<std::string, std::string> s_tuple = getLine("sample.txt");
    std::vector<int> serviceTimes = getServiceTimes(s_tuple);

    int waitTime[counter], TAT[counter];
    int totalWait = 0, totalTAT = 0;

    // call function for the waiting time
    calcWaitTime(processes, counter, burstTime, waitTime, q);

    // call function for the for Turnaround Time
    calcTAT(processes, counter, burstTime, waitTime, TAT);
    int NTAT;

    std::cout << "| Process # |" << " Burst Time |"
            << " Waiting Time |" << " Turnaround Time |" << " Service Time |"
            << " Normalized Turnaround Time|\n";

    for (int i = 0; i < counter; i++){
        NTAT = TAT[i] / serviceTimes[i];
        totalWait = totalWait + waitTime[i];
        totalTAT = totalTAT + TAT[i];

        std::cout << "  " << i+1 << "\t\t" << burstTime[i] <<"\t\t "
        << waitTime[i] <<"\t\t " << TAT[i] << "\t\t" << serviceTimes[i] << "\t\t"
        << NTAT << std::endl;

    }
    // get the sum of service times for the system statistics
    int serviceTimeTotal = std::accumulate(serviceTimes.begin(), serviceTimes.end(), 0);

    // display the average times
    std::cout << "\nAverage Waiting Time: " << (float)totalWait / (float)counter << std::endl;
    std::cout << "Average System Turnaround Time: " << (float)totalTAT / (float)counter << std::endl;
    std::cout << "Average System Normalized Turnaround Time: " << (float)totalTAT / (float)serviceTimeTotal << std::endl;

}


/*
====================================================
*   Function: vec2arr
*   --
*   Arguments: std::vector<int>
*   --
*   Return Type: * arr
*   ========== Purpose ==========
*   Take a vector and convert it to an array
====================================================
*/

/*
====================================================
*   Function: Main
*   --
*   Arguments: None
*   --
*   Return Type: None (0)
*   ========== Purpose ==========
*   To provided a driver for the functions above
====================================================
*/

int main()
{
    std::tuple<std::string, std::string> q_tuple = getLine("sample.txt");
    // quantum time vector
    std::vector<int> q_results = getQuantumTimes(q_tuple);
    //service time vector
    std::vector<int> s_results = getServiceTimes(q_tuple);
    
    // process array
    int processes[] = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15};
    // we only have two values for the q times
    int q_timeMax = 2;
    // initialize counter to use in functions below
    int counter = sizeof processes / sizeof processes[0];
    // burst time array (0 can't be present)
    int burstTime[] = {8,6,6,6,5,8,4,5,4,10,2,1,3,8,9};
    std::cout << "======================================= Report Started =======================================  \n";

    // finding the clock tics
    clock_t start, end, ticks;
    int count;
    start = clock();
    ticks = clock();

    // this is all formatting
    for (int i = 0; i < q_results.size(); i++){
        std::cout << " \n======================================= Quantum #" << q_results[i] << 
        " =========================================== " << std::endl;
        showReport(processes, counter, burstTime, q_results[i]); 
        std::cout << "======================================== End Quantum #" << q_results[i] << 
        "=========================================\n" << std::endl;
    }
    ticks = clock() - ticks;
    // getting the system statistics clock ticks and time
    end = clock();
    double time = double(end - start) / double(CLOCKS_PER_SEC); 
    std::cout << "Time taken to run through processes: " << std::fixed  
    << time << std::setprecision(5); 
    std::cout << " Seconds " << "With: " << ticks << " Clock Ticks "<< std::endl; 

    std::cout << "======================================= Report Finished =======================================  \n";

}

/*
 May need to implement something that gets the burst time
 Depends on the input
*/