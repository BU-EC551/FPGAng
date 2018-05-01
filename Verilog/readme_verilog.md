# Verilog Code README

## Bluetooth, Parser, and Controller [Mo and Nick]

1. Bluetooth
The first part of writing the code to bluetooth was creating a connection between the Adafruit bluetooth chip and the fpga.
We did this by making a module that takes clock and serial data, and outputs a drive line signal and a byte of data to our parser
module. Essentially, the serial data from bluetooth is converted into byte packets and sent to the parser. The baud rate we used
was 100 mHz on the board divided by 9600 so we ended up with 10400 clks_per_bit.

2. Parser

3. Controller

## Autonomous Mode Code [Jason and Gan]

## Motor Receiver Code
