import java.io.*;
import java.net.*;
 
public class Receiver {

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
        // Get the address that we are going to connect to from port
        InetAddress address = InetAddress.getByName(addr);
        
        // create a small buffer to store the message in.
        // 256 byte should be enough to hold our small message
        byte[] buf = new byte[256];
        
        // UDP/Multicast here. The joining below allows
        // clients to be apart of a group, and receive all of the same
        // info from the server.
        try (MulticastSocket clientSocket = new MulticastSocket(port)){
            //Join the Multicast group.
            clientSocket.joinGroup(address);
            // this is where the simulated "movie data" should come through
            while (true) {
                // Receive the information and print it.
                DatagramPacket msgPacket = new DatagramPacket(buf, buf.length);
                clientSocket.receive(msgPacket);
                // give us an output to see on screen
                String msg = new String(buf, 0, buf.length);
                System.out.println("\nClient has received msg: " + msg);
            }
        } catch (IOException e) {
            System.out.println(e);
        }
    }
    public static void main(String[] args) throws UnknownHostException, IOException{
        
        try{
            // Local Variables to use with function calls 
            // 
            InetAddress local = InetAddress.getLocalHost();
            String addr = local.getHostAddress();
            int port = 5000;
            String choice = null;
            // initialize the objects we'll need
            Socket socket            = null;
            BufferedReader input     = null; 
            DataOutputStream output  = null; 
            
            // Get the user input and decide which path to go from there (same network)
            socket = new Socket(addr, port);
            // let the user choose which to test
            System.out.println("\nEnter the choice for testing: \n1) Slide Simulation with TCP (Unicast: Classroom)\n2) Movie Simulation with UDP (Multicast: Dorm)");
            input = new BufferedReader(new InputStreamReader(System.in));
            output = new DataOutputStream(socket.getOutputStream()); 
            // read that input and go with correct option
            choice = input.readLine();
            output.writeUTF(choice);
            // Path 1: User chooses Unicast with TCP
            if (choice.equals("1")) {
                System.out.printf("Client has joined at: %s at port: %d", addr, port);
                // this is the tcp function essentially just within the block
                InputStream in = socket.getInputStream();
                InputStreamReader inputReader = new InputStreamReader(in);
                BufferedReader breader = new BufferedReader(inputReader);
                String message = breader.readLine();
                System.out.println("Message recieved from server : " + message);
            }
            // Path 2: User chooses Mulitcast with UDP
            else if (choice.equals("2")) {
                // specific multicast port after intial connection
                addr = "224.0.0.255";
                port = 8888;
                System.out.printf("Client has joined at: %s at port: %d", addr, port);
                connectUDP(addr, port);
            }
            // User enters something else (not UDP or TCP)
            else{
                System.out.println("You entered a choice that was not available");
                System.exit(1);
            }
            // Close the resources
            input.close(); 
            output.close(); 
            socket.close(); 
        }
        // Catch if server isn't started
        catch(ConnectException w){
            System.out.println("Client is searching . . .");
        }
    }
}