#include<iostream>
#include<fstream>

using namespace std;

float Rent(float x){
    float scale = .523;
    return x * scale;
}

int h2o(int y){
    double scale = .5;
    return y * scale;
}

float Utilities(float z){
    double scale = .5;
    return z * scale;
}

int web(int w){
    int r = 35;
    return w - r;
}

float sum_bill(float x, int y, float z, int w){
    return x + y + z + w;
}

void report(){
    int Rent_total = 785;
    int Util_total;
    int water = 40;
    int internet;
    cout << "What was the total utility bill?: \n";
    cin >> Util_total; 
    cout << "\nRent Bill for Scott is: " <<  Rent(785.00) << "\n";
    cout << "\nRent Bill for Roy is: " << 785 - Rent(785.00) << "\n";
    cout << "-------------------------------------------------------";

    cout << "\nUtilities Bill for Scott is: " << Utilities(Util_total) << "\n";
    cout << "\nUtilities Bill for Roy is: " <<  Utilities(Util_total) << "\n";

    cout << "-------------------------------------------------------";
    
    cout << "\nWater Bill for Scott is: " << h2o(40) << "\n";
    cout << "\nWater Bill for Roy is: " << water - h2o(40) << "\n";

    cout << "-------------------------------------------------------";
    
    cout << "\nInternet Bill for Scott is: " << web(90) << "\n";
    cout << "\nInternet Bill for Roy is: " << 90 - web(90) << "\n";

    cout << "-------------------------------------------------------";
    
    float Scott_total = sum_bill(Rent(785), h2o(40), Utilities(Util_total), web(90));
    int complete_total = 785 + 40 + 90 + Util_total;
    cout << "\nTotal Bill amount for Scott (Rounded): " << int(Scott_total) << "\n";
    cout << "\nTotal Bill amount for Roy (Rounded): " <<   int(complete_total - Scott_total) << "\n";

    cout << "-------------------------------------------------------\n";

}

int main(){
    report();    
}

