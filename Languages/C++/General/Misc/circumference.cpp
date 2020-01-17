/*
Examples of things in c++ for christian
*/

#include <iostream>
#include <string.h>

/*
*   Function Name: getCircumference(double)
*   Parameter Type: double
*   Return Type: double
*   Purpose: Compute the circumference, given the radius
*/

double getCircumference(double radius){
    const double PI = 3.14159;
    double circumference = 2 * PI * radius;
    return circumference;
}

/*
*    Function: Main
*    Parameter type: None (Void)
*    Return Type: int (exit condition)
*    Purpose: Driver for functions above
*/
int main(void){
    // declare a variable to use in the function call
    double radius = 2.00;

    // call the function and assign it to the data type that
    // is declared above. Now the value is stored in the variable
    // circumference
    double circumference = getCircumference(radius);

    std::cout << "Circumference for given radius: " << radius << " is: " <<
    circumference << std::endl;

    return 0;
}


