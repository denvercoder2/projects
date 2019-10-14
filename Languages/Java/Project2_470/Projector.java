 /*
    Scott Holley
    CS470 Project 2
    Due: November 4th
    Filename: Projector
 */
import java.net.*;
import java.io.*; 
  

/*
======================================== GENERAL OVERVIEW ========================================
| The Projector Class is to act as an interface for the mobile device to find                    |
| The projector should have two modes (Classroom, or dorm).                                      |
| This is to be specified to the mobile device, and from there, the type of media                |
| that can be displayed is determined.                                                           |
======================================== GENERAL OVERVIEW ========================================
*/
import java.net.*;

// The projector acts like the server
public class Projector{
    // TCP connection initilization
    private Socket socket           = null; 
    private ServerSocket projector  = null; 
    private DataInputStream input   = null; 

    // constructor
    public Projector(int portNum){
        try {
            projector = new ServerSocket(portNum); 
            System.out.println("Server up and waiting for client..."); 
            // Accept the connection from client and grab the ip via parameter
            socket = server.accept(); 
            String IPaddress = socket.getRemoteSocketAddress().toString();
            System.out.println("Client accepted at IP and port: " + IPaddress); 

        } catch (Exception e) {
            System.out.println("Connection to projector could not be established");
        }
    }


    public static void main(String[] args) {
        System.out.println("TBD");
    }
}