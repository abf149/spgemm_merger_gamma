// tb_binary_merger.v
// Author: Andrew Feldman 11/9/2021
//
// Testbench for quaternary merger component

`timescale 1ns/1ps

module tb_quaternary_merger;

    reg clk;
    reg rst;
    reg [63:0] c0;
    reg [63:0] c1;
    reg [63:0] c2;
    reg [63:0] c3;
    wire [63:0] c;
    reg sel;
    wire [3:0] fn;

    quaternary_merger dut (
        .clock(clk),
        .reset(rst),
        .coord_0(c0),
        .coord_1(c1),
        .coord_2(c2),
        .coord_3(c3),
        .coord(c),
        .selected(sel),
        .fetch_next(fn[3:0])
    );    

    always begin
        #5;
        clk = !clk;
    end

    initial begin
        $dumpfile("quaternary_merger.vcd");
        $dumpvars(0,tb_quaternary_merger);
        clk=0;
        rst=0;
        sel=1;
        c0=64'd3;
        c1=64'd2;
        c2=64'd4;
        c3=64'd1;
        #100
        sel=0;
        #100
        sel=1;
        c0=64'd3;
        c1=64'd2;
        c2=64'd1;
        c3=64'd5;
        #100
        sel=0;
        #100
        sel=1;
        c0=64'd2;
        c1=64'd1;
        c2=64'd3;
        c3=64'd5;
        #100
        sel=0;
        #100
        sel=1;
        c0=64'd1;
        c1=64'd3;
        c2=64'd3;
        c3=64'd5;
        #100
        sel=0;
        #100
        $dumpoff;
        $finish;
    end

endmodule
