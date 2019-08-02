// /*
// GO implementation of budget
// */

// package main

// import (
// 	"fmt"
// 	"math"
// )

// func readBills(utility float64) map[string]float64 {
// 	var newUtility float64

// 	newUtility = math.Pow(utility, .5)
// 	billMap := map[string]float64{
// 		"Rent":        410.555,
// 		"Water":       20.00,
// 		"Internet":    55.00,
// 		"Utilities":   newUtility,
// 		"Phone":       50.00,
// 		"Insurance":   160.00,
// 		"Car Payment": 221.14}

// 	return billMap
// }

// func getSaving(total float64) float64 {
// 	var savings float64

// 	savings = total * .35

// 	return savings
// }

// func main() {
// 	var utility float64
// 	var pay float64
// 	pay = 2280.00

// 	fmt.Print("What was the utility bill? \n")
// 	fmt.Scan(&utility)

// 	newMap := readBills(utility)
// 	Rent := newMap["Rent"].(float64)

// 	fmt.Print(newMap)
// }
