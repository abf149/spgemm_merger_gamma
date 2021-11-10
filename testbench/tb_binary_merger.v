// tb_binary_merger.v
// Author: Andrew Feldman 11/10/2021
//
// Testbench for binary merger component

`timescale 1ns/1ps
`include "merger_defines.v"

module tb_binary_merger;

    // Track wire inputs and register outputs from merger
    reg clk;
    reg rst;
    reg [(`COORD_BITS-1):0] c0;
    reg [(`COORD_BITS-1):0] c1;
    wire [(`COORD_BITS-1):0] c;
    reg sel;
    wire f0;
    wire f1;

    // Instantiate merger, parameterized as binary radix
    merger dut (
        .clock(clk),
        .reset(rst),
        .coord_in({c1,c0}),
        .coord(c),
        .selected(sel),
        .fetch_next({f1,f0})        
    );    

    defparam dut.MERGER_RADIX = 2;
    defparam dut.MERGER_COORD_BITS = `COORD_BITS;

    // Clock
    always begin
        #5;
        clk = !clk;
    end

    initial begin
        $dumpfile("binary_merger.vcd");
        $dumpvars(0,tb_binary_merger);
        
        // Initial condition
        clk=0;
        rst=0;
        sel=1;

        // Test: second coordinate is least
        c0=8'd3;
        c1=8'd2;
        #100

        // Test: deselect while second coordinate is least
        sel=0;
        #100

        // Test: first coordinate is least 
        sel=1;
        c0=8'd2;
        c1=8'd3;
        #100

        // Test: deselect while first coordinate is least
        sel=0;
        #100

        $dumpoff;
        $finish;
    end

endmodule
