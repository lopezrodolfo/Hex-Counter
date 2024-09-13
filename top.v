////////
// 
//	comp300-fa22-p2-1/top.v
//
//	Project 2 Second Week Starter
//	
//	This circuit creates a a multiplexed 7-segment display
//	using the 16 Mhz clock of the Upduino3 board. The
//      display is tested with a counter that counts seconds. 
//
//  Note: errors and omissions abound
//
//	Chuck Pateros
//	University of San Diego
//	2022-10-08
//
////////


// look in upduino3.pcf for the mapping of signals to UPduino board pins
module top (
    input CLK,         // 16MHz clock provided by UPduino board
    output [6:0] SEG,  // seven-segment display segments (active high)
    output [3:0] COMM, // seven-segment display common cathodes (active low) 
    output [3:0] DBG,  // LEDs installed into breadboard (active high)
    output [2:0] RGB   // RGB LED is built into UPduino board (active low)
);
 
    reg [3:0] hex2Display; // the 4 bits we want to display

 
    reg [6:0] seg;
    reg [3:0] comm;
   
    // drive board LEDs
    assign SEG = seg;
    assign RGB = 3'b111;
    assign COMM = comm;

    /// second timer signals
    localparam [23:0] timer_init = 24'hB71AFF;
    localparam [15:0] second_init = 16'hABCD;
    reg [23:0] second_timer_state;
    reg [15:0] second;

    /// preload second timer state machine
    initial begin
        second_timer_state = timer_init;
        second = second_init;
    end /// end timer state initial begin

    /// second_timer
    /// second timer state machine
    /// increments every second
    always @(posedge CLK) begin
        if (second_timer_state == 0) begin
            second_timer_state = timer_init;
            second = second + 1;
         end /// end if
        else begin
            second_timer_state <= second_timer_state - 1;
        end /// end else
    end /// second timer state machine

    // Use debug LEDs to show low order 4 bits of second count
    assign DBG = second[3:0];


    ////////
    // simple refreshCounter circuit 
    ////////

    // keep track of refreshCount
    reg [23:0] refreshCounter;

 
    // increment the refreshCounter every clock
    always @(posedge CLK) begin
        refreshCounter <= refreshCounter + 1;
    end


    always @(*) begin
        case(hex2Display) // upside down
            4'b0000   : seg = 7'b1000000; // 0 CEO
            4'b0001   : seg = 7'b1001111; // 1 PM
            4'b0010   : seg = 7'b0100100; // 2 PM
            4'b0011   : seg = 7'b0000110; // 3 DEV
            4'b0100   : seg = 7'b0001011; // 4 DEV
            4'b0101   : seg = 7'b0010010; // 5 DEV
            4'b0110   : seg = 7'b0010000; // 6 DEV
            4'b0111   : seg = 7'b1000111; // 7 DEV
            4'b1000   : seg = 7'b0000000; // 8 CEO
            4'b1001   : seg = 7'b0000010; // 9 Test
            4'b1010   : seg = 7'b0000001; // 10 (A) Test
            4'b1011   : seg = 7'b0011000; // 11 (b) Test 
            4'b1100   : seg = 7'b1110000; // 12 (C) Test 
            4'b1101   : seg = 7'b0001100; // 13 (d) Test 
            4'b1110   : seg = 7'b0110000; // 14 (E) Test
            4'b1111   : seg = 7'b0110001; // 15 (F) Test
            default   : seg = ~7'b0000000; // display dark for error
        endcase // hex to seven-segment case
         
        case(refreshCounter[13:12]) // digit scrolling
            4'b00   : comm = ~4'b1110;
            4'b01   : comm =  4'b0100;
            4'b10   : comm =  4'b1000;
            4'b11   : comm =  4'b0010;
            default : comm =  4'b0000; // light all if error
       endcase

    /// selects the hex digit for the currently displayed digit
          case(refreshCounter[13:12])
            2'b00   : hex2Display = second[15:12];
            2'b01   : hex2Display = second[7:4];
            2'b10   : hex2Display = second[3:0];
            2'b11   : hex2Display = second[11:8];
              default : hex2Display = 4'hE;  // 'E' for error!  
          endcase
       
    end // combinational circuits

endmodule

