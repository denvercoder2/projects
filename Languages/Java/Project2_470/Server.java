
/*
   Scott Holley
   CS470 Project 2
   Due: November 4th
   Filename: Server
*/
import java.net.*;
import java.io.*;
import java.util.*;

/*
======================================== GENERAL OVERVIEW ========================================
| The Server Class is to act as an interface for the mobile device to find                       |
| The Server should have two modes (Classroom, or dorm).                                         |
| This is to be specified to the mobile device, and from there, the type of media                |
| that can be displayed is determined.                                                           |
| There is also a choice on what type of cast to use                                             |
======================================== GENERAL OVERVIEW ========================================
*/

// TCP: Socket
// UDP DataGram
// Multicast, unicast

import java.io.*;
import java.net.*;

public class Server {
   private Socket socket = null;
   private ServerSocket server = null;
   private DataInputStream input = null;

   // constructor with port
   public Server(int portNum) {
      // try for connection to client
      try {
         // starts server and waits for a connections
         server = new ServerSocket(portNum);
         System.out.println("Server up and waiting for client...");
         // Accept the connection from client and grab the ip via parameter
         socket = server.accept();
         String IPaddress = socket.getRemoteSocketAddress().toString();
         System.out.println("Client accepted at IP and port: " + IPaddress);
         // Then, it's up to the client to answer for the program to continue
         System.out.println("Awaiting Client decision on updating Software...");

         // Input to read in from the client
         input = new DataInputStream(new BufferedInputStream(socket.getInputStream()));

         // Initially set the client string to an empty string
         String client_line = "";
         String new_software = "1.1";
         /*
          * read in the client_line var and conditionally decide whether or not to update
          * the software on the client side
          */
         client_line = input.readUTF();
         // Case 1: User chooses to not update the software
         // Case 2: User chooses to update the software
         // we send the message containing the new software version
         // to the client
         if (client_line.equals("Y")) {
            System.out.println("\nClient has decided to update\n");
            OutputStream output = socket.getOutputStream();
            OutputStreamWriter outWriter = new OutputStreamWriter(output);
            BufferedWriter bwriter = new BufferedWriter(outWriter);
            bwriter.write(new_software);
            System.out.println("\nSoftware version sent to client: " + new_software);
            bwriter.flush();
         }
         // client chooses N
         else if (client_line.equals("N")) {
            System.out.println("Client chose not to update" + "\nSoftware on client still at version: 1.0");
            System.out.println("\n========Server=End==========\n");
            System.exit(0);
         }
         // client chooses neither Y or N
         else {
            System.out.println("Client entered an option that was not Y or N, please run again");
            System.out.println("\n========Server End==========\n");
            System.exit(0);
         }
         // After the action is done, close the connection
         System.out.println("Connection is closed");

         // close connection
         socket.close();
         input.close();
      }
      // catch any IO errors thrown from the beginning
      // of the try up at the top of function
      catch (IOException i) {
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