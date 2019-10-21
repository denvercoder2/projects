
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
| There is also a choice on what type of cast to use                                             |
======================================== GENERAL OVERVIEW ========================================
*/

// TCP: Socket
// UDP DataGram
// Multicast, unicast

import java.io.*;
import java.net.*;

class Projector {

    public static void main(String argv[]) throws Exception {
        String clientSentence;
        String capitalizedSentence;
        ServerSocket welcomeSocket = new ServerSocket(6789);

        while (true) {
            Socket connectionSocket = welcomeSocket.accept();
            BufferedReader inFromClient = new BufferedReader(new InputStreamReader(connectionSocket.getInputStream()));
            DataOutputStream outToClient = new DataOutputStream(connectionSocket.getOutputStream());
            clientSentence = inFromClient.readLine();
            System.out.println("Received: " + clientSentence);
            capitalizedSentence = clientSentence.toUpperCase() + 'n';
            outToClient.writeBytes(capitalizedSentence);
            
        }
    }
}