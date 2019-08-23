/*
GO implementation of budget
Scott
*/

package main

import (
	"fmt"
	"sort"
)

/*
* Function Name: readBills
* Parameters: Utility bill (float64)
* Return Type: map of string keys, float64 values

* Purpose: Returns a mapping of bills to be used in
	   	   scope for other functions and mitigate
	       unwanted side effects
*/
func readBills(newUtility float64) map[string]float64 {

	newUtility = (newUtility / 2)
	billMap := map[string]float64{
		"Rent":        410.555,
		"Water":       20.00,
		"Internet":    55.00,
		"Utilities":   newUtility,
		"Phone":       50.00,
		"Insurance":   160.00,
		"Car Payment": 221.14}

	return billMap
}

/*
* Function Name: sortBills
* Parameters: map of string keys, float64 values
* Return Type: map of string keys, float64 values

* Purpose: Given a map of bills, this function
           will	take the values and return
	       a sorted array slice of the values
*/
func sortBills(map[string]float64) []float64 {

	var givenMap map[string]float64
	var onlyNums []float64

	givenMap = readBills(170.00)
	keys := make([]string, 0, len(givenMap))

	for k := range givenMap {
		keys = append(keys, k)
	}

	for _, k := range keys {
		onlyNums = append(onlyNums, givenMap[k])
	}
	sort.Float64s(onlyNums)

	return onlyNums
}

/*
* Function Name: getSaving
* Parameters: Total pay(float64)
* Return Type: savings (float64)

* Purpose: Takes a total and returns the
	       appropriate saving amount from
	       that total
*/

func getSaving(total float64) float64 {
	var savings float64
	savings = total * .35

	return savings
}

/*
Function Name: sumBills
Parameters: array of bills ([]float64)
Return Type: sum (float64)

Purpose: Take the bill array and return
	     a sum of all its elements
*/
func sumElements([]float64) float64 {
	var givenMap map[string]float64
	var sortedList []float64
	var sum float64
	givenMap = readBills(187.00)
	sortedList = sortBills(givenMap)

	for i := 0; i < len(sortedList); i++ {
		sum = sum + sortedList[i]
	}

	return sum
}

/*
* Function Name: Main
* Parameters: None
* Return Type: None

* Purpose: Setup and run this program
 */
func main() {
	var pay float64
	var netPay float64
	pay = 2280.00

	newMap := readBills(187.00)
	sortedMap := sortBills(newMap)

	fmt.Print("Bills from least to most expensive: ", sortedMap, "\n")
	totalBills := sumElements(sortedMap)
	fmt.Print("\nTotal Bill value is: $", totalBills)
	netPay = pay - totalBills
	fmt.Print("\nMoney after Bills: $", netPay)
	savings := getSaving(netPay)
	fmt.Print("\nYou should save: $", savings, "\n")
}
