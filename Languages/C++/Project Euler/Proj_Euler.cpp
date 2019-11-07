/*
*   Project Euler problems in C++
*/
#include<iostream>
#include <vector>
#include<numeric>


int problem_one(int final){
    int total;
    std::vector<int> holder;

    for(int i = 0; i < final; i++){
        if (i % 3 == 0 || i % 5 ==0){
            holder.push_back(i);
        }
    }
        total = std::accumulate(holder.begin(), holder.end(), 0);
        return total;
}



int main(){
    int final = problem_one(1000);
    std::cout << final << std::endl;
}