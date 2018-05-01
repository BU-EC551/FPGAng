# Verilog Code README

## Bluetooth, Parser, and Controller [Mo and Nick]

###1. Bluetooth
The first part of writing the code to bluetooth was creating a connection between the Adafruit bluetooth chip and the fpga.
We did this by making a module that takes clock and serial data, and outputs a drive line signal and a byte of data to our parser
module. Essentially, the serial data from bluetooth is converted into byte packets and sent to the parser. The baud rate we used
was 100 mHz on the board divided by 9600 so we ended up with 10400 clks_per_bit.

###2. Parser
The parser module reads 4 bytes at a time, looking for a start byte in hex for "!", then a button press "B", which specific button "1,2,3..", and lastly 1 or 0 for a press or release. We then perform a cyclic redundancy check and pass a ready signal to the controller. Before that, in this module we also control which mode the rover is in. Either autonomous or control mode, by passing it a "aa" for autonomous or "cc" for controlled. Based on 

###3. Controller
The parser module reads 4 bytes at a time, looking for a start byte in hex for "!", then a button press "B", which specific button "1,2,3..", and lastly 1 or 0 for a press or release. We then perform a cyclic redundancy check and pass a ready signal to the controller. Before that, in this module we also control which mode the rover is in. Either autonomous or control mode, by passing it a "aa" for autonomous or "cc" for controlled. Based on 

## Autonomous Mode Code [Jason and Gan]
###1. Top_sensor.v
This is the top module for the automonous mode, it connect four sensors and the turn module.
###2. turn.v
This is the control signal for automonous mode, based on the distance from 4 sensors, it decides the direction of the car. It is a state machine of six states.
###3. Sonic_detect.v
This module is the top module for each sensor. It connects TrigSignal, clk_1m, and the PosCounter. 
###4. PosCounter.v
This module is to calculate the distance based on the time of echo signal received from sensor. The input is echo signal and output the distance.
###5. Clk_1M.v
The clock divider to divid the clock from 100MHz to 1MHZ. Used in detection of the distances.
###6. TrigSignal.v
The TrigSignal send the Trig signal for sensor every 0.1 second, and each signal pulse is 10us. 
###7. Display.v
Display module for seven segment, worked on Zedboard, not on mircozed.
###8. BCD_Conversion.v
The module is to convert the distance into digits for seven segment to display. This module works on the Zedboard and Not used in mirozed because there is no display on the board. 

## Motor Driver Code [Ben]

###1. Top Module
The top module instantiates the two control modes and selects between the control signals based on the current mode. If in autonomous mode, the speed defaults to the fastest option. A1 and A2 drive the rear motor, and A3 and A4 drive the front motor for steering. EN12 is the enable pin for the rear motor (outputs A1 and A2). We implemented PWM by enabling and disabling these channels of the motor driver repeatedly.

###2. PWM Generator
The PWM generator takes in a speed between 0 and 3, then selects the duty cycle to drive the motor at accordingly. Speed 1 is 65 %, speed 2 80%, and speed 3 95%. Speed 0 is stop. The output signal "pwm" is initialized to 1, and then after D\*1000 clock pulses, pwm is set to 0. The clock on both the Nexys 3 and Microzed is 100MHz, so every 1000 clock pulses is 1/100 of a millisecond. The target output frequency of the PWM signal is 1kHz, so every 1000 clock cycles corresponds to a 1% change in duty cycle.
