// Interest program
#include <iostream>
#include <iomanip>
#include <cmath>

using namespace std;
int main()
{
    // declaring the month and day variables
    double NMonth = 12.00;
    double NDay = 365.00;
    double EulerNum = 2.71828;
    
    // getting the principle value
    double principle;
    cout << "Enter the starting balance: ";
    cin >> principle;
    cout << principle << endl;
    
    // getting the interest rate
    double interest;
    cout << "Enter the interest rate: ";
    cin >> interest;
    cout << interest << endl;
    
    // getting the years
    double years;
    cout << "Input the number of years: ";
    cin >> years;
    cout << fixed << setprecision (2) << years << " years ";
    
    // formulas
    double simple_interest = principle * (1 + years * (interest / 100));
    double compound_interest = principle * pow(1 + (interest/100), years);
    double Reff_monthly = pow(1 + ((interest/100)/NMonth), NMonth * years) - 1 / years;  
    double eff_simple_interest = principle * (1 + years * Reff_monthly);
    double compound_cont = principle * pow(EulerNum, (interest/100) * years);
    double compound_cont_rate = (pow(EulerNum, (interest/100) * years) - 1)
    / years * 100;
    // formulas end
    
    cout << "\n\nFor a principle of $" << principle <<
    "\nat a interest rate of " << interest << "%\nfor a period " 
    << years << " years, \nthe final account balance would be: \n";
    
    // simple Interest
    cout << "\nSimple Interest: " << "\n\tBalance = " << simple_interest << "\n";
    
    // compound monthly
    cout << "\nCompound Monthly: \n\t" << "Balance = $" << compound_cont;
    cout << "\n\tThe Effective Simple Interest Rate: %" << compound_cont_rate;
    cout << "\n\tBalance using Simple Interest at the Effective Rate: $"  << compound_cont;
    // compound daily
    cout << "\n\nCompound Daily" <<"\n\tBalance = " << compound_cont;
    cout << "\n\tThe Effective Simple Interest Rate: %" << compound_cont_rate;
    cout << "\n\tBalance using Simple Interest at the Effective Rate: $"  << compound_cont;

    // compound continuosly
    cout << "\n\nCompound Continuosly" <<"\n\tBalance = " << compound_cont;
    cout << "\n\tThe Effective Simple Interest Rate: %" << compound_cont_rate;
    cout << "\n\tBalance using Simple Interest at the Effective Rate: $"  << compound_cont;
    return 0;
    } 