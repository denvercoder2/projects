## Instructions On Running
---

`If you have an instance of python running on your machine :` 
-  I've written a build tool using python in order to compile the code in the correct order. It's mainly to save myself time in the testing phase, but if you want to run it for grading, I'll put the instructions in a terminal below. This wasn't part of the assignment, so I used something not approved for the languages.

```bash
    # running the build tool
    # all this does is compile the java code for you
    python3.7 buildTool.py  # Use your instance of python to call this 

    
    # This may act weird due to some java environments
    # if so, just disregard and use other instructions 
```

---
`If you just want to compile it normally : `
```bash
#------------------------------------------------------------------
# Linux and Windows instructions

javac Receiver.java             # Compile the class to translate into bytecode
javac Server.java               # Compile the class to translate into bytecode

java Server                     # Start Server
java Receiver                   # Start Receiver 
#------------------------------------------------------------------
```
`If you just set it up as a project : `
- Disregard this readMe, and do whatever you usually do for running.
---