The VirtualHere client docker image <b>allows you to use USB devices inside a container</b>. 

DockerFile here: https://github.com/tcjj3/virtualhere-client_Docker/blob/master/Dockerfile

<b>Instructions for using this image:</b>

(This works under Windows and Mac, for Linux use KVM containers https://github.com/gotoz/runq/)

1. Plug the USB device into a purchased virtualhere server. 
2. Run the container like this:
   <pre>docker run -td --privileged --restart always --name vhclient -v /lib/modules:/lib/modules tcjj3/virtualhere-client_docker:latest ./vhclient</pre>
    or 
   <pre>docker volume create vhclient_config
   docker run -td --privileged --restart always --name vhclient -v /lib/modules:/lib/modules -v vhclient_config:/root tcjj3/virtualhere-client_docker:latest ./vhclient</pre>

3. Now you can use the virtualhere API to connect to the virtualhere server and use a device. 

For example:
<pre>
C:\Users\tcjj3\docker-virtualhere-client>docker exec vhclient ./vhclient -t "MANUAL HUB ADD,192.168.0.16"
OK

C:\Users\tcjj3\docker-virtualhere-client>docker exec vhclient ./vhclient -t "LIST"
VirtualHere Client IPC, below are the available devices:
(Value in brackets = address, * = Auto-Use)

Desktop Hub (SERVER:7575)
   --> Portable SSD T5 (SERVER.82)
   --> Token JC (SERVER.73) (In-use by: (tcjj3) at 192.168.0.21)
   --> AURA Custom Human interface (SERVER.111)
   --> Corsair Link TM USB Dongle (SERVER.19)

Auto-Find currently on
Auto-Use All currently off
Reverse Lookup currently off
Reverse SSL Lookup currently off
VirtualHere Client not running as a service

C:\Users\tcjj3\docker-virtualhere-client>docker exec vhclient ./vhclient -t "USE,server.111"
OK

C:\Users\tcjj3\docker-virtualhere-client>docker exec vhclient lsusb
Bus 001 Device 001: ID 1d6b:0002
Bus 001 Device 002: ID 0b05:1867

</pre>

Notes:

* The output of the lsusb command confirms the device is attached. (0b05:1867 is the device we used by issuing the <code>USE,server.111</code> command)
* You would need the normal USB device drivers in your docker container. Eg. usb-storage if you want to use a USB disk, usb-serial if you want to use a serial adapter etc , just like a normal linux setup

 
