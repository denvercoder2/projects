## Project 1: CS470
---
## Components
* Language = Java
* Client and Server Steps: 
    * Process
        1. Build a client/server connection to run software "up to date" check when device is turned on
        The client connects to the server when program starts

        2. Server will wait on fixed IP address and port number (Hardcoded)

        3. Client will send its current version of software to server

        4. The server displays the message from the client and also displays the client’s IP address on its screen. The client’s IP address should not be hard coded in its message

        5. The server returns a newer version of the software.

        6. Client will display a message which verifies if the user wants to upgrade software


---
* Running the code
```bash
#------------------------------------------------------------------
# Linux and Windows instructions

javac Server.java   # Compile the class to translate into bytecode
javac Client.java   # Compile the class to translate into bytecode

java Server         # Start the Server 
java Client         # Start the Client
#------------------------------------------------------------------


```
* The remainder of the program is handled via terminal prompts
---   

