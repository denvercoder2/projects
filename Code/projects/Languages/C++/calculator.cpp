// Scott Holley
// Calculator in c++

#include <iostream>
// using namespace std is generally not a good idea
// but for this small program, it's okay
using namespace std;


/*
These are functions in c++. They are a little different than in python but the
idea is the same. Make a type of function, and give the parameters types.
In this case, I want to return the operation of the two parameters
*/
float addition(int a, int b){
    return a + b;
}

float subtraction(int a, int b){
    return a - b;
}

float multiplication(int a, int b){
    return a * b;
}

float division(int a, int b){
    return a / b;
}


/*
Every c++ program has to have a main program. In this smaller one, the main
program pretty much does the same as the python main program
 */
int main(){
    int a, b;
    int choice;
    cout << "Enter the first number: ";
    cin >> a;

    cout << "Enter the second number: ";
    cin >> b;

    cout << "Enter the operation\n1)Addition\n2)Subtraction\n3)Multiplication\n4)Division\n";
    cin >> choice;

    if (choice == 1){
        cout << "The answer is: " << addition(a, b) << "\n";
    }
    else if (choice  == 2){
        cout << "The answer is: " << subtraction(a, b) << "\n";       
    }
    else if (choice  == 3){
        cout << "The answer is: " << multiplication(a, b) << "\n";       
    }
    else{
        cout << "The answer is: " << division(a, b) << "\n";
    }
}