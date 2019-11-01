#include <iostream>
#include <fstream>
#include <sstream> 
#include <string>

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
void calcWaitTime(int processes[], int counter, int burstTime[], int waitTime[], int q)
{

    // we want something to store the burst times not yet used
    int remaining_burstTime[counter];

    for (int i = 0; i < counter; i++)
    {
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
    std::cout << "Average Waiting Time: " << (float)totalWait / (float)counter << std::endl;
    std::cout << "Average Turnaround Time: " << (float)totalTAT / (float)counter << std::endl;

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
int* getExec(std::string filename,int n){

    /*
    Read in the file and assign the 
    values in the file as needed
    as indexes of array to use in calculations 
    in main
    */


    // variable to check for ints in string
    int* CPUarr = new int[n]; 
    int qchecker;
    int stchecker;
    std::stringstream strs;
    std::string line1, line2;
    std::string temp;
    std::ifstream infile (filename);

    if(infile.is_open()){
        std::cout << "\n\n=====================================================" << "\n";
        std::cout << "Information given from text: " << "\n";
        std::getline(infile, line1);
        std::cout << line1 << std::endl;
        std::getline(infile, line2);
        std::cout << line2 << std::endl;

        for (int i = 0; i < line1.length(); i++){
            if(isdigit(line1[i])){
                std::cout<< line1[i] << std::endl;

            }
        }
           
        std::cout << "\n=====================================================" << "\n\n";

    }

    // creating the stringstream object to hold our line

    // make a dynamic array to be added to
    // via values from the file

    // variable to pull out integers from line


    // Some operations on arr[]
    // values of the array get assigned here
    CPUarr[1] = 10; 
    CPUarr[2] = 50;

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

    // q time initilization
    int q = 2;
        
    int n = 2;
    
    int* ptr = getExec("sample.txt", n); 
    std::cout << ptr[0] << " " << ptr[1] << " " << ptr[2] << std::endl; 

    calcAWT(processes, counter, burstTime, q);

    return 0;
}

