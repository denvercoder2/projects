//***************************************
// Program Title: Shipping Calculation  
// Project File: Project_05.cpp
// Name: Ivan Fontane
// Course Section: CPE-211-01
// Lab Section: 3
// Due Date: 09/25/2019
// Program Description: Calculate the shipping cost of a given package based
// on the input file 
//***************************************
#include<iomanip>
#include<fstream>
#include<iostream>
#include<string>

using namespace std;

int main(){

    // declaring variables to compare the type of package
    // against per requirement
    string parcel = "parcel";
    string bulk = "bulk";
    string media = "media";
    float base_rate;
    float length_adj;
    float weight_adj;
    // double cost = (base_rate) * (length_adj) * (weight_adj); 
    int totalLength;
    
    // create file object and do conditional check
    // for if the file doesn't exist
    ifstream inFile;
    inFile.open("P5_in3.txt");
    if(!inFile){
        cout << "The selected file does not exist";
        exit(1);
    }

    //  L, W, H, Weight
    if (inFile.is_open()){
        // ignore line 1
        string line1;
        getline(inFile, line1);

        // type
        string line2;
        getline(inFile, line2);
        if (line2 == parcel){
            base_rate = 2.25;
        }
        else if (line2 == media){
            base_rate = 3.50;
        }
        else if (line2 == bulk){
            base_rate = 4.75;
        }
        else{
            cout << "Package type is not correct" << endl;
            exit(1);
        }
    
        string line3;
        getline(inFile, line3);
        string line4;
        getline(inFile, line4);
        string line5;
        getline(inFile, line5);
        string line6;
        getline(inFile, line6);
        int newLength = stoi(line3);
        int newWidth =  stoi(line4);
        int newHeight = stoi(line5);
        int newWeight = stoi(line6);

        // calculate the total length 
        totalLength = newWeight + newHeight + newLength;
        if (totalLength < 40 && totalLength > 0){
            length_adj = 1.0;
        }
        else if (totalLength >= 40 && totalLength < 60){
            length_adj = 2.50;
        }
        else if (totalLength >= 60){
            length_adj = 3.75;
        }
        else {
            cout << "Length is invalid" << endl;
        }

        // calculate and set the newWeight as well as the weight adjusted
        if (newWeight < 10 && newWeight > 0){
            weight_adj = 1.00;
        }
        else if (newWeight >= 10 && newWeight < 25){
            weight_adj = 3.0;
        }
        else if(newWeight >= 25){
            weight_adj = 4.50;
        }
        else {
            cout << "Weight is not valid" << endl;
        }

        double cost = (base_rate) * (length_adj) * (weight_adj); 
        cout << "$" << cost << endl;



    // breakpoint
    std::cin.get();

    return 0;
    }
}