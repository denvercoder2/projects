//ThreadLab1 

#include <windows.h>
#include <cstdlib>
#include <iostream>
using namespace std;

volatile int  A, B;   // Parent process's global data

// The 'volatile' modifier prevents the compiler from applying optimizations
// to the variables "A" and "B". It's a good idea to get in the habit of
// declaring global data this way if it will be shared by multiple threads, 

void ThreadOne()
{
  int temp;

  Sleep(10);       // Sleep(t) blocks a thread for t milliseconds 
  
  temp = A;
  temp++;
  A = temp;
 }

void ThreadTwo()
{
 int temp;

//Sleep(10);
  temp = B;
  temp--;
  B = temp; 
 
  A = B;
}

void main(void)

  HANDLE ThreadHandles[2];            // A handle is a pointer to an object
  DWORD ThreadOneID, ThreadTwoID;     // A thread has an id as well as a handle
                                         
   A = 0;			     // initialize global data
   B = 3;  
   
   //Create first thread, using CreateThread system call. Save handle.
   //CreateThread creates a new thread in the parent process 
   //and returns a handle to thethread (or 0 if there is an error). 
   //Parameters are explained below.

   ThreadHandles[0] = CreateThread      
      (0,                                // security attributes (0 is the default) 
       0,                                // initial stack size (0 defaults to 
					 //parent's stack size) 
      (LPTHREAD_START_ROUTINE) ThreadOne,// names the thread to be created
       0,                                // a 4-byte value used to pass parameters   
       0,                                // 0 or CREATE_SUSPEND, which blocks the 
                                         // thread untilanother thread unsuspends 
					 // it with ResumeThread
       &ThreadOneID);                    // CreateThread returns thread ID & handle
  //Create second thread
   ThreadHandles[1] = CreateThread( 0,0,(LPTHREAD_START_ROUTINE) ThreadTwo, 0,0, &ThreadTwoID);

   WaitForMultipleObjects               // Wait for all threads to finish execution
	(2,                             // Number of objects to wait for
	 ThreadHandles,                 // Handles of objects to wait for (an array) 
	 TRUE,                          // TRUE => wait for ALL, otherwise, for any one
	 INFINITE);                     // maximum wait time (in millisseconds)

   cout << "Value of A: " << A << "\n";
   cout << "Value of B: " << B << "\n";

   system("pause");
}


