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
import java.net.*; 
import java.io.*; 
  
public class Server 
{ 
    //initialize socket and input stream 
    private Socket          socket   = null; 
    private ServerSocket    server   = null; 
    private DataInputStream in       = null; 
  
    // constructor with port 
    public Server(String ip,int port) 
    { 

        File clientSide = new File("client-software.txt");
        File serverSide = new File("server-software.txt");
        
        // starts server and waits for a connection 
        try
        {   
            String update_key = "1.1"; 

            server = new ServerSocket(port); 
            System.out.println("Server started"); 
  
            System.out.println("Waiting for a client ..."); 
  
            socket = server.accept(); 
            System.out.println("Client accepted"); 
  
            // takes input from the client socket 
            in = new DataInputStream( 
                new BufferedInputStream(socket.getInputStream())); 
  
            String line = ""; 
  
            // reads message from client until "Over" is sent 
            while (!line.equals("Exit")) 
            { 
                try
                { 
                    line = in.readUTF(); 
                    System.out.println(line); 
  
                } 
                catch(IOException i) 
                { 
                    System.out.println(i); 
                } 
            } 
            System.out.println("Closing connection"); 
  
            // close connection 
            socket.close(); 
            in.close(); 
        } 
        catch(IOException i) 
        { 
            System.out.println(i); 
        } 
    } 
  
    public static void main(String args[]) 
    { 
        String ip_addr = "192.168.1.2";
        Server server = new Server(ip_addr ,5000); 
    } 
} 