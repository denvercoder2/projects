import java.io.*;
import java.net.*;
 
public class Receiver {

    /*
    * Function: connectTCP
    * --
    * Arguments: String, Int
    * --
    * =============== Purpose =============== 
    * If the user chooses, server can interact with the
    * client through a Unicast method, using TCP
    */
    public static void connectTCP(String addr, int port) throws IOException{
    Socket clientSocket;
    PrintWriter out;
    BufferedReader in;
 
    clientSocket = new Socket(addr, port);
    out = new PrintWriter(clientSocket.getOutputStream(), true);
    in = new BufferedReader(new InputStreamReader(clientSocket.getInputStream()));
    in.close();
    out.close();
    clientSocket.close();

    }
    /*
    * Function: connectUDP
    * --* 
    * Arguments: String, Int
    * --
    * =============== Purpose =============== 
    * If the user chooses, server can interact with the
    * client through a Multicast method using UDP
    */
    public static void connectUDP(String addr, int port) throws UnknownHostException{
         // Get the address that we are going to connect to.
         InetAddress address = InetAddress.getByName(addr);
         
         // Create a buffer of bytes, which will be used to store
         // the incoming bytes containing the information from the server.
         // Since the message is small here, 256 bytes should be enough.
         byte[] buf = new byte[256];
          
         // Create a new Multicast socket (that will allow other sockets/programs
         // to join it as well.
         try (MulticastSocket clientSocket = new MulticastSocket(port)){
             //Joint the Multicast group.
             clientSocket.joinGroup(address);
       
             while (true) {
                 // Receive the information and print it.
                 DatagramPacket msgPacket = new DatagramPacket(buf, buf.length);
                 clientSocket.receive(msgPacket);
  
                 String msg = new String(buf, 0, buf.length);
                 System.out.println("Client has received msg: " + msg);
             }
         } catch (IOException ex) {
             ex.printStackTrace();
         }
     }
    public static void main(String[] args) throws UnknownHostException, IOException{
        String addr = "127.0.0.1";
        int port = 5000;
        String choice = null;
        
        Socket socket            = null;
        BufferedReader input     = null; 
        DataOutputStream output  = null; 

        socket = new Socket(addr, port);
        System.out.println("Enter the choice for testing: \n1) Unicast via TCP\n2) Multicast via UDP");
        input = new BufferedReader(new InputStreamReader(System.in));
        output = new DataOutputStream(socket.getOutputStream()); 
        choice = input.readLine();
        output.writeUTF(choice);
        if (choice.equals("1")) {
            InputStream in = socket.getInputStream();
            InputStreamReader inputReader = new InputStreamReader(in);
            BufferedReader breader = new BufferedReader(inputReader);
            String message = breader.readLine();
            System.out.println("Message recieved from server : " +message);
            // connectTCP(addr, port);
        }
        else if (choice.equals("2")) {
            addr = "224.0.0.255";
            port = 8888;
            connectUDP(addr, port);
        }
        else{
            System.out.println("You entered a choice that was not available");
            System.exit(1);
        }
        input.close(); 
        output.close(); 
        socket.close(); 
    }
}