/*
Scott Holley
CS490: Operating Systems
Homework 4
Due: November 14th, 2019
*/

#include <iostream>
#include <fstream>
#include <sstream> 
#include <string>
#include <vector>
#include <tuple>

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
*    - Display turnaround time and normalized turnaround time 
-------------------------------------------------------------
*    System Statistics:
*    - Length of simulation in clock ticks
*    - Total number of processes
*    - Number of jobs in each category (short, medium, long);
*    - Average turnaround time and average normalized turnaround time, 
*        within each category and for the system as a whole.

    Important notes:
    - Service time = an integer that represents the CPU run time required – provided as input data
    - Arrival time = an integer that represents the time the process entered the system.
                        To simplify your program assume all processes arrive at t=0.
    - CPU Time = An integer that represents the amount of CPU run time received so far.
                    Initially set to 0, but recomputed each time a process “executes”
*/


/*
====================================================
Function: calcWaitTime
--
Arguments: int processes[], int counter, int burstTime[],
            int waitTime[], int q
--
Return type: None (void)
            
========== Purpose ==========
This function will calculate the
waiting time for all given processes
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
Function: calcTAT
--
Arguments: int processes[], int counter, int burstTime[],
            int waitTime[], int TAT[]
--
Return type: None (void)
            
========== Purpose ==========
This function will calculate the
Turnaround Time
====================================================
*/
void calcTAT(int processes[],int counter,int burstTime[],int waitTime[],int TAT[]){

    //calculate the turnaround time
    for(int i = 0; i < counter; i++){
        TAT[i] = burstTime[i] + waitTime[i];
    }
}
//------------------------------------------------------
/*
====================================================
Function: getLine
--
Arguments: String Filname
--
Return type: std::tuple<std::string, std::string>
========== Purpose ==========
Function will return a tuple of
the input files contents
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
Function: parseLine
--
Arguments: std::tuple<std::string, std::string>
--
Return type: std::vector<std::vector<int>>
========== Purpose ==========
Function will return a vector
containing the file line vectors
====================================================
*/
std::vector<std::vector<int>> parseLine(std::tuple<std::string, std::string> test){
    std::string str1 = std::get<0>(test);
    std::string str2 = std::get<1>(test);
    
    // line 1 vector
    std::vector<int> retmp;
    // line 2 vector
    std::vector<int> retmp2;

    // container for other vectors
    std::istringstream stm(str1);
    std::istringstream stm2(str2);
    int value;
    while(stm >> value){
        retmp.push_back(value);
    }
    while(stm2 >> value){
        retmp2.push_back(value);
    }
    
    std::vector<std::vector <int>> tmp{ {retmp},
                                        {retmp2}};

    return tmp;
}

/*
====================================================
Function: getQuantums
--
Arguments: std::tuple<std::string, std::string>
--
Return type: vector
========== Purpose ==========
Take a tuple, use values from vector in tuple to 
use as quantum values
====================================================
*/
std::vector<int> getQuantums(std::tuple<std::string, std::string> q_times){
    std::vector<std::vector<int>> testerInts = parseLine(q_times);
    std::vector<int> test;
    // can't have time of 0
    for (int i = 1; i < 1; i++){
        for(int j = 0; j < testerInts[i].size(); j++)
            std::cout <<  testerInts[i][j];
                test.push_back(i);
    }
    return test;
}

/*
====================================================
Function: NormTAT
--
Arguments: String Filname
Normalized TAT = TAT/Service Time
--
Return type: None(void)
========== Purpose ==========
Function will return the Normalized Turnaround time
====================================================
*/
void NormTAT(std::string filename){

}

/*
====================================================
Function: calcAWT
--
Arguments: int processes[],int counter,int burstTime[],int q
--
Return type: None (void)
            
========== Purpose ==========
This function will calculate the
Turnaround Time
====================================================
*/
void calcAWT(int processes[],int counter,int burstTime[],int q){
    int waitTime[counter], TAT[counter];
    int totalWait = 0, totalTAT = 0;

    // call function for the waiting time
    calcWaitTime(processes, counter, burstTime, waitTime, q);

    // call function for the for Turnaround Time
    calcTAT(processes, counter, burstTime, waitTime, TAT);

    std::cout << "Process # " << " Burst Time "
            << " Waiting Time " << " Turnaround Time\n";

    for (int i = 0; i < counter; i++){
        totalWait = totalWait + waitTime[i];
        totalTAT = totalTAT + TAT[i];

        std::cout << " " << i+1 << "\t\t" << burstTime[i] <<"\t "
        << waitTime[i] <<"\t\t " << TAT[i] << std::endl;

    }
    // display the average times
    std::cout << "\nAverage Waiting Time: " << (float)totalWait / (float)counter << std::endl;
    std::cout << "Average Turnaround Time: " << (float)totalTAT / (float)counter << std::endl;

}


/*
====================================================
Function: Main
--
Arguments: None
--
Return Type: None (0)
========== Purpose ==========
To provided a driver for the functions above
====================================================
*/

int main()
{
    std::tuple<std::string, std::string> q_tuple = getLine("sample.txt");
    std::vector<int> results = getQuantums(q_tuple);
    // process array
    int processes[] = {1, 2, 3};
    int q_timeMax = 2;
    int counter = sizeof processes / sizeof processes[0];
    // burst time array
    int burstTime[] = {10, 5, 8};
    std::cout << "=================== Report Started ===================  \n";
    
    for (int i = 0; i < q_timeMax; i++){
        std::cout << results[i] << std::endl;
        std::cout << " =================== Quantum #" << results[i] << 
        " ======================= " << std::endl;
        calcAWT(processes, counter, burstTime, results[i]); 
        std::cout << " =================== End Quantum #" << results[i] << 
        " =================== \n" << std::endl;
    }
}