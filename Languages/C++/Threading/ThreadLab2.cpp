 
//ThreadLab2.cpp - Simple Looping Example

#include <windows.h>
#include <cstdlib>
#include <iostream>
using namespace std;


// Four threads repeatedly increment the same global variable.
// To get inconsistent results, the number of iterations must be large
// enough to force a thread to timeout before it completes.

volatile int  tally;   // Parent process's global data

// The volatile modifier prevents the compiler from applying optimizations
// to the variable "tally". For example, if the value of "tally" is held in a
// register instead of stored back to memory after each iteration, it will 
// behave like a local variable during execution of the loop. Make it a 
// practice to declare global data this way if it is to be to be shared by 
// multiple threads, 

void AddThread(int iterations)
{
  
 int i;
 int x;

for (i = 0; i < iterations; i++)
{
	x = tally;
	x = x + 1;
	tally = x;
	}

}

const  INT numThreads = 4;

void main(void)
{
  HANDLE ThreadHandles[numThreads];
  DWORD ThreadID;
  INT i;

   tally = 0;
 
 for (i = 0; i<numThreads; i++)
 {
  // Create a set of identical concurrent threads and pass each a parameter:
  
  cout << "creating Thread " << i << "\n";

  ThreadHandles[i] = CreateThread( 0,0, (LPTHREAD_START_ROUTINE) AddThread,  
    (VOID*) 100, 0, &ThreadID);

 }

   
  // Wait for all threads to finish execution

   WaitForMultipleObjects(numThreads, ThreadHandles, TRUE, INFINITE);

  
   cout << "Final value of tally is " << tally << "\n";
   system ("pause");

}


