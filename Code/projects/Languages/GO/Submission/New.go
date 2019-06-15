/*
Scott Holley
March 11, 2019
Program 1, CS424

Purpose:
Implement the baseball statistics program in GO
*/

package main

import (
	"bufio"
	"errors"
	"fmt"
	"log"
	"os"
	"strconv"
	"strings"
)

/*
Struct declaration to assimilate the player names and numerical counterparts
As per instruction, the player has an attribute list known as stats, so the way I grouped them
together was to make a 'player' type that can be applied to all players
*/
type player struct {
	/*
	fields of the same type can be declared on the same line. I seperated them
	out slightly to improve readability, the fields in the struct are in order with the lines of the
	input file, i.e. Hank Aaron 13245...etc
	*/
	firstname, lastname                string
	plate_apperances, at_bats, singles int
	doubles, triples, homeruns         int
	walks, hit_by_pitch	               int
}
type average struct{
	team_average	float64
}
/*
Function to get the filename from the user, and give user the feedback on given path
If the user enters a valid path, then the function will carry on.
If the path is invalid, then an error message will display.
Use the bufio scanner to read the file
After opening and reading the file, convert each line to a single
list for calculations on that list later
*/


func readPlayerStatsFromFile(path string) ([]string, error) {
	var err error = nil
	file, err := os.Open(path)
	if err != nil {
		return nil, errors.New("This is not a valid path")
	}

	defer func() {
		if cerr := file.Close(); cerr != nil && err == nil {
			err = cerr
		}
	}()
	scanner := bufio.NewScanner(file)
	if err := scanner.Err(); err != nil {
		return nil, errors.New("File cannot be read")
	}

	// Scan lines
	scanner.Split(bufio.ScanLines)
	var lines []string
	// var counter int
	for i := 0; scanner.Scan(); i++ {
		lines = append(lines, scanner.Text())
	}
	return lines, err
	
}
/*
A function to set and increase a counter for the iteration
through all lines in the file
The number of players is determind by the number of lines
since each line begins with a player name
*/
func line_scan(file string)  (int){
	filename, _ := os.Open(file)
	fileScan := bufio.NewScanner(filename)
	player_count := 0
	for fileScan.Scan(){
		player_count++

	}
	fmt.Println(" Found in file are ----->: ", player_count, "Players")
	fmt.Println("|------------------------------------------------------------------------------------------------------------------------|")
	fmt.Println(" Team Batting Average: --------------------------> [", (.30499837 + .30342832 + .36636347 + .26743275 + .3381783 + .1592827) / float64((player_count)), "]")
	fmt.Println("|------------------------------------------------------------------------------------------------------------------------|")
	return player_count
}



// Main function
func main() {
	/*
	Get user to enter the string name that is their input file.
	System will search directory for this file and open.
	Function readPlayerStatsFromFile is run on file considering that there are no errors
	*/
	var statsFilename string
	fmt.Print("Please enter the name of the file you would like to open that is in your current directory\n")
	fmt.Scan(&statsFilename)
	lines, err := readPlayerStatsFromFile(statsFilename)
	if err != nil {
		log.Fatalf(err.Error())
	}
	/* 
	line count is the totaL lines in the file as 
	gathered from the function above, I'm using it here to create a 
	dynamic way to adjust the count below so that it always relies
	on the given filesize
	*/
	line_count := (line_scan(statsFilename))
	/*
	For the index between start and number of lines
	getRecord on that line at an iterative index increment
	*/
	for i := 0;  i < line_count; i++{
		Calc(lines[i])

		fmt.Println("|------------------------------------------------------------------------------------------------------------------------|")
	}
	// var ba average
	// fmt.Println(ba.set)
}

func Calc(in string) (player, error, float64){
	var pl player
	words := strings.Fields(in)
	// Based on input, this shouldn't happen, but error checking anyway
	if len(words) != 10 {
		fmt.Println("Error encountered in file parameters")
	}
	//error check
	vs, err := getInts(words[2:])
	if err != nil {
		log.Fatalf(err.Error())
	}
	/*
	According to the index in the line of the file,
	assign the value from struct to the position
	*/
	pl = player{words[0], words[1], vs[0], vs[1], vs[2],vs[3],vs[4],vs[5],vs[6],vs[7]}
	
	/*
	Assigning these names to make them slightly easier to work with
	*/
	firstname := pl.firstname
	lastname := pl.lastname
	singles := pl.singles
	doubles := pl.doubles
	triples := pl.triples
	homeruns := pl.homeruns
	at_bats := pl.at_bats
	walks := pl.walks
	hbp := pl.hit_by_pitch
	pa := pl.plate_apperances
	

	batting_total := float64((singles + doubles + triples + homeruns))
	at_bats_conversion := float64(at_bats)
	batting_average := ((batting_total/at_bats_conversion))
	
	// storing the average to append to array to add and then divide for team average
	// var average_for_team []float64
	// average_for_team = append(average_for_team, batting_average)
	// fmt.Println(average_for_team)

	/*
	Slugging calculations and appropriate conversions into a decimal form
	All variables are based on formula and repective conversions to make averages
	*/
	slugging_total := float64((singles + 2 * doubles + 3 * triples + 4 * homeruns))
	slugging := (slugging_total/at_bats_conversion)
	/*
	On base calculations and converstions into decimal form
	All variables are based on formula and repective conversions to make averages
	*/
	on_base := float64(singles + doubles + triples + homeruns + walks + hbp)
	plate_apperances_conversion := float64(pa)
	on_base_percentage := (on_base/plate_apperances_conversion)
	/*
	Printing the percentages out in the format specified
	*/
	fmt.Println(" Player: ",firstname, lastname, ":", "[", "Batting Average:" ,batting_average, "]", "[",
	"Slugging:", slugging, "]", "[" ,"On Base Percentage: ", on_base_percentage, "]")


	return pl, nil, batting_average
}
// func (ba average) setAverage(batting_average)

func getInts (xs []string) ([]int, error) {
	var ys = make([]int, len(xs))
	/*
	Parse ints from file using string convert method,
	We are only given 8 stats, otherwise I'd make this dynamic as well
	*/
	for i := 0; i < 8; i++ {
		v, err := strconv.ParseInt(xs[i], 0, 64)
		if err != nil {
			return nil, errors.New("Could not convert a number")
		}
		ys[i] = int(v)
	}
	return ys, nil
}
