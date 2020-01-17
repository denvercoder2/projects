#include<stdio.h>
#include<vector>
#include<string.h>
#include<iostream>


class SimpleCompArc{

    // access specifier
    public:

    /*
    Function: bin2dec
    Parameters: std::vector<int>

    This function is a simplified case
    statement representing the vector 
    as a stack of binary values and converting them
    to their correct decimal values
    depending on the spot
    */
    int bin2dec(std::vector<int> testData){
        int tempCounter = 0;

        if(testData.at(0) != 0){
            tempCounter += 128;
        }
        if(testData.at(1) != 0){
            tempCounter += 64;
        }
        if(testData.at(2) != 0){
            tempCounter += 32;
        }
        if(testData.at(3) != 0){
            tempCounter += 16;
        }
        if(testData.at(4) != 0){
            tempCounter += 8;
        }
        if(testData.at(5) != 0){
            tempCounter += 4;
        }
        if(testData.at(6) != 0){
            tempCounter += 2;
        }
        if(testData.at(7) != 0){
            tempCounter += 1;
        }

        return tempCounter;
    }

    /*
    Function: hex2dec
    Parameters: char []

    This function will read in a char array
    and reverse it, while applying the laws
    of hex conversion to each element until the end
    */
    int hex2dec(char hexVal[]){
        int length = strlen(hexVal);

        int base = 1;
        int decVal = 0;

        for(int i = length - 1; i >= 0; i--){

            if(hexVal[i] >= '0' && hexVal[i] <= '9'){
                decVal += (hexVal[i] - 48) * base;

                base = base * 16;
            }

            else if(hexVal[i]>='A' && hexVal[i]<='F'){
                decVal += (hexVal[i] - 55) * base;

                base = base * 16;
            }
        }
        return decVal;
    }

};

int main(void){

    // call the class to create obj
    SimpleCompArc comp;
    std::vector<int> Data = {1,0,0,1,1,1,1,0};
    int decVal = comp.bin2dec(Data);
    
    printf("Decimal Value of initial vector: %d \n", decVal);

    char hexTemp[] = "A3C2";
    int hexVal = comp.hex2dec(hexTemp);

    printf("Hex Value of initial vector: %d \n", hexVal);
    return 0;
}