// ****************************************
// Program Title: Project_06
// Project File: Project_06.cpp
// Name: Ivan Fontane 
// Course Section: CPE-211-01 
// Lab Section: 4 
// Due Date: 10/06/16 
// Program Description:
// ****************************************
#include <iostream>
#include <iomanip>
#include <string>
#include <fstream>

using namespace std;
int main(int argc, char *argv[])
	{
		ifstream InFile;
		ofstream OutFile;

		string command = argv[0];
		string file = argv[1];
		string output = argv[2];

		int numargs = argc;
		if(numargs != 3)
		{	
			cout << "Incorrect number of command line arguments provided." << endl;
			cout << "This program requires 2 command line arguments:" << endl;
			cout << "An input filename and an output filename:" << endl;
			cout << " " << endl;
			cout << "Program usage is:" << endl;
			cout << "./Project_06 InputFileName OutputFileName" << endl;
			return 0;
		}
		
		InFile.open(file.c_str());

		cout << " " << endl;
		cout << "Opening Input File: " << file << endl;
		cout << " " << endl;

		while(InFile.fail())
		{
			cout << "*************** File Open Error ***************" << endl;
			cout << "==> Input file failed to open properly!!" << endl;
			cout << "==> Attempted to open file: " << file << endl;	
			cout << "==> Please try again..." << endl;
			cout << "***********************************************" << endl;
			cout << " " << endl;				
			cout << "Enter the name of the input file: ";
			cin >> file;
			cout << file << endl;
			cout << " " << endl;
			InFile.open(file.c_str());
		}
		
		OutFile.open(output.c_str());
		
		cout << " " << endl;
		cout << "Opening Output File: " << output << endl;
		cout << " " << endl;

		while(OutFile.fail())
		{
			cout << "*************** File Open Error ***************" << endl;
			cout << "==> Output file failed to open properly!!" << endl;
			cout << "==> Attempted to open file: " << file << endl;	
			cout << "==> Please try again..." << endl;
			cout << "***********************************************" << endl;
			cout << " " << endl;				
			cout << "Enter the name of the Output file: ";
			cin >> output;
			cout << output << endl;
			cout << " " << endl;
			OutFile.open(output.c_str());
		}

		int quiznum;
		int hwnum;
		int examnum;
		int average;
		
		InFile >> quiznum;
		InFile >> hwnum;
		InFile >> examnum;
		
		string Key1;
		string Key2;
		int KeyQuiz;
		int KeyHW;
		int KeyExam;
		int KeyTotal;
		double KeyAverage;

		InFile >> Key1;
		InFile >> Key2;

		int i;
		int x;

		for(i = 0; i < quiznum; i++)
		{
			InFile >> x;
			KeyQuiz = x + x;
		}		
		
		for(i = 0; i < hwnum; i++)
		{
			InFile >> x;
			KeyHW = x + x;
		}
		
		for(i = 0; i < examnum; i++)
		{
			InFile >> x;
			KeyExam = x + x;

		}
		cout << "KeyQuiz score: " << KeyQuiz << endl;
		cout << "KeyHW score: " <<KeyHW << endl;
		cout << "KeyExam score: " << KeyExam << endl;	


		KeyTotal = KeyQuiz + KeyExam + KeyHW;
		KeyAverage = KeyTotal / 3;

		
		
		OutFile << left << setw(3) << "#" << setw(12) << "Last" << setw(7) << "First" 
		<< setw(6) << "Quiz" << setw(6) << "HW" << setw(6) << "Exam" << setw(7) << "Total" << setw(9) << "Average" << endl;
		OutFile << left << setw(3) << Key1 << setw(12) << "          " << setw(7) << Key2
		<< setw(6) << quiznum << setw(6) << hwnum << setw(6) << examnum << setw(7) << KeyTotal << setw(9) << KeyAverage << endl;
		
		

	 return 0;
	}
