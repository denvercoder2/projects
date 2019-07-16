// Calculator in Go
package main

import (
	"fmt"
)

func add(a int, b int) int {
	return a + b
}

func sub(a int, b int) int {
	return a - b
}

func mul(a int, b int) int {
	return a * b
}

func main() {
	var num1 int
	var num2 int

	fmt.Print("Please enter the first number: ")
	fmt.Scan(&num1)

	fmt.Print("Please enter the second number: ")
	fmt.Scan(&num2)

	var choice int
	fmt.Print("Please enter the operation:\n1)Addition\n2)Subtraction\n3)Multiplication\n")
	fmt.Scan(&choice)

	if choice == 1 {
		fmt.Print("The answer is: ", add(num1, num2), "\n")
	} else if choice == 2 {
		fmt.Print("The answer is: ", sub(num1, num2), "\n")
	} else {
		fmt.Print("The answer is: ", mul(num1, num2), "\n")
	}

	var cont string
	fmt.Print("Do you want to continue? [Y or N]\n")
	fmt.Scan(&cont)
	check(cont)
}

func check(answer string) {
	if answer == "Y" {
		main()
	}
}
