import java.io.*;
import java.net.*;

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
      // initialize the objects we'll need
      ServerSocket serverSocket;
      Socket clientSocket;
      PrintWriter out;
      BufferedReader in;
      // at this point, we're just testing to send a message through TCP
      serverSocket = new ServerSocket(port);
      clientSocket = serverSocket.accept();
      out = new PrintWriter(clientSocket.getOutputStream(), true);
      in = new BufferedReader(new InputStreamReader(clientSocket.getInputStream()));

      // Close resources
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
               // this is where the movie data simulation should come through
               DatagramPacket msgPacket = new DatagramPacket(msg.getBytes(),
                     msg.getBytes().length, address, port);
               serverSocket.send(msgPacket);
   
               System.out.println("Server sent packet with msg: " + msg);
               // Sleep to mimic streaming
               Thread.sleep(100);
         }
      } catch (IOException e) {
         System.out.println(e);
      }
   }


   public static void main(String[] args)throws UnknownHostException, InterruptedException, IOException {

      // get and initialize the objects we'll need
      Socket socket           = null; 
      ServerSocket server     = null; 
      DataInputStream input   = null; 
      // local variables for function calls above
      int portNum = 5000;
      String TCPmessage = "Successfully sent with TCP";
      server = new ServerSocket(portNum); 
      System.out.println("\n======== Server Up ========\n"); 
      // accept the client
      socket = server.accept(); 
      String IPaddress = socket.getRemoteSocketAddress().toString();
      System.out.println("Client accepted at IP and port: " + IPaddress);
      System.out.println("Waiting for them to choose a protocol");
      // wait and see what the client chooses, TCP or UDP
      input = new DataInputStream( 
         new BufferedInputStream(socket.getInputStream())); 

         
     // Initially set the client string to an empty string
     String client_line = "";
     client_line = input.readUTF();

     // If client chooses 1, call TCP function,
     // if the server is already being used as TCP, you'll be alerted
     // since it cannot exist in both states at once
     if(client_line.equals("1")){
         try{
            System.out.println("\n========Server Start========\n"); 
            sendOutTCP(portNum);
         }
         catch(BindException b){
            System.out.print("State has changed from Multicast to unicast.\n");
            System.out.print("Client has been sent a message through Unicast with TCP");
            portNum = 5001;
            OutputStream output = socket.getOutputStream();
            OutputStreamWriter outWriter = new OutputStreamWriter(output);
            BufferedWriter bwriter = new BufferedWriter(outWriter);
            bwriter.write(TCPmessage);
            bwriter.flush();
         }
     } 
     // if client chooses 2, then call the UDP function
     // and edit some of the local variables to accomodate 
     // the differences required between UDP and TCP
     else if (client_line.equals("2")){
         System.out.println("\n========Server Start========\n");
         portNum = 8888;
         IPaddress = "224.0.0.255";
        sendOutUDP(IPaddress, portNum);
     }
     // Close resources
      server.close(); 
      input.close();
   }
}