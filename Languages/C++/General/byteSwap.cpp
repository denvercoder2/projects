#include<stdio.h>
#include<vector>


class SimpleCompArc{

    // access specifier
    public:
    
    /*
    Function: byteSwap
    Parameters: int input

    This function takes an integer
    as input and swaps it to it's high or low 
    position. High if 0, Low if 1
    */
    int byteSwap(int input){
        if (input == 1){
            input = 0;
        }
        else{
            input = 1;
        }

        return input;
    }

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
};

int main(void){

    // call the class to create obj
    SimpleCompArc comp;


    std::vector<int> Data = {1,0,0,1,1,1,1,0};

    int byteReturn;

    for(int i : Data){
        byteReturn = comp.byteSwap(i);
        printf("Byte Swapped values: %d \n", byteReturn);
    }
    int decVal = comp.bin2dec(Data);

    printf("Decimal Value of initial vector: %d \n", decVal);

    return 0;
}