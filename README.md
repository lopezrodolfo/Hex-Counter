# Seven-Segment Hexadecimal Display Counter

This project implements a multiplexed 7-segment display counter using an Upduino3 FPGA board. It displays a hexadecimal counter that increments every second.

## Authors

- CEO: Rodolfo Lopez
- PM: Samuel Cacnio
- Dev: Tyson Aramaki
- Test: Frank Veldhuizen

## Date

10/16/22

## Features

- Utilizes the Upduino3's 16 MHz clock
- Drives a 4-digit 7-segment display
- Counts in hexadecimal, incrementing every second
- Uses onboard RGB LED and additional debug LEDs

## Files

- `top.v`: Main Verilog module implementing the display logic and counter
- `upduino3.pcf`: Pin constraints file for the Upduino3 board
- `Makefile`: Build and upload commands for the project

## Building and Uploading

To build and upload the project to your Upduino3 board:

1. Ensure you have the necessary tools installed (Yosys, nextpnr-ice40, icepack, iceprog)
2. Run `make upload` in the project directory

## Usage

Once uploaded, the 7-segment display will show a hexadecimal counter incrementing every second. The onboard RGB LED and additional debug LEDs will also be utilized as specified in the code.

## Notes

- The display is multiplexed, cycling through each digit rapidly
- The counter starts at an initial value of 0xABCD
- Error handling is included for unexpected states

For more details, refer to the comments in the source code files.

## Acknowledgements

The starter code was written by Professor Chuck Pateros. Our team:

- Implemented the hex decoder
- Chose digit scrolling rate
- Determined the hexadecimal second timer init value
- Multiplexed the 16 bit second counter to 4 bits for display
- Built, integrated and tested changes
