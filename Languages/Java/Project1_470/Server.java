// File Name Server.java
import java.io.*;
<<<<<<< HEAD
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
=======

public class Server extends Thread {
    private ServerSocket serverSocket;

    public Server(int port) throws IOException {
    // Initializing the server
    serverSocket = new ServerSocket(port);
    serverSocket.setSoTimeout(30000);
    }

    public void run() {
    while(true) {
    try {
        
    System.out.println("Waiting for client on port " +
    serverSocket.getLocalPort() + "...");
    // Waiting for connection
    Socket server = serverSocket.accept();
    // IP Address and client port number
    System.out.println("Connected to IP: " + server.getInetAddress());
    // Reading the stream sent by the client
    DataInputStream in = new DataInputStream(server.getInputStream());
    System.out.println(in.readUTF());
    // Sending back the newer version
    DataOutputStream out = new DataOutputStream(server.getOutputStream());
    out.writeUTF("Thank you for connecting to " + server.getLocalSocketAddress()
    + " New Software version is 1.2");
    server.close();
    
    } catch (SocketTimeoutException s) {
    System.out.println("Socket timed out!");
    break;
    } catch (IOException e) {
        e.printStackTrace();
        break;
        }
    }
}

    public static void main(String [] args) {
    int port = 12896;
    try {
        Thread t = new Server(port);
        t.start();
        } catch (IOException e) {
        e.printStackTrace();
        }
    }
>>>>>>> 77bb739b7979691f3165003ade81fe7726095287
}