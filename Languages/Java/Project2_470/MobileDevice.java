 /*
    Scott Holley
    CS470 Project 2
    Due: November 4th
    Filename: MobileDevice
 */


/*
======================================== GENERAL OVERVIEW ========================================
| The mobile device class should be able to recognize the projector                              |
| by name (display:projector)                                                                    |
|                                                                                                |
| Depending on the projector (Either classroom or dorm), there can                               |
| be a certain type of media sent to the projector (UDP packets)                                 |
| In this project, we are to mimic live sports being sent to the projector                       |
======================================== GENERAL OVERVIEW ========================================
*/

/*
There should be functions dictatating which cast to use
Ask the mobile device which type it'd like to use and 
go from there
*/
import java.net.*;
import java.io.*; 



// TCP Connection
public class MobileDevice{
    // TCP connection
    private Socket socket            = null; 
    private BufferedReader   input   = null; 
    private DataOutputStream output  = null; 


    public static void main(String[] args) {
        System.out.println("TBD");
    }
}