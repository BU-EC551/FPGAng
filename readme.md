# FPGAng's Controlled and Autonomous Rover

## Hardware

1. [Microzed](http://www.zedboard.org/product/microzed)
   The Microzed holds a Zynq 7010 SoC. This project only uses the FPGA mesh on the chip,
   except for booting the bitstream from a microSD card, which uses the ARM processor on the Zynq. 
2. [Microzed Breakout Carrier Card](http://zedboard.org/product/microzed-breakout-carrier-card)
   The carrier card allowed us access to the programmable logic I/O pins on the Microzed.
3. [Adafruit BLE UART Friend](https://www.adafruit.com/product/2479)
4. [Ultrasonic Distance Sensor](https://www.amazon.com/HC-SR04-Ultrasonic-Distance-Measuring-Sensor/dp/B00F167T2A)
5. [L293D Motor Driver](https://www.mouser.com/ProductDetail/STMicroelectronics/L293D/?qs=gr8Zi5OG3MgMJ1ICDzLQbg%3D%3D&gclid=CjwKCAjwoKDXBRAAEiwA4xnqv5YjH1lbMSurImEGttWaS185mPXIEui-msaRmnfbPLBNqcMmYTvw_xoCT8UQAvD_BwE)
   The L293D motor driver is a chip containing 4 tri-states, with 2 enable pins that enable each pair of tri-states. It can drive up to 600 mA from each tri-state output.
6. RC Car 

## Controlled Mode

The [Adafruit BLE UART Friend](https://www.adafruit.com/product/2479) was used in conjunction with the free app provided by Adafruit, which has a controller built-in. There are 4 directional buttons,
as well as 4 speed buttons. Button 1 is stop, and buttons 2 through 4 set different speeds for the car. Sending the character "c" to the car will put it into controlled mode,
and sending an "a" will put it into autonomous mode.

## Autonomous Mode

We mounted 4 ultrasonic sensors on the RC car, 2 on the front and one on either side. The car will stop if there is an obstacle in front of it, and then read the distance sensed by all 4 sensors. If it is too close
to the obstacle in front of it, it will back up. If not, it will check the distance on both sides and turn the direction in which there is more room (i.e. in which the closest obstacle is farthest away).
