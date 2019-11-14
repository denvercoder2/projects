// Ryan Davis
// CS-490
// Homework 4
/*

Design, code and test a simulation of the Round Robin scheduling algorithm.  
Use it to test the effect of quantum size on performance.  
In particular you will be demonstrating Stalling�s guideline that quantum size should be 
a little larger than the time required for a �typical� interaction or process function. 
In other words, ideally a process will terminate or block itself before it is preempted.
Write the program in C++

*/

#include <iostream>
#include <vector>
#include <string>
#include <fstream>
#include <time.h>
#include <iomanip>
#include <queue>
#include <list>
#include <deque>

using namespace std;


class ProcessControlBlock
{
public:
	int processID = 0;
	int arrivalTime = 0;
	int serviceTime = 0;
	int CPUtime = 0;
	int completedTime = 0;
	int TAT = 0;
	int NTAT = 0;
	int numOfContextSwitches = 0;

	ProcessControlBlock(int id, int aTime, int sTime, int cTime)
	{
		processID = id;
		arrivalTime = aTime;
		serviceTime = sTime;
		CPUtime = cTime;
		completedTime = 0;
		int numOfContextSwitches = 0;
	}

	void print()
	{
		//ofstream outFile;
		//outFile.open("outputFile.txt");
		
		cout << "Process ID: " << processID << endl;
		cout << "Arrival Time: " << arrivalTime << endl;
		cout << "Service Time: " << serviceTime << endl;
		cout << "CPU Time: " << CPUtime << endl;
		cout << "\n";
		cout << "TAT: " << TAT << endl;
		cout << "Normalized TAT: " << NTAT <<  endl;
		cout << "\n\n";
		
	}

	void calcTAT(int clockTime)
	{
		TAT = clockTime - arrivalTime;
	}

	void calcNTAT()
	{
		NTAT = TAT / serviceTime;
	}
};



