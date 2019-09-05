import java.net.*;
import java.io.*; 
  
public class Server 
{ 
    //initialize socket and input stream 
    private Socket          socket   = null; 
    private ServerSocket    server   = null; 
    private DataInputStream input       =  null; 
  
    // constructor with port 
    public Server(String ip,int portNum) 
    { 
        // starts server and waits for a connection 
        try
        { 
            server = new ServerSocket(portNum); 
            System.out.println("Server up and waiting for client"); 
            socket = server.accept(); 
            System.out.println("Client accepted at IP: " + ip); 
            System.out.println("Awaiting Client decision on updating Software");
  
            // takes input from the client socket 
            input = new DataInputStream( 
                new BufferedInputStream(socket.getInputStream())); 
   
            String client_line = "";
            // reads message from client until "Over" is sent 

            String new_soft = "1.1";
            client_line = input.readUTF();
            if (!client_line.equals("Y")){
                System.out.println("Software was not updated, Goodbye");
                System.exit(0); 
            }
            else{ 
                System.out.println("Software has been updated to version: "+new_soft); 
            } 
                
            System.out.println("Connection is closed"); 

            // close connection 
            socket.close(); 
            input.close(); 
        } 
        catch(IOException i) 
        { 
            System.out.println(i); 
        } 
    } 
  
    public static void main(String args[]) 
    { 
        Server server = new Server("127.0.0.1",5000); 
    } 
} 