//****************************************
// Program Title: Interest Compounding Methods  
// Project File: Project_03.cpp
// Name: Ivan Fontane
// Course Section: CPE-211-01
// Lab Section: 3
// Due Date: 09/10/19
// program description: Calculates compound interest over time
// Computes Compound Interest (DAILY, MONTHLY, YEARLY)
//***************************************
#include <iostream> // For input/output manipulation
#include <iomanip> // For setw() and setprecision()
#include <cmath> //For sqrt() and fabs()

using namespace std;

int main()
{
// Declaring the Month and Day Variables
// Declaring a Euler variable for use in formulas
double NMonth = 12.00;
double NDay = 365.00;
double EulerNum = 2.71828;

//Getting the Principle Value

double principle;
cout<<"Input the starting balance: ";
cin>> principle;
cout << principle << endl;

// Getting the Interest Rate

double interest;
cout << "Input the interest rate(Ex: 5 for 5%): ";
cin>> interest;
cout << interest << endl;

//Getting The Years

double years;
cout << "Input the number of years: ";
cin>> years;
cout << fixed << setprecision(2) << years;

//Formulas
double simple_interest = principle * (1 + years * (interest/100));
double compound_interest_day = principle * pow(1+(interest/100)/NDay, NDay*years);
double compound_interest_day_rate = (pow(1+(interest/100)/NDay, NDay*years)-1)/ years*100;
double compound_interest_month = principle * pow(1+(interest/100)/NMonth, NMonth * years);
double compound_interest_month_rate = (pow(1+(interest/100)/NMonth, NMonth*years)-1)/ years*100;
double compound_cont = principle * pow(EulerNum, (interest/100)*years);
double compound_cont_rate = (pow(EulerNum, (interest/100)*years) -1)/years*100;
//Formulas End

cout << "\n\nFor a principle of $" <<principle <<
"\nat a interest rate of: " << interest << "%\nfor a period "
<< years << " years, \nthe final account balance would be: \n";

// Simple Interest

cout << "\nSimple Interest: " <<"\n\tBalance = " << simple_interest << "\n";

//Compound Monthly

cout << "\nCompound Monthly: \n\t" << "Balance = $" << compound_interest_month;
cout << "\n\tThe Effective Simple Interest Rate: %" << compound_interest_month_rate;
cout << "\n\tBalance using Simple Interest at the Effective Rate: $"<<compound_interest_month;

//Compound Daily

cout << "\n\nCompound Daily" <<"\n\tBalance = " << compound_interest_day;
cout << "\n\tThe Effective Simple Interest Rate: %" << compound_interest_day_rate;
cout << "\n\tBalance using Simple Interest at the Effective Rate: $"  << compound_interest_day;

// Compound Continuosly

cout << "\n\nCompound Continuosly" <<"\n\tBalance = " << compound_cont;
cout << "\n\tThe Effective Simple Interest Rate: %" << compound_cont_rate;
cout << "\n\tBalance using Simple Interest at the Effective Rate: $"  << compound_cont;
   
return 0;
}
