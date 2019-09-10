/*
Scott Holley
CS470
Project 1: Client/Server update connection

Purpose: 
    Connect to the server;
    Answer whether or not to update software;
    Update if answer is yes;
    Don't update if answer is no, or
    client already has latest version
*/

// A Java program for a Client 
import java.net.*; 
import java.io.*; 
  
public class Client 
{ 
    // initialize socket and input output streams 
    private Socket socket            = null; 
    private BufferedReader   input   = null; 
    private DataOutputStream output  = null; 
  
    // constructor to put ip address and port 
    public Client(String ip, int portNum) 
    { 
        // Establish a connection;
        // Give a status update message for completion
        try
        { 
            String current_soft = "1.0"; 
            socket = new Socket(ip, portNum); 
            System.out.println("Connected at: "+ip+ "\nCurrent software is: " + current_soft + "\n"); 
            // takes input from terminal 
            input  = new BufferedReader(new InputStreamReader(System.in)); 
            // sends output to the socket 
            output = new DataOutputStream(socket.getOutputStream()); 
        } 
        // Catch if the host can't be found
        catch(UnknownHostException u) 
        { 
            System.out.println("Could not connect to server"); 
        } 
        // Catch if the server is not started when the client runs
        catch(IOException i) 
        { 
            System.out.println("You need to start the server before attempting to connect the client");
            System.exit(0); 
        } 
  
        // string to read message from input 
        // based on the input, update the software or
        // leave it alone
        String checker = "";
        String soft_vers = "1.0";
        System.out.println("\nWould the client like to update it's software [Y or N]? ");
        try{ 
                checker = input.readLine(); 
                output.writeUTF(checker); 
            if (checker.equals("Y")){
                InputStream input = socket.getInputStream();
                InputStreamReader inputReader = new InputStreamReader(input);
                BufferedReader breader = new BufferedReader(inputReader);
                String message = breader.readLine();
                System.out.println("Version recieved from server : " +message);
                System.out.println("Software has been updated to version: " +message);
                System.out.println("\n========Client End========\n");
            }
            else if (checker.equals("N")){
                System.out.println("Software has not been updated, version is: " + soft_vers);
                System.out.println("\n========Client End========\n");
            }
            else{
                System.out.println("You entered an option that was not Y or N, please run again");
                System.exit(0); 
            }
        } 
        catch(IOException i) { 
            System.out.println("There was an issue reading in your characters, please run again");
            System.exit(0); 
        }
        // close the connection 
        try
        { 
            input.close(); 
            output.close(); 
            socket.close(); 
        } 
        // Catch if all connections can't be closed
        catch(IOException i) 
        { 
            System.out.println("Could not close all connections"); 
        } 
    } 
  
    // Call the code above to start the client
    public static void main(String args[]) 
    { 
        System.out.println("\n========Client Start========\n");
        // pass in ip and port as parameters
        Client client = new Client("127.0.0.1", 5000);
    } 
} 