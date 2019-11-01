#include <iostream>
#include<string>

/*
=================== Program Overview =================== 
*   Implement the Round Robbin algorithm in C++
*    While calculating and displaying individual
*    and System statistics as mentioned in program
*    requirements. They are as follows:
-------------------------------------------------------------
*    Individual: classification of process.
*    - short (finishes within the first time quantum), 
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
*/


/*
====================================================
Function: calcWaitTime
--
Arguments: int processes[], int counter, int burstTime[],
            int waitTime[], int quantum
--
Return type: None (void)
            
========== Purpose ==========
This function will calculate the
waiting time for all given processes
====================================================
*/
void calcWaitTime(int processes[], int counter, int burstTime[], int waitTime[], int quantum)
{

    // we want something to store the burst times not yet used
    int remaining_burstTime[counter];

    for (int i = 0; i < counter; i++)
    {
        remaining_burstTime[i] = burstTime[i];
    }

    // clocks at 0 initialization
    int e = 0;

    while (true)
    {
        bool fin = true;

        // iterate through the processes
        for (int i = 0; i < counter; i++)
        {
            if (remaining_burstTime > 0)
            {
                fin = false;

                if (remaining_burstTime[i] > quantum)
                {
                    e += quantum;

                    // now decrement the current process by quantum time
                    remaining_burstTime[i] -= quantum;
                }
                else
                {
                    // Show how much time a process has been taken
                    e = e + remaining_burstTime[i];

                    // wait time is measure by current time - time process is going
                    waitTime[i] = e - burstTime[i];

                    // burst time should be 0 if you get to this point
                    // to show that the processes are fully executed
                    remaining_burstTime[i] = 0;
                }
            }
            if (fin == true)
            {
                break;
            }
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


/*
====================================================
Function: calcAWT
--
Arguments: int processes[],int counter,int burstTime[],int quantum
--
Return type: None (void)
            
========== Purpose ==========
This function will calculate the
Turnaround Time
====================================================
*/
void calcAWT(int processes[],int counter,int burstTime[],int quantum){
    int waitTime[counter], TAT[counter];
    int totalWait = 0, totalTAT = 0;

    // call function for the waiting time
    calcWaitTime(processes, counter, burstTime, waitTime, quantum);

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
    std::cout << "Average Waiting Time: " << (float)totalWait / (float)counter;
    std::cout << "Average Turnaround Time: " << (float)totalTAT / (float)counter;

}

/*
====================================================
Function: * getExec
--
Arguments: String Filname
--
Return type: pointer to an integer Array
            
========== Purpose ==========
This function will provide a reference
to an integer array gathered from the input file
====================================================
*/
int* getExec(std::string filename, int n){

    /*
    Read in the file and assign the 
    values in the file as needed
    as indexes of array to use in calculations 
    in main
    */
    
    // open a file and parse to get correct values
    // to throw into this array pointer to return
    int* CPUarr = new int[n]; 
  
    // Some operations on arr[]
    // values of the array get assigned here
    CPUarr[0] = 10; 
    CPUarr[1] = 20; 
  
    return CPUarr; 
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
int main(){
    int processes[] = {1,2,3};
    int counter = sizeof processes / sizeof processes[0];

    // burst time initilization
    int burstTime[] = {10, 5, 8};

    // quantum time initilization
    int quantum = 2;
    
    /*
    using the array above:
    int n = 21;
    
    int* ptr = fun(n); 
    std::cout << ptr[0] << " " << ptr[1]; 
    */

    calcAWT(processes, counter, burstTime, quantum);

    return 0;
}