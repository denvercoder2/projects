/*
* Budget Program for the bills
* Scott Holley
* January, 2019, WIP
*/   

#include<stdio.h>

struct bills
{
    char name[10];
    int price;
    char due_date[20];
};

/* Function Prototype */
void func(struct bills);

int main(){
    struct bills b1 = {"Rent", 1115, "1st of the month"};
    printf("Name: %s\nPrice: %d\nDue: %s\n", b1.name, b1.price, b1.due_date);
    printf("\n");

    return 0;
}