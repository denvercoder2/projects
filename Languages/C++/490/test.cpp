#include <iostream>
#include <fstream>
#include <sstream> 
#include <string>
#include <tuple>
#include <vector>



std::tuple<std::string, std::string> getLine(std::string filename){
    std::ifstream infile (filename);
    std::string str1;
    std::string str2;
    int max = 2;

    if (infile){

        for(int i = 0; i < max; i++){
            std::getline(infile, str1);
            std::getline(infile, str2);
        }

        // std::cout << str1 << std::endl;
        // std::cout << str2 << std::endl;
    }
    else{
        // error check if file can't be opened
        std::cout << "File could not be opened" << std::endl;
    }
    return std::make_tuple(str1, str2);
}
std::vector<int> parseLine(std::tuple<std::string, std::string> test){
    std::string str1 = std::get<0>(test);
    std::string str2 = std::get<1>(test);

    // std::cout << str1 << std::endl;
    // std::cout << str2 << std::endl;


    // line 2 vector
    std::vector<int> retmp2;

    // container for other vectors
    std::istringstream stm(str1);
    // std::istringstream stm2(str2);
    
    int value;
    // line 1 vector
    std::vector<int> retmp;
    while(stm >> value){
        retmp.push_back(value);
    }
    // while(stm2 >> value){
    //     retmp2.push_back(value);
    // }
    
    // std::vector<std::vector <int>> tmp{ {retmp},
    //                                     {retmp2}};
    for (int i = 0; i < retmp.size(); i++){
        std::cout << retmp2[i] << std::endl;
    }

    return retmp;
}


int main(){
    // std::vector<std::vector<int>> test = getLine("sample.txt");
    int max = 2;
    std::tuple<std::string, std::string> tester = getLine("sample.txt");
    std::vector<int> testerInts = parseLine(tester);

    for (int i = 0; i < testerInts.size(); i++){
            std::cout << testerInts[i] << " ";
        std::cout << std::endl;

    }

}