int main()
{
	//----------------------------------------------
	// Variables
	int clock = 0;
	int quantum1, quantum2;
	int servTime = 0, timeRemaining = 0, timeGiven = 0, increment = 0;
	int numShort = 0, numMedium = 0, numLong = 0;
	int numProcesses = 0, overallProcesses = 0, avgTAT = 0, avgNTAT = 0;
	queue <ProcessControlBlock> myQ;
	queue <ProcessControlBlock> myQ2;
	ProcessControlBlock* process1;
	vector <ProcessControlBlock> myVector;
	vector <ProcessControlBlock> myVector2;
	string fileName;
	ifstream inputFile(fileName);
	ofstream outFile;
	outFile.open("outputFile.txt");
	//----------------------------------------------


	//----------------------------------------------
	// Ask the user for input
	cout << "Enter the file name: ";
	cin >> fileName;
	inputFile.open(fileName.c_str());
	//----------------------------------------------


	//----------------------------------------------
	// if the file cant be open throw this statement
	if (!inputFile)
	{
		cout << "unable to open file." << endl;
		exit(1);
	}
	//----------------------------------------------


	//----------------------------------------------
	// Getting the quantum numbers 
	inputFile >> quantum1;
	inputFile >> quantum2;
	increment = 0;
	//----------------------------------------------

	//----------------------------------------------
	// while file is not at eof then
	while (!inputFile.eof())
	{	
		inputFile >> servTime;
		process1 = new ProcessControlBlock(increment, 0, servTime, 0);
		myQ.push(*process1);
		process1 = new ProcessControlBlock(increment, 0, servTime, 0);
		myQ2.push(*process1);
		increment++;
	}
	//----------------------------------------------



	outFile << "Data set 1" << endl;
	outFile << "Results for first 15 processes || Quantum: " << quantum1 << endl;
	outFile << setw(10) << "PID" << setw(10) << "Arrival" << setw(10) << "Service" << setw(10) << "CPU" << setw(10)
		<< "Departure" << setw(10) << "TAT" << setw(10)
		<< "NTAT" << setw(10) << "Class" << endl;
	outFile << "\n";

	//----------------------------------------------
	int counter = 0;
	while (!myQ.empty())
	{
		process1 = &myQ.front();
		timeRemaining = process1->serviceTime - process1->CPUtime;

		if (timeRemaining >= quantum1)
		{
			timeGiven = quantum1;
		}

		else
		{
			timeGiven = timeRemaining;
		}

		process1->CPUtime += timeGiven;
		clock = clock + timeGiven;

		// if the cpu time is equal to service time check to see if
		// cpu time is greater than or eqaul to 0 and if 
		// the process id is less than or equal to 14
		if (process1->CPUtime == process1->serviceTime)
		{
			process1->calcTAT(clock);
			process1->calcNTAT();
			while (process1->processID >= 0 && process1->processID < 15)
			{
				outFile << setw(10) << process1->processID << setw(10) << process1->arrivalTime
					<< setw(10) << process1->serviceTime << setw(10) << process1->CPUtime
					<< setw(10) << clock << setw(10) << process1->TAT
					<< setw(10) << process1->NTAT;
				//process1->print();

				if (process1->numOfContextSwitches == 0)
				{
					outFile << setw(10) << "short" << endl;
					numShort++;
				}

				else if (process1->numOfContextSwitches == 1)
				{
					outFile << setw(10) << "medium" << endl;
					numMedium++;
				}

				else
				{
					outFile << setw(10) << "long" << endl;
					numLong++;
				}
				numProcesses++;
			}
			overallProcesses++;
			myVector.push_back(*process1);
			myQ.pop();
			
		}

		else
		{
			process1->numOfContextSwitches++;
			myQ.pop();
			myQ.push(*process1);
		}
		
	}

	// gettin the avg TAT
	// getting the avg NTAT
	for (int i = 0; i < myVector.size(); i++)
	{
		myVector.at(i).TAT;
		avgTAT += myVector.at(i).TAT;

		myVector.at(i).NTAT;
		avgNTAT += myVector.at(i).NTAT;
	}

	outFile << "\n";
	outFile << setw(10) << "Number of clock tics: " << clock << endl;
	outFile << "\n";


	outFile << "Number of Shorts: " << numShort << endl;
	outFile << "Number of Mediums: " << numMedium << endl;
	outFile << "Number of Longs: " << numLong << "\n";
	outFile << "Number of Processes: " << numProcesses << endl;
	outFile << "Average TAT: " << avgTAT / overallProcesses << endl;
	outFile << "Average NTAT: " << avgNTAT / overallProcesses << endl;
	outFile << "System: " << overallProcesses << "\n\n";
	//----------------------------------------------
	clock = 0;
	numShort = 0;
	numMedium = 0;
	numLong = 0;
	numProcesses = 0;
	overallProcesses = 0;
	avgTAT = 0;
	avgNTAT = 0;

	outFile << "Data set 2" << endl;
	outFile << "Results for last 15 processes || Quantum: " << quantum2 << endl;
	outFile << setw(10) << "PID" << setw(10) << "Arrival" << setw(10) << "Service" << setw(10) << "CPU" << setw(10) 
		<< "Departure" << setw(10) << "TAT" << setw(10)
		<< "NTAT" << setw(10) << "Class" << endl;
	outFile << "\n";
	
	while (!myQ2.empty())
	{
		process1 = &myQ2.front();
		timeRemaining = process1->serviceTime - process1->CPUtime;

		if (timeRemaining >= quantum2)
		{
			timeGiven = quantum2;
		}

		else
		{
			timeGiven = timeRemaining;
		}

		process1->CPUtime += timeGiven;
		clock = clock + timeGiven;

		// if the cpu time is equal to service time check to see if
		// cpu time is greater than or eqaul to 0 and if 
		// the process id is less than or equal to 14
		if (process1->CPUtime == process1->serviceTime)
		{
			process1->calcTAT(clock);
			process1->calcNTAT();
			if (process1->processID >= 0)
			{
				outFile << setw(10) << process1->processID << setw(10) << process1->arrivalTime
					<< setw(10) << process1->serviceTime << setw(10) << process1->CPUtime
					<< setw(10) << clock << setw(10) << process1->TAT
					<< setw(10) << process1->NTAT;


				if (process1->numOfContextSwitches == 0)
				{
					outFile << setw(10) << "short" << endl;
					numShort++;
				}

				else if (process1->numOfContextSwitches == 1)
				{
					outFile << setw(10) << "medium" << endl;
					numMedium++;
				}

				else
				{
					outFile << setw(10) << "long" << endl;
					numLong++;
				}
				numProcesses++;
			}
			overallProcesses++;
			myVector2.push_back(*process1);
			myQ2.pop();
		}


		else
		{
			process1->numOfContextSwitches++;
			myQ2.pop();
			myQ2.push(*process1);
		}
	}

	for (int i = 0; i < myVector2.size(); i++)
	{
		myVector2.at(i).TAT;
		avgTAT += myVector2.at(i).TAT;

		myVector2.at(i).NTAT;
		avgNTAT += myVector2.at(i).NTAT;
	}

	outFile << "\n";
	outFile << setw(10) << "Number of clock tics: " << clock << endl;
	outFile << "\n";

	outFile << "Number of Shorts: " << numShort << endl;
	outFile << "Number of Mediums: " << numMedium << endl;
	outFile << "Number of Longs: " << numLong << endl;
	outFile << "Number of Processes: " << numProcesses << endl;
	outFile << "Average TAT: " << avgTAT / overallProcesses << endl;
	outFile << "Average NTAT: " << avgNTAT / overallProcesses << endl;
	outFile << "System: " << overallProcesses << endl;
	
	
	//system("pause");
	return 0;

}