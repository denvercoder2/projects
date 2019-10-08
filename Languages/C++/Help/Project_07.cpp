/*
Project 7 implementation
Helper module, git projects
*/

#include<iostream>
#include<math.h>
#include<stdlib.h>
#include<time.h>

using namespace std;

/*
Function: getInteger() 
Parameters: none(void)
========== Purpose ========== 
Error Correction and Catching
*/
void getInteger(){
    //TBD
}


/*
Function: CalculatePi
Parameters: none (void)
========== Purpose ========== 
Determine an approximation for pi using
the MonteCarlo approximation method
*/
void CalculatePi(){
    // This function needs some work
    // We need to find the max from your prof or assignment
    int kmax = 5;
    int jmax = 2;
    double x, y;
    int hit;
    srand(time(0));
    for (int i = 0; i < kmax; i++){
        hit = 0;
        x = 0;
        y = 0;
        for (int i = 0; i < jmax; i++){
            x  = double(rand())/double(RAND_MAX);
            y  = double(rand())/double(RAND_MAX);
        if (y <= sqrt(1-pow(x,2))){
            hit += 1;
            }
        cout << ""<< 4*double(hit)/double(jmax) << endl;
        }
    }    
}

/*
Function: FlippingCoin
Parameters: none (void)
========== Purpose ========== 
Determines the odds of heads or tails coming
up when flipping a fair coin.
*/
void FlippingCoin(){
    // TBD
}

/*
Function: TossDie
Parameters: none (void)
========== Purpose ========== 
Determines the odds of a 1, 2, 3, 4or 5
coming up when a fivesided fair die is tossed.
*/
void TossDie(){
    // TBD
}

/*
Function: printMenu 
Parameters: none (void)
========== Purpose ========== 
This function is to print out a menu of options.
The getInteger function exists to error check this function
*/
void printMenu(){
    // TBD
}



int main(){
    string answer;
    int interval; // this will be used to determine the montecarlo method iterations
    cout << "How many iterations for the MonteCarlo Method?: " << endl;
    cin >> interval; 
    
    // user defined number of iterations
    for (int i = 0; i < interval; i++){
        // call the void function
        CalculatePi();
    }
}