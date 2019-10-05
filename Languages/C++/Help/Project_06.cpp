//***************************************
// Program Title: Score Calculator
// Project File: Project_06.cpp
// Name: Ivan Fontane
// Course Section: CPE-211-01
// Lab Section: 3
// Due Date: 10/04/2019
// Program Description: Read in the scores from the file
// and pass the totals back out to an output file
// on the input file
//***************************************

#include <iomanip>
#include <fstream>
#include <string>
#include <iostream>

using namespace std;

// command line argument requirement
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
    if (argc != 3){
        cout << "You didn't give enough arguments" << endl;
        exit(1);
    }
    
    for (int i = 1; i < argc; i++){ 
        string fn_in = argv[i]; //filename input
        string fn_out = argv[2];
        // cout << fn;
        fstream infile;
        fstream outfile;
        infile.open(fn_in);
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
        

    // check that file exists and can open
    if(!infile){
        cout<<string(15,'*')<<" File Open Error"<<string(15,'*')<<endl;
        cout<<"==> Input file failed to open properly!!\n";
        cout<<"==> Attempted to open file: "<< fn_in <<endl;
        cout<<"==> Terminating program!!!\n";
        cout<<string(47,'*')<<endl;
    }
    // error check for if file can't open 
    if(!outfile){
    outfile.clear();
    cout<<string(15,'*')<<" File Open Error"<<string(15,'*')<<endl;
    cout<<"==> Output file failed to open prperly!!\n";
    cout<<"==> Attempted to open file: "<< fn_out <<endl;
    cout<<"==> Terminating program!!!\n";
    cout<<string(47,'*')<<endl;
        }

        infile.close();
        outfile.close();
    }
}

