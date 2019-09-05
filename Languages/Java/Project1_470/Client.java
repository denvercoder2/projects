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
import java.util.*;
  
public class Client 
{ 
    // initialize socket and input output streams 
    private Socket socket            = null; 
    private DataInputStream  input   = null; 
    private DataOutputStream out     = null; 
  
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
            out    = new DataOutputStream(socket.getOutputStream()); 
        } 
        catch(UnknownHostException u) 
        { 
            System.out.println("yeet"); 
        } 
        catch(IOException i) 
        { 
            System.out.println("You need to start the server before attempting to connect the client");
            System.exit(0); 
        } 
  
        // string to read message from input 
       
        Scanner choice = new Scanner(System.in);
        System.out.println("Would you like to update your Software? [Y or N] ");
        String answer = choice.nextLine();
        String new_soft = "1.1"; 
  
        // keep reading until "Over" is input 
        if (!answer.equals("Close")){ 
            System.out.println("Software has been updated to version: " + new_soft); 
        }
        else{
            System.out.println("Software was not updated");
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
            System.out.println("Could not close all connections"); 
        } 
    } 
  
    public static void main(String args[]) 
    { 
        Client client = new Client("127.0.0.1", 5000); 
    } 
} 