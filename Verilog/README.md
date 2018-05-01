# Verilog Code README

## Bluetooth, Parser, and Controller [Mo and Nick]

1. Bluetooth
The first part of writing the code to bluetooth was creating a connection between the Adafruit bluetooth chip and the fpga.
We did this by making a module that takes clock and serial data, and outputs a drive line signal and a byte of data to our parser
module. Essentially, the serial data from bluetooth is converted into byte packets and sent to the parser. The baud rate we used
was 100 mHz on the board divided by 9600 so we ended up with 10400 clks_per_bit.

2. Parser
The parser module reads 4 bytes at a time, looking for a start byte in hex for "!", then a button press "B", which specific button "1,2,3..", and lastly 1 or 0 for a press or release. We then perform a cyclic redundancy check and pass a ready signal to the controller. Before that, in this module we also control which mode the rover is in. Either autonomous or control mode, by passing it a "aa" for autonomous or "cc" for controlled. Based on 

3. Controller
The parser module reads 4 bytes at a time, looking for a start byte in hex for "!", then a button press "B", which specific button "1,2,3..", and lastly 1 or 0 for a press or release. We then perform a cyclic redundancy check and pass a ready signal to the controller. Before that, in this module we also control which mode the rover is in. Either autonomous or control mode, by passing it a "aa" for autonomous or "cc" for controlled. Based on 

## Autonomous Mode Code [Jason and Gan]

## Motor Receiver Code [Ben]
