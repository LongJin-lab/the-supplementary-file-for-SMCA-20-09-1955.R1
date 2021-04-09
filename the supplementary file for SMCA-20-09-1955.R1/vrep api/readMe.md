The installation, configuration and tutorial of the virtual robot experimentation platform (V-rep) can be downloaded from 
the official website (https://www.coppeliarobotics.com/). After installation and configuration, open mainfile.ttt in V-rep and
start the simulation of the robot arm motion planning task, import the generated angle data.txt, and then run file: baxter_write3.m in Matlab.
Make sure you have following files in your directory, in order to run the various examples:

1. remApi.m
2. remoteApiProto.m
3. the appropriate remote API library: "remoteApi.dll" (Windows), "remoteApi.dylib" (Mac) or "remoteApi.so" (Linux)
4. simpleTest.m (or any other example program)