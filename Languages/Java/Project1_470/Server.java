/*
Scott Holley
CS470
Project 1: Client/Server update connection

Purpose: 
    Standup a server for a client to attach to;
    Read the clients option for uograding software;
    Send update if Client asks to, and client doesn't 
    already have latest version;
    Close connection after the process is done;
*/

import java.net.*;
import java.io.*; 
  
public class Server 
{ 
    //initialize socket and input stream 
    private Socket socket           = null; 
    private ServerSocket server     = null; 
    private DataInputStream input   = null; 
  
    // constructor with port 
    public Server(String ip,int portNum) 
    { 
        
       
         
        try
        { 
            // starts server and waits for a connections
            server = new ServerSocket(portNum); 
            System.out.println("Server up and waiting for client"); 
            // Accept the connection from client and grab the ip via parameter
            socket = server.accept(); 
            System.out.println("Client accepted at IP: " + ip); 
            // Then, it's up to the client to answer for the program to continue
            System.out.println("Awaiting Client decision on updating Software");
  
            // Input to read in from the client
            input = new DataInputStream( 
                new BufferedInputStream(socket.getInputStream())); 

                
            // Initially set the client string to an empty string
            String client_line = "";

            // String new_soft = "1.1";
            
            /* 
            read in the client_line var and conditionally decide whether or
            not to update the software on the client side 
            */
            client_line = input.readUTF();
            // Case 1: User chooses to not update the software
            if (!client_line.equals("Y")){
                System.out.println("Software was not updated, Goodbye");
                System.exit(0); 
            }
            // Case 2: User chooses to update the software
            else{ 
                System.out.println("Client has chosen to update their software"); 
            } 
                
            // After the action is done, close the connection
            System.out.println("Connection is closed"); 

            // close connection 
            socket.close(); 
            input.close(); 
        } 
        // catch any IO errors thrown from the beginning
        // of the try up at the top of function
        catch(IOException i) 
        { 
            System.out.println(i); 
        } 
    } 
  

    // Call the function, this is essentially a driver function
    public static void main(String args[]) 
    { 
        Server server = new Server("127.0.0.1",5000); 
    } 
} 