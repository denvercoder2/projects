/*
Scott Holley
CS470
Project 1: Client/Server update connection

Purpose: 
    Start connection at beginning of run;
    Check for update;
    Decide whether to update or not;
*/
import java.net.*;
import java.io.*;

public class Client {

    public static void main(String [] args) {
       // Making the server name as the local host port number
        String serverName = "127.0.0.1";
        int port = 12896;
        try {
            System.out.println("Connecting to " + serverName + " on port " + port);
            // Setting up the socket for client
            Socket client = new Socket(serverName, port);
            System.out.println("Client is now connected at: " + client.getRemoteSocketAddress());
            OutputStream outToServer = client.getOutputStream();
            DataOutputStream out = new DataOutputStream(outToServer);
            String soft_vers = " 1.1";
            // Sending the data stream to server
            out.writeUTF("Current Software version is: " + soft_vers);
            InputStream inFromServer = client.getInputStream();
            DataInputStream in = new DataInputStream(inFromServer);
            // Reading back the data from server
            System.out.println(in.readUTF());
            client.close();
            } catch (IOException e) {
            e.printStackTrace();
            }
        }
    }