import java.io.IOException;
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;
import java.net.UnknownHostException;
 
public class Server {
   
   public static void sendOut(String addr, int port)throws UnknownHostException, InterruptedException{
      // Get the address that we are going to connect to.
      InetAddress address = InetAddress.getByName(addr);
   
      // Open a new DatagramSocket, which will be used to send the data.
      try (DatagramSocket serverSocket = new DatagramSocket()) {
         while(true) {
               String msg = "=== Broadcasting out ===";

               // Create a packet that will contain the data
               // (in the form of bytes) and send it.
               DatagramPacket msgPacket = new DatagramPacket(msg.getBytes(),
                     msg.getBytes().length, address, port);
               serverSocket.send(msgPacket);
   
               System.out.println("Server sent packet with msg: " + msg);
               Thread.sleep(500);
         }
      } catch (IOException ex) {
         ex.printStackTrace();
      }
   }
   public static void main(String[] args)throws UnknownHostException, InterruptedException {
      String addr = "127.0.0.1";
      int port = 5000;
      sendOut(addr, port);
   }
}