#include <iostream>
#include <fstream>
#include <sstream> 
#include <string>
#include <tuple>
#include <vector>
#include <array>

array<int, 15> vec2arr(std::vector<int>){

}





int main(){
    std::vector<int> test ({1,2,3,4,5});
    int* ptr = vec2arr(test);

    for (int i = 0; i < 15; i++){
        std::cout << ptr[i] << std::endl;
    }


}