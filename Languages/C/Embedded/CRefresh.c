/*
C Language Refresher
*/
#include<stdio.h>
#include<stdlib.h>  

void pointer(){
    int number = 99;
    int *p;

    // stores the address of where number is
    p = &number;

    printf("Address of p variable is %x \n", p);
    printf("Value of p variable is %d \n", *p); 

}

void dynamicMem(){
    int n,i,*ptr,sum=0;    
    printf("Enter number of elements: ");    
    scanf("%d",&n);    
    ptr=(int*)malloc(n*sizeof(int));  //memory allocated using malloc    
    if(ptr==NULL)                         
    {    
        printf("Sorry! unable to allocate memory");    
        exit(0);    
    }    
    printf("Enter elements of array: ");    
    for(i=0;i<n;++i)    
    {    
        scanf("%d",ptr+i);    
        sum+=*(ptr+i);    
    }    
    printf("Sum=%d ",sum);    
    free(ptr);     
}
