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
import java.util.*;


public class MobileDevice {

    /*
    Function: fakeData
    Parameters: Counter (int)
    ================== Purpose ==================
    Generate some fake data to send over the connection
    or broadcast
    */
    public static ArrayList fakeData(int counter){
        Random random = new Random();
        ArrayList<Integer> randomInts = new ArrayList<>();
        for (int i = 0; i < counter; i++){
            randomInts.add(random.nextInt(counter));
        }
        return randomInts;
    }
    /*
    Function: slides
    Parameters: Counter (int)
    ================== Purpose ==================
    Generate some fake slide data to represent a 
    slideshow on a school projector
    */
    public static int slides(int counter){
        int slide = 0;
        for(int i = 0; i < counter; i++){
            slide += 1;
        }
        return slide;

    }
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
    /*
    Function: TCP
    Parameters: None (void)
    ================== Purpose ==================
    Perform TCP connection if selected
    */
    public static void TCP(String address, int port){
            Socket socket            = null; 
            DataInputStream  input   = null; 
            DataOutputStream out     = null; 
  
        // establish a connection 
        try
        { 
            socket = new Socket(address, port); 
            System.out.println("Connected"); 
  
            // takes input from terminal 
            input  = new DataInputStream(System.in); 
  
            // sends output to the socket 
            out    = new DataOutputStream(socket.getOutputStream()); 
        } 
        catch(UnknownHostException u) 
        { 
            System.out.println(u); 
        } 
        catch(IOException i) 
        { 
            System.out.println(i); 
        } 
  
        // string to read message from input 
        String line = ""; 
  
        // keep reading until "Over" is input 
        while (!line.equals("Quit")) 
        { 
            try
            { 
                line = input.readLine(); 
                out.writeUTF(line); 
            } 
            catch(IOException i) 
            { 
                System.out.println(i); 
            } 
        } 
  
        // close the connection 
        try
        { 
            input.close(); 
            out.close(); 
            socket.close(); 
        } 
        catch(IOException i) 
        { 
            System.out.println(i); 
        } 
    } 

// -------------------------------------- //
    /*
    Function: UDP
    Parameters: None (void)
    ================== Purpose ==================
    Perform UDP connection if selected
    */
    public static void UDP(){
        System.out.println("TBD");
    }
// -------------------------------------- //
    /*
    Function: Multicast
    Parameters: None (void)
    ================== Purpose ==================
    Perform Multicast broadcasting if selected
    */
    public static void Multicast(){
        System.out.println("TBD");
    }
// -------------------------------------- //
    
    /*
    Function: Unicast
    Parameters: None (void)
    ================== Purpose ==================
    Perform Unicast broadcasting if selected
    */
    public static void Unicast(){
        System.out.println("TBD");
    }
// -------------------------------------- //
    
    public static void main(String[] args)throws Exception{
        String protocal = getChoice();
        int counter = 100;
        ArrayList<String> movie_data = fakeData(counter);
        // for (int i = 0; i < counter; i++){
        //     System.out.println(movie_data);
        // }
        

        // Going through the functions defined above
        // depending on the return from getChoice
        if(protocal.equals("TCP")){
            TCP("127.0.0.1", 5000);
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
