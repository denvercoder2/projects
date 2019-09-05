/*
Scott Holley
CS470
Project 1: Client/Server update connection

Purpose: 
    Start connection at beginning of run;
    Check for update;
    Decide whether to update or not;
*/

// A Java program for a Client 
import java.net.*; 
import java.io.*; 
  
public class Client 
{ 
    // initialize socket and input output streams 
    private Socket socket            = null; 
    private DataInputStream  input   = null; 
    private DataOutputStream output  = null; 
  
    // constructor to put ip address and port 
    public Client(String ip, int portNum) 
    { 
        // establish a connection 
        try
        { 
            String current_soft = "1.0"; 
            socket = new Socket(ip, portNum); 
            System.out.println("Connected at: "+ip+ "\nCurrent software is: "+current_soft); 
  
            // takes input from terminal 
            input  = new DataInputStream(System.in); 
  
            // sends output to the socket 
            output = new DataOutputStream(socket.getOutputStream()); 
        } 
        catch(UnknownHostException u) 
        { 
            System.out.println("Could not connect to server"); 
        } 
        catch(IOException i) 
        { 
            System.out.println("You need to start the server before attempting to connect the client");
            System.exit(0); 
        } 
  
        // string to read message from input 
        String checker = "";
        String new_soft = "1.1";
        System.out.println("Would the client like to update it's software [Y or N]? ");
        try{ 
            checker = input.readLine(); 
            output.writeUTF(checker); 
            if (!checker.equals("Y")){
                System.out.println("Software has not been updated, program exiting");
            }
            else{
                System.out.println("Software has been updated to version: " + new_soft);
            }
        } 
        catch(IOException i) { 
            System.out.println("You entered an option that was not Y or N");
            System.exit(0); 
        }
        // close the connection 
        try
        { 
            input.close(); 
            output.close(); 
            socket.close(); 
        } 
        catch(IOException i) 
        { 
            System.out.println("Could not close all connections"); 
        } 
    } 
  
    public static void main(String args[]) 
    { 
        Client client = new Client("127.0.0.1", 5000); 
    } 
} 