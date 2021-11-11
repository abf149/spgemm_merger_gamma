// tb_parameterized_merger.v
// Author: Andrew Feldman 11/10/2021
//
// Testbench for parameterized merger component

`timescale 1ns/1ps
`include "merger_defines.v"

module tb_parameterized_merger;

    // Track wire inputs and register outputs from merger
    reg clk;
    reg rst;
    wire [(`RADIX*`COORD_BITS-1):0] c_in;
    wire [(`COORD_BITS-1):0] c;
    reg sel;
    wire f0;
    wire f1;
    wire f2;
    wire f3;    

    // Instantiate merger, parameterized by radix & coordinate bits
    merger dut (
        .clock(clk),
        .reset(rst),
        .coord_in(c_in),
        .coord(c),
        .selected(sel),
        .fetch_next({f3,f2,f1,f0})   
    );    

    defparam dut.MERGER_RADIX = `RADIX;
    defparam dut.MERGER_COORD_BITS = `COORD_BITS;

    // Clock
    always begin
        #5;
        clk = !clk;
    end

    initial begin
        $dumpfile("merger.vcd");
        $dumpvars(0,tb_parameterized_merger);       
        // Initial condition
        clk=0;
        rst=1;
        sel=1;
        #100

        // Test: second coordinate is least
        rst=0;
        c0=8'd3;
        c1=8'd2;
        c2=8'd4;
        c3=8'd5;                        
        #100

        // Test: deselect while second coordinate is least
        sel=0;
        #100

        // Test: first coordinate is least 
        sel=1;
        c0=8'd2;
        c1=8'd3;
        c2=8'd4;
        c3=8'd5;                                
        #100

        // Test: deselect while first coordinate is least
        sel=0;
        #100

        // Test: third coordinate is least 
        sel=1;
        c0=8'd4;
        c1=8'd3;
        c2=8'd2;
        c3=8'd5;                                
        #100

        // Test: deselect while first coordinate is least
        sel=0;
        #100

        // Test: fourth coordinate is least 
        sel=1;
        c0=8'd4;
        c1=8'd3;
        c2=8'd5;
        c3=8'd2;                                
        #100

        // Test: deselect while first coordinate is least
        sel=0;
        #100


        $dumpoff;
        $finish;
    end

endmodule
