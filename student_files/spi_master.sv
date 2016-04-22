/*
 * FILE: spi_master.sv
 * AUTHOR: Joshua Reed
 * DATE: Nov. 25, 2015
 * DESCRIPTION: SPI master module that can be incorporated into a
 * larger project.  
 * To use, load to_send with a byte of data while holding transmit low. 
 * Then switch transmit high. The byte will be sent over
 * the next 16 clk cycles, and done will go high. To clear done
 * pull transmit to low.
 * MISO -> Master In Slave Out
 * MOSI -> Master Out Slave In
 * SCK -> Shift Clock
 * 
 */


module spi_master( 
    input clk, reset, MISO, transmit,
    input [7:0] to_send, // data to be sent
    output logic MOSI, SCK, 
    output logic [7:0] received,
    output logic done );

    enum {setup, communicate, finished} state;
    logic unsigned [3:0] cnt;
    logic [7:0] hold_to_send;
        
    always_comb 
        if (cnt % 2 == 0) SCK <= 0;
        else SCK <= 1;

    assign MOSI = hold_to_send[7]; // Send MSB

    always_comb 
        if (state == finished) done <= 1;
        else done <= 0;

    always_ff @ (posedge clk, negedge reset)
        if (~reset) begin
            state <= setup;
            cnt <= 15;
            received <= 0;
            end 
        else begin
            case(state)
                setup: begin
                    hold_to_send <= {to_send[0], to_send[7:1]}; // Load to send reverse cycled by one
                    if (transmit) state <= communicate;
                    end
                communicate: begin
                    cnt <= cnt-1;
                    if (cnt % 2 == 1) begin // odd cycle
                        if (cnt != 1) hold_to_send <= {hold_to_send[6:0], hold_to_send[7]}; // Rotate data on even number cycles
                        received <= {received[6:0], MISO}; // Save current data bit in received
                        end
                    if (cnt == 0) begin 
                        state <= finished;
                        received <= {received[6:0], MISO}; // Save current data bit in received
                        end
                    end
                finished: begin
                    cnt <= 15;
                    if (~transmit) state <= setup;
                    end
                default: state <= setup;
                endcase
            end 

    endmodule



// Rudimentary Test Bench

//module spi_master_tb( );
//
//    logic clk, reset, transmit;
//
//    initial begin
//        $display($time, " << Sim starting >> ");
//        clk = 0;
//        reset = 0;
//        transmit = 0;
//        #20 reset = 1;
//        #80 transmit = 1;
//    end
//
//    always #10 clk = ~clk; // invert ten nano-secs
//
//    spi_master uut(
//        .clk     ( clk         ), 
//        .reset   ( reset       ), 
//        .MISO    ( 1'b1        ), 
//        .transmit( transmit    ),
//        .to_send ( 8'b01111110 ),
//        .MOSI    (             ), 
//        .SCK     (             ), 
//        .received(             ) );
//
//endmodule




