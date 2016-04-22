// Author: Joshua Reed
// Class:  ECE 272, Spring 2016
// File: adc.sv
// Description: 
// Unipolar volt meter implementation.
// spi_master is instantiated to communicate with the AD7705. 
// A state machine is then used to setup and poll the ADC for 
// voltage readings. 
// The voltage that can be measured by default is 0-5V due to the layout of
// the AD7705 board, and the default gain settings. 




/* instantiation template
 *
 *
 *
    adc volt_meter( .reset    ( your signals here ),   // FPGA reset
                    .clk_2Mhz ( your signals here ),   // directly from OSCH 2.08 MHz Oscillator
                    .MISO     ( your signals here ),   // Pass through to ADC Din
                    .raw_data ( your signals here ),   // 16 bit unsigned 0-5V
                    .MOSI     ( your signals here ),   // Pass through to ADC Dout
                    .adc_reset( your signals here ),   // Pass through to ADC reset
                    .SCK      ( your signals here ) ); // Pass through to ADC SCK
 *
 *
 *
*/
    
//==========================================
//=============================== ADC ======
//==========================================
module adc( input  logic                 reset, clk_2Mhz, MISO,
            output logic unsigned [15:0] raw_data,
            output logic                 MOSI, adc_reset, SCK );
    
    logic done;
    logic transmit;
    logic unsigned [7:0] to_send;
    logic unsigned [15:0] raw_data;
    logic [7:0] data_byte;
        logic prev_done;
        logic unsigned [4:0] cnt;
        enum{CONFIGURE, RQST_COMM, READ_COMM, RQST_DATA, READ_DATA1, READ_DATA2} state;
   
    /* == States ============================= 
    *
    *      -- ( Setup ) --
    *          See p16 of the datasheet for Comm Reg bit definitions.
    *          See p17 of the datasheet for Setup Reg bit definitions.
    *          See p19 of the datasheet for Clock Reg bit definitions.
    *
    * The states should progress as:
    * 1)    a) Reset AD7705
    *                -- Set AD7705 reset to 0 then
    *                -- Set AD7705 reset to 1 
    *       b) Write to comms register to select channel and 
    *          set next opperation to be a write to the clock register.
    *                -- Send 00100000(32) over spi
    *       c) Write to clock register to set master clock reference, 
    *          and desired update rate(50Hz). 
    *          The board designed by TekBots uses a 4.192MHz oscillator.
    *          The slowest setting posible is 50Hz.
    *                -- Send 00001100(12) over spi
    *       d) Write to comms register to select channel and 
    *          set next opperation to be a write to the setup register.
    *                -- Send 00010000(16) over spi 
    *       d) Write to setup register to set gain, op conditions and
    *          initiate a self-calibration.
    *                -- Send 01000100(68)
    *
    *      -- ( Operational Cycle ) --
    *
    * 2)    a) Write to comms register to set up next operation as
    *          a read from the data register.
    *               -- Send 00000100(8) over spi
    *       b) If DRDY then go to request data register
    *          Else go to request comms register
    *       c) Write to comms register to set up next operation as
    *          a read from the data register.
    *               -- Send 00111000(56) over spi
    *       d) Read data byte 1
    *               -- Read spi data for 8 bits
    *       e) Read data byte 2
    *               -- Read spi data for 8 bits
    *               -- go to 2-a/start cycle again
    *
    * See p33 of the datasheet for state diagram.
    */
    always_ff @(posedge clk_2Mhz, negedge reset) begin : adc_sm
        if (~reset) begin 
            state <= CONFIGURE;
            cnt <= 30;
            transmit <= 0;
            to_send <= 32;
            prev_done <= 0;
            adc_reset <= 0;
            end
        else begin
            adc_reset <= 1;
            case(state)
                CONFIGURE : begin
                    // Reset ADC
                    if (cnt==1500) adc_reset <= 1;
                    if (cnt>4) cnt <= cnt-1;
                    else if(done && (prev_done != done)) begin
                        if(cnt==4)to_send <= 12;
                        if(cnt==3)to_send <= 16;
                        if(cnt==2)to_send <= 68;
                        cnt <= cnt-1;
                        transmit <= 0;
                        end
                    else transmit <= 1; 

                    // Transition State
                    if(cnt==0) begin
                        state <= RQST_COMM;
                        transmit <= 0;
                        to_send  <= 8;
                        end
                    end
                RQST_COMM : begin
                    transmit <= 1;
                    if (done && (prev_done != done)) begin
                        state    <= READ_COMM;
                        transmit <= 0;
                        end
                    end
                READ_COMM : begin
                    transmit <= 1;
                    if (done && (prev_done != done)) begin
                        if (data_byte[7] == 1) begin 
                            state    <= RQST_DATA;
                            to_send  <= 56; // read
                            end
                        else begin
                            state    <= RQST_COMM;
                            to_send  <= 8; // read
                            end
                        transmit <= 0;
                        end
                    end
                RQST_DATA : begin
                    transmit <= 1; 
                    if (done && prev_done!=done) begin
                        state    <= READ_DATA1;
                        transmit <= 0;
                        end
                    end
                READ_DATA1 : begin
                    transmit <= 1; 
                    if (done && prev_done!=done) begin
                        transmit  <= 0;
                        state     <= READ_DATA2;
                        raw_data[15:8] <= data_byte;
                        end
                    end
                READ_DATA2 : begin
                    transmit <= 1; 
                    if (done && prev_done!=done) begin
                        raw_data[7:0] <= data_byte;
                        transmit <= 0;
                        state    <= RQST_COMM;
                        to_send  <= 8;
                        end
                    end
                default : state <= CONFIGURE;
                endcase
            prev_done <= done;
            end
        end
    
    spi_master spi (
        // inputs
        .clk       ( clk_2Mhz ),
        .reset     ( reset    ),
        .MISO      ( MISO     ),
        .transmit  ( transmit ),
        .to_send   ( to_send  ),
        // outputs
        .MOSI      ( MOSI      ),
        .SCK       ( SCK       ),
        .received  ( data_byte ), 
        .done      ( done      ) );
    
    endmodule


/*
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









