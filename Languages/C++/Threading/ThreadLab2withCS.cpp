 
//ThreadLab2withCS.cpp - Simple Looping Example with Critical Sections

#include <windows.h>
#include <cstdlib>
#include <iostream>
using namespace std;


// Four threads repeatedly increment the same global variable.
// To get inconsistent results, the number of iterations must be large
// enough to force the thread to timeout before it completes.

volatile int  tally;   // Parent process's global data
CRITICAL_SECTION cs;    // Declare a critical section

// The volatile modifier prevents the compiler from applying optimizations
// to the variable "tally". For example, if the value of "tally" is held in a
// register instead of stored back to memory after each iteration, it will 
// behave like a local variable during execution of the loop. Make it a 
// practice to declare global data this way if it is to be to be shared by 
// multiple threads, 

void AddThread(int iterations)
{

  
INT i;
INT x;
EnterCriticalSection(&cs);
for (i = 0; i < iterations; i++)
{   
	
	x = tally;
	x++;
	tally = x;
	
	}
LeaveCriticalSection(&cs);
}

const  INT numThreads = 4;

int main()
{
  HANDLE ThreadHandles[numThreads];
  DWORD ThreadID;
  INT i;

   tally = 0;
   InitializeCriticalSection(&cs);
 
 for (i = 0; i<numThreads; i++)
 {
  // Create a set of concurrent threads and pass each a parameter: 10,000,000)

   ThreadHandles[i] = CreateThread( 0,0, (LPTHREAD_START_ROUTINE) AddThread,
	   (VOID*) 100, 0, &ThreadID);
 }

   
  // Wait for all threads to finish execution

   WaitForMultipleObjects(numThreads, ThreadHandles, TRUE, INFINITE);

  
   cout << "Final value of tally is " << tally << "\n";
   DeleteCriticalSection(&cs);

   system("pause");
}


