import java.io.*;
import java.net.*;

import javax.naming.BinaryRefAddr;

public class Server{
    /*
    * Function: sendOutTCP
    * --* 
    * Arguments: Int
    * --
    * =============== Purpose =============== 
    * If the user chooses, server can interact with the
    * client through Unicast TCP
    */
   public static void sendOutTCP(int port)throws IOException{
      ServerSocket serverSocket;
      Socket clientSocket;
      PrintWriter out;
      BufferedReader in;
      serverSocket = new ServerSocket(port);
      clientSocket = serverSocket.accept();
      out = new PrintWriter(clientSocket.getOutputStream(), true);
      in = new BufferedReader(new InputStreamReader(clientSocket.getInputStream()));
      String greeting = in.readLine();
         if ("Testing connection via Unicast with TCP".equals(greeting)) {
            out.println("Connection Successful");
         }
         else {
            out.println("Message Received");
         }

         in.close();
         out.close();
         clientSocket.close();
         serverSocket.close();
   }
    /*
    * Function: sendOutUDP
    * --* 
    * Arguments: String, Int
    * --
    * =============== Purpose =============== 
    * If the user chooses, server can interact with the
    * client through a Multicast method using UDP
    */
   public static void sendOutUDP(String addr, int port)throws UnknownHostException, InterruptedException{
      // Get the address that we are going to connect to.
      InetAddress address = InetAddress.getByName(addr);
   
      // Open a new DatagramSocket, which will be used to send the data.
      try (DatagramSocket serverSocket = new DatagramSocket()) {
         while(true) {
               String msg = "=== Movie Data sample ===";

               // Create a packet that will contain the data
               // (in the form of bytes) and send it.
               DatagramPacket msgPacket = new DatagramPacket(msg.getBytes(),
                     msg.getBytes().length, address, port);
               serverSocket.send(msgPacket);
   
               System.out.println("Server sent packet with msg: " + msg);
               Thread.sleep(100);
         }
      } catch (IOException e) {
         System.out.println(e);
      }
   }


   public static void main(String[] args)throws UnknownHostException, InterruptedException, IOException {
      Socket socket           = null; 
      ServerSocket server     = null; 
      DataInputStream input   = null; 
      int portNum = 5000;
      String TCPmessage = "Successfully sent with TCP";
      server = new ServerSocket(portNum); 
      System.out.println("\n======== Server Up ========\n"); 
      socket = server.accept(); 
      String IPaddress = socket.getRemoteSocketAddress().toString();
      System.out.println("Client accepted at IP and port: " + IPaddress);
      System.out.println("Waiting for them to choose a protocol");
      input = new DataInputStream( 
         new BufferedInputStream(socket.getInputStream())); 

         
     // Initially set the client string to an empty string
     String client_line = "";
     /* 
     read in the client_line var and conditionally decide whether or
     not to update the software on the client side 
     */
     client_line = input.readUTF();
     // Case 1: User chooses to not update the software
     // Case 2: User chooses to update the software
     // we send the message containing the new software version
     // to the client
     if(client_line.equals("1")){

         try{
            System.out.println("\n========Server Start========\n"); 
            sendOutTCP(portNum);
         }
         catch(BindException b){
            System.out.print("State has changed from Multicast to unicast");
            System.out.print("Client has been sent a message through Unicast with TCP");
            portNum = 5001;
            OutputStream output = socket.getOutputStream();
            OutputStreamWriter outWriter = new OutputStreamWriter(output);
            BufferedWriter bwriter = new BufferedWriter(outWriter);
            bwriter.write(TCPmessage);
            bwriter.flush();
         }
     } 
     else if (client_line.equals("2")){
         System.out.println("\n========Server Start========\n");
         portNum = 8888;
         IPaddress = "224.0.0.255";
        sendOutUDP(IPaddress, portNum);
     }
      server.close(); 
      input.close();
   }
}