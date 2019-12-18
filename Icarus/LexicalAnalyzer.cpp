/*
    Scott Holley
    Lexical Analyzer for programming language: Icarus
    Date: 12/18/2019
*/

#include<stdio.h>
#include<iostream>
#include<fstream>
#include<vector>
#include<string>

/*
* Function: openFile
* Parameters: std::string 
* Return Type: std::vector
*/
std::vector<std::string> openFile(std::string filename){

    std::ifstream InFile;
    std::string str;
    InFile.open(filename);
    std::vector<std::string> x;

    if(!InFile){
        printf("Unable to open file");
        exit(1);   
    }

    while(std::getline(InFile, str)){
        if (str.size() > 0){
            x.push_back(str);
        }
    }
    return x;
}

/*
* Function: LexAnalysis
* Parameters: std::vector<std::string> 
* Return Type: None (void)
*/
// void LexAnalysis(std::vector<std::string> inputVector){
//     std::string token = "";

//     for(auto i = inputVector.begin(); i != inputVector.end(); ++i){
//         token = token + inputVector;

    
//     }

// }




int main(){
    std::string filename = "test.lang";
    std::vector<std::string> output = openFile(filename);

    for(auto i = output.begin(); i != output.end(); ++i){
        std::cout << *i << '\n';
    }
}