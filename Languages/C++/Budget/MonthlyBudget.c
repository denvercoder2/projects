/*
* Budget Program for the bills
* Scott Holley
* January -> February 2019, WIP
*/   

#include<stdio.h>
// #include<MonthlyBudget.h>
/* Bills Structure */
typedef struct bills
{
    char name[10];
    double price;
    char due_date[20];
} bills;


/**
 * Function: show_bills
 * Parameters: Pointer to Bills structure
 * Purpose: 
 * Keep track and add the bills from the structure
 */
static void show_bills(bills *b){
    // b->name == "Rent";
    printf("Name: %s\nPrice: %d\nDue: %s\n", b->name, b->price, b->due_date);

}





int main(void){
    bills bill;
    show_bills(&bill);
    return 0;
}