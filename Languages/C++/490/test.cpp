#include <iostream>
#include <fstream>
#include <sstream> 
#include <string>
#include <vector>

std::vector<int> getLine(std::string filename){
    std::vector<int> test;
    std::ifstream infile (filename);


    std::string str;
    while(std::getline(infile, str)){
        int new_line = stoi(str);
        test.push_back(new_line);
    }
    return test;
}

int main(){
    std::vector<int> test = getLine("sample.txt");
    std::cout << test[0] << std::endl;
    std::cout << test[1] << std::endl;
}
/*
Information in the file
5 7
2 3 4 7 7 6 13 16 11 10 3 5 4 2 6 8

Output:
5 // for test[0]
2 // for test[1]
*/