//***************************************
// Program Title: Score Calculator
// Project File: Project_06.cpp
// Name: Ivan Fontane
// Course Section: CPE-211-01
// Lab Section: 3
// Due Date: 10/04/2019
// Program Description: STUFF
// on the input file
//***************************************

#include <iomanip>
#include <fstream>
#include <string>
#include <iostream>

using namespace std;

// currently will open file if possible and read lines
int main(int argc, char* argv[])
{
    if (argc < 2){
        cout << "You didn't give enough arguments" << endl;
        exit(1);
    }
    
    for (int i = 1; i < argc; i++){ // i=1, assuming files arguments are right after the executable
        string fn = argv[i]; //filename
        // cout << fn;
        fstream infile;
        infile.open(fn);
        if (infile.is_open()){
            string line1;
            getline(infile, line1);
            cout << "\n\n" << line1 << endl;

            string line2;
            getline(infile, line2);
            cout << "\n" << line2 << endl;

            string line3;
            getline(infile, line3);
            cout << "\n" << line3 << endl;

            string line4;
            getline(infile, line4);
            cout << "\n" << line4 << endl;
        }
        infile.close();
    }
}