// Spring, 2016, OregonState ECE 271 Worksheet

// What is the difference between Wire and Reg?
wire thing1; //
reg  thing2; //

// What values can a bit be?
wire bit thing; //

// What values can logic be?
wire logic thing; //

// What is X, and Z respectively?
//

// How does Wire and Reg relate to bit and logic?
//

// What do I reccomend?
logic thing;

// A number is generally composed of which of the above types?
// 

// What is the below statement creating?
logic unsigned [3:0] thing; //

// Bonus... what is the difference between the above and
logic [3:0] unsigned thing; //

// What should you use?
//

// What is this statement doing?
logic [3:0][7:0] unsigned thing; //

// What is happening here? And why does it not require Begin and End?
always_ff @(posedge clk, negedge reset)
    if (~reset) thing <= 1;
    else thing <= {thing[2:0], thing[3]};

// What does this block do?
module ledPrj( input        clk, reset,
               output [3:0] leds);

    enum {s1, s2, s3, s4} state;

    always_comb    
        case (~state)
            s1 : leds <= 4'b0001; // what does 4'b do?
            s2 : leds <= 4'b0010;
            s3 : leds <= 4'b0100;
            s4 : leds <= 4'b1000;
            default : leds[3:0] <= 4'b0000;
            endcase

... more stuff here ...

endmodule

// How does one divide in an FPGA?
//

// Should this be done with an always_comb or always_ff?
//

// How does one parse?
//

// What is this block doing?
module someModule( input        clk, reset 
                   output [1:0] state );

    logic [1:0] state, next_state;

    always_ff @(posedge clk, negedge reset) 
        if (~reset) state <= 00;
        else        state <= next_state;

    always_comb
        case(state)
            0: next_state = 2'b01;
            1: next_state = 2'b10;
            2: next_state = 2'b11;
            default: next_state = 00; // what happens if this is omitted?
            endcase

    endmodule

// How does one use someModule in another block?
module someUpperModule( some signals );
    
    ... random someUpperModuleStuff ...
    
    someModule someModule_inst(
        .clk  ( clk_sig ),
        .reset( reset_sig ),
        .state( state_sig ) );

    ... random someUpperModuleStuff ...

    endmodule

// What would this symbol indicate?
//
        7
    ----/----    

// Can you edit outside of lattice? //

// Should you? //

// What is the best editor ever period hands down no questions asked don't
// argue (especially you emacs people)? 
// 

// Should you copy and paste code snippets?
//
