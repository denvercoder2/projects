/*
Scott Holley
CS470
Project 1: Client/Server update connection

Purpose: 
    Connect with client via IP and Port;
    Display message from clinet as well as clients IP
    Return newest software if client agrees
*/



/*
Server should compare version on client and ask if they want to update
If yes, send the update and overwrite, if no, do nothing
*/

// TODO: 
// Server should start first so client automatically connects
// Client should send software version to server
// Server should display message from client and contain ip address from it
// Server should send new version to client
// Client should choose whether or not to update
// File Name Server.java
import java.io.*;
import java.net.*;

class TCPServer {
 public static void main(String argv[]) throws Exception {
  String clientSentence;
  String capitalizedSentence;
  ServerSocket welcomeSocket = new ServerSocket(6789);

  while (true) {
   Socket connectionSocket = welcomeSocket.accept();
   BufferedReader inFromClient =
    new BufferedReader(new InputStreamReader(connectionSocket.getInputStream()));
   DataOutputStream outToClient = new DataOutputStream(connectionSocket.getOutputStream());
   clientSentence = inFromClient.readLine();
   System.out.println("Received: " + clientSentence);
   capitalizedSentence = clientSentence.toUpperCase() + 'n';
   outToClient.writeBytes(capitalizedSentence);
  }
 }
}