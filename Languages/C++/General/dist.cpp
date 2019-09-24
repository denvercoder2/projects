#include<iostream>
#include<fstream>

/*
Purpose:
    Calculate the bills for the month
*/
using namespace std;



/*
Function Name: Rent
Purpose: Return persons ratio of rent
Parameters: Float x
Variables:
Scale = the percent each person pays
*/
float Rent(float x){
    float scale = .523;
    return x * scale;
}

/*
Function Name: h2o
Purpose: Return persons ratio of water bill
Parameters: integer y
Variables:
Scale = the percent each person pays
*/
int h2o(int y){
    double scale = .5;
    return y * scale;
}


/*
Function Name: Utilities
Purpose: Return persons ratio of utility bill
Parameters: Float z
Variables:
Scale = the percent each person pays
*/

float Utilities(float z){
    double scale = .5;
    return z * scale;
}



/*
Function Name: sum_bills
Purpose: Returns the sum of bills
Parameters: two ints and a float
Variables:
Scale = the percent each person pays
*/
float sum_bill(int y, float z, int w){
    return y + z + w;
}



/*
Function Name: report 
Purpose: Write the report
Parameters: None
Variables:
Scale = the percent each person pays
*/
void report(){
    int Rent_total = 785;
    // !!!
    int Util_total = 185;
    int water = 40;
    int internet = 90;
    
    ofstream myfile;
    myfile.open("output.txt");


    myfile << "\n------------- Bill Breakdown -------------\n";
    myfile << "\nRent Bill for Scott is: " <<  Rent(785.00) << "\n";
    myfile << "\nRent Bill for Roy is: " << 785 - Rent(785.00) << "\n";
    myfile << "-------------------------------------------------------";

    myfile << "\nUtilities Bill for Scott is: " << Utilities(Util_total) << "\n";
    myfile << "\nUtilities Bill for Roy is: " <<  Utilities(Util_total) << "\n";

    myfile << "-------------------------------------------------------";
    
    myfile << "\nWater Bill for Scott is: " << h2o(40) << "\n";
    myfile << "\nWater Bill for Roy is: " << water - h2o(40) << "\n";

    myfile << "-------------------------------------------------------";

    myfile << "\nInternet Bill for Scott is: " << internet - 35 << "\n";
    myfile << "\nInternet Bill for Roy is: " << internet - 55 << "\n";

    myfile << "-------------------------------------------------------";
        
    // when the internet is added as a bill, add 90 to the total, and subtract 90 from roys total
    float Scott_total = sum_bill(Rent(785), h2o(40), Utilities(Util_total) + 55);
    int complete_total = 785 + 40 + Util_total + internet;
    int royTotal = int(complete_total - Scott_total);
    myfile << "\nTotal Bills for this month: " << complete_total << "\n";
    myfile << "\n\n------------- Split -------------\n\n";
    myfile << "\nTotal Bill amount for Scott (Rounded): " << int(Scott_total) << "\n";
    myfile << "\nTotal Bill amount for Roy (Rounded): " <<   royTotal;
    myfile << "\n35 dollars from your total is for your portion of the internet, so you give me: " << royTotal - 35; 

    myfile << "\n-------------------------------------------------------\n";


    myfile.close();

        
}
int main(){
    report();    
}

