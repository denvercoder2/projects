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
import java.io.*;
import java.net.*;


public class MobileDevice {

    /*
    Function name: getChoice
    Parameters: None (void)
    ================== Purpose ==================
    To ask and return the user's choice to decide the correct
    type of protocal to use
    */
    public static String getChoice() throws IOException{
        BufferedReader input     = null;
        DataOutputStream output  = null; 
        
        String udp = "UDP";
        String tcp = "TCP";
        String multicast = "Multicast";
        String unicast = "Unicast";
        String protocal = null;
        String choice = null; 
        System.out.println("Enter the choice for the protocal: \n1)UDP\n2)TCP\n3)Multicast\n4)Unicast");
        input  = new BufferedReader(new InputStreamReader(System.in)); 
        

        choice = input.readLine(); 
        
        // return the correct protocal based on the user input
        if (choice.equals("1")){
            protocal = udp;
            System.out.println("You chose : " + protocal);
        }
        else if(choice.equals("2")){
            protocal = tcp;
            System.out.println("You chose : " + protocal);
        }
        else if(choice.equals("3")){
            protocal = multicast;
            System.out.println("You chose : " + protocal);
        }
        else if(choice.equals("4")){
            protocal = unicast;
            System.out.println("You chose : " + protocal);
        }
        else{
            System.out.println("You entered a choice that is not one of the options");
        }
        return protocal;
    }

// -------------------------------------- //
    // TCP Function spot
    public static void TCP(){
        System.out.println("TBD");
    }
// -------------------------------------- //
    // UDP Function spot
    public static void UDP(){
        System.out.println("TBD");
    }
// -------------------------------------- //

    
    public static void main(String[] args)throws Exception{
        String protocal = getChoice();

        // Going through the functions defined above
        // depending on the return from getChoice
        if(protocal.equals("TCP")){
            TCP();
        }
        else if(protocal.equals("UDP")){
            UDP();
        }
        else if(protocal.equals("Multicast")){
        }
        else if(protocal.equals("Unicast")){

        }
        else{
            System.out.println("No protocal was selected");
        }
    }
}
