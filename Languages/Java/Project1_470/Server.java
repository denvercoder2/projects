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
    public Server(int portNum) 
    { 
        // try for connection to client
        try
        { 
            // starts server and waits for a connections
            server = new ServerSocket(portNum); 
            System.out.println("Server up and waiting for client..."); 
            // Accept the connection from client and grab the ip via parameter
            socket = server.accept(); 
            String IPaddress = socket.getLocalSocketAddress().toString();
            System.out.println("Client accepted at IP and port: " + IPaddress); 
            // Then, it's up to the client to answer for the program to continue
            System.out.println("Awaiting Client decision on updating Software...");
  
            // Input to read in from the client
            input = new DataInputStream( 
                new BufferedInputStream(socket.getInputStream())); 

                
            // Initially set the client string to an empty string
            String client_line = "";
            String new_software = "1.1";
            /* 
            read in the client_line var and conditionally decide whether or
            not to update the software on the client side 
            */
            client_line = input.readUTF();
            // Case 1: User chooses to not update the software
            if (!client_line.equals("Y")){
                System.out.println("Client chose not to update.\nSoftware still at version: 1.0" );
                System.out.println("\n========Server=End==========\n");
                System.exit(0); 

            }
            // Case 2: User chooses to update the software
            // we send the message containing the new software version
            // to the client
            else{ 
                System.out.println("\nClient has decided to update\n");
                OutputStream output = socket.getOutputStream();
                OutputStreamWriter outWriter = new OutputStreamWriter(output);
                BufferedWriter bwriter = new BufferedWriter(outWriter);
                bwriter.write(new_software);
                System.out.println("\nSoftware version sent to client: " + new_software);
                bwriter.flush();
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
        System.out.println("\n========Server Start========\n");
        // pass in port as parameter
        Server server = new Server(5000); 
        System.out.println("\n========Server End==========\n");
    } 
} 