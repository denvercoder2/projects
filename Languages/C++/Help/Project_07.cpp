//****************************************
// Program Title: Project_07
// Project File: Project_07.cpp
// Name: Ivan Fontane
// Course Section: CPE-211-01
// Lab Section: 3
// Due Date: 10/20/19
// program description: Using a Menu
// Gives the user the ability to estimate Pi, flipping a coin
// and tossing a 5-sided die.
//***************************************
#include <iostream>
#include <iomanip>
#include <cmath>
#include <cstdlib>
#include <climits>

using namespace std;

//Function prototypes 
void printMenu();
int getInteger();
void coinFlip();
void tossDie();
void estimatePI();

// Menu Function

void printMenu()
{
    cout << "************************" << endl;
    cout << "*****"
         << " Menu Options "
         << "*****" << endl;
    cout << "************************" << endl;
    cout << " 1) Approximate PI " << endl;
    cout << " 2) Flipping a fair coin " << endl;
    cout << " 3) Toss a fair 5-sided die " << endl;
    cout << " 4) Exit " << endl;
    cout << "************************" << endl;

while (choice == 1)
{
    CalculatePi();
    break;
}
while (choice == 2)
{
    FlippingCoin();
    break;
}
while (choice == 3)
{
    TossDie();
    break;
}
while (choice == 4)
{
    exit();
    return;
}
}

int obtain()
{
    int choice;
    cin >> choice;
}

/*
Function: CalculatePi
parameters: none (void)
====== Purpose ======
Determine an approximation for pi using the MonteCarlo approzimation method
*/

/*
int interval, i;
double randX, randY, or_dist, pi;
int circle_count = 0, square_count = 0;

srand(time(NULL));

for (i = 0; i < (interval = interval); i++) {

randX = double(rand() % (interval + 1)) / interval;
randY = double(rand() % (interval + 1)) / interval;

or_dist = randX * randX + randY * randY;

if (or_dist <= 1)
circle_count++;

square_count++;

pi = double(4 * circle_count) / square_count;

cout << "\nFinal Estimation of Pi = " << pi;

return 0;
}
*/

void CalculatePi()
{
    // This function needs some work
    // we need to find the max from the proof or assignment
    int kmax = 5;
    int jmax = 2;
    double x, y;
    int hit;
    srand(time(0));
for (int i = 0; i < jmax; i++ {
        hit = 0;
        x = 0;
        y = 0;
        for (int i = 0; i < jmax; i++)
        {
            x = double(rand()) / double(RAND_MAX);
            y = double(rand()) / double(RAND_MAX);
            if (y <= sqrt(1 - pow(x, 2)))
            {
                hit += 1;
            }
            cout << " " << 4 * double(hit) / double(jmax) << endl;
        }
}
}

/*
Function: FlippingCoin
Parameters: none (void)
======= Purpose =======
Determine the odds of heads or tails coming
up when flipping a fair coin.
*/
void FlippingCoin()
{

    int choice;
    int numberflips;
    int heads = 0;
    int tails = 0;
    double pheads;
    double ptails;

    cout << " Flipping of a fair coin has been selected." << endl;
    cout << " " << endl;
    cout << "How many flips of the coin?";
    cin >> numberflips;
    cout << numberflips << endl;
    cout << " " << endl;

    for (int i = 1; i <= numberflips; i++)
    {
        choice = (rand() % 100) + 1;
        if (choice <= 50)
    }
    tails += 1;
}
if (choice > 50)
{
    heads += 1;
}
}

pheads = ((double)heads / numberflips) * 100;
ptails = ((double)tails / numberflips) * 100;

cout << setw(10, '*') << " Option 2: Flipping a Coin " << setw(10, '*') << endl;
cout << " For " << numberflips << " flips of a fair Coin:" << andl;
cout << "Heads Percentage: " << setprecision(6) << pheads << endl;
cout << "Tails Percentage: " << ptails << endl;
cout << setw(47, '*') << endl;
cout << " " << endl;

return;

/*
Function: TossDie
Parameters: none (void)
====== Purpose =======
Determines the odds of a 1, 2, 3, 4 or 5
coming up when a fivesided fair die is tossed
*/
void TossDie()
}

int x;
int rolls;

int one = 0;
int two = 0;
int three = 0;
int four = 0;
int five = 0;

double ones;
double twos;
double threes;
double fours;
double fives;

cout << " " << endl;
cout << " How many times do you want to roll the die?";
cin >> rolls;
cout << rolls << endl;
cout << " " << endl;

for (int i = 1; i <= rolls; i++)
{
    x = (rand() % 100) + 1;
    if (x <= 20)
    {
        one += 1;
    }
    if (c > 20 && x <= 40)
    {
        two += 1;
    }
    if (x > 40 && x <= 60)
    {
        three += 1;
    }
    if (x > 60 && x <= 80)
    {
        four += 1;
    }
    if (x > 80)
    {
        five += 1;
    }
}

ones = ((double)one / rolls) * 100;
twos = ((double)two / rolls) * 100;
threes = ((double)three / rolls) * 100;
fours = ((double)four / rolls) * 100;
fives = ((double)five / rolls) * 100;

cout << setw(10, '*') << " Option 3: Tossing a Die " << setw(10, '*') << endl;
cout << "For " << rolls << " rolls of a fair die:" << endl;
cout << "Side 1 Percentage: " << ones << endl;
cout << "Side 2 Percentage: " << twos << endl;
cout << "Side 3 Percentage: " << threes << endl;
cout << "Side 4 Percentage: " << fours << endl;
cout << "Side 5 Percentage: " << fives << endl;
cout << setw(47, '*') endl;
cout << " " << endl;
return;
}

int main()
{

    int seed;
    cout << " Enter in the seed(integer > 0) for the random number generator: " << endl;
    cin >> seed;
    cout << seed << endl;
    cout << " " << endl;

    // Invalid integer if statement

    srand(seed);
    {
        printMenu;
        choice = getInteger;
        if (choice > 4)
        {
            cout << setw(15, '*') << " Invalid Integer " << setw(15, '*') << endl;
            cout << "==> Invalid integer entered. " << endl;
            cout << "==> Please try again... " << endl;
            cout << setw(47, '*') endl;
            printMenu();
        }
    }
}

{
    return 0;
}
