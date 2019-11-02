#include <iostream>
#include <fstream>
#include <sstream> 
#include <string>
#include <vector>

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

std::string getLine(std::string filename){
    std::ifstream infile (filename);

    std::string str;
    if (infile){

        while(std::getline(infile, str)){
            // if lines are present in the file
            if(str.length()){
                std::cout << str << std::endl;
            }
        }
    }
    else{
        // error check if file can't be opened
        std::cout << "File could not be opened" << std::endl;
    }
    return str;
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
Function: std::vector<int> getQuantums
--
Arguments: String Filname
--
Return type: vector
========== Purpose ==========
Function will gather file contents to store in vector
====================================================
*/
std::vector<int> getQuantums()
{
    /*
    Read in the quantum values from the file
    Put them as indexes into the vector using
    test.push_back()
    */
    
    // this will be dynamic in the near future
    int limit = 15;
    std::vector<int> test{};
    
    for(int i = 1; i < limit; i++){
        test.push_back(i);
    }

    return test;
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
    std::vector<int> results = getQuantums();
    // process array
    int processes[] = {1, 2, 3};
    int counter = sizeof processes / sizeof processes[0];
    // burst time array
    int burstTime[] = {10, 5, 8};
    std::cout << "=================== Report Started ===================  \n";
    
    for (int i = 0; i < results.size(); i++){
        std::cout << results[i] << std::endl;
        std::cout << " =================== Quantum #" << results[i] << 
        " ======================= " << std::endl;
        calcAWT(processes, counter, burstTime, results[i]); 
        std::cout << " =================== End Quantum #" << results[i] << 
        " =================== \n" << std::endl;
    }
}