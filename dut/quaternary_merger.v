// quaternary_merger.v
// Author: Andrew Feldman, 11/10/2021
//
// quaternary merger component built from three interconnected binary mergers
//
//

module quaternary_merger(input wire clock,
              input wire reset,
              input wire [63:0] coord_0,
              input wire [63:0] coord_1,
              input wire [63:0] coord_2,
              input wire [63:0] coord_3,
              output wire [63:0] coord,
              input wire selected,
              output wire [3:0] fetch_next
);

    wire [127:0] l0_out;
    wire [1:0] l1_fetch_next;  
  
    binary_merger l0_m0 (
        .clock(clock),
        .reset(reset),
        .coord_0(coord_0),
        .coord_1(coord_1),
        .coord(l0_out[63:0]),
        .selected(l1_fetch_next[0]),
        .fetch_next_from_0(fetch_next[0]),
        .fetch_next_from_1(fetch_next[1])
    );    

    binary_merger l0_m1 (
        .clock(clock),
        .reset(reset),
        .coord_0(coord_2),
        .coord_1(coord_3),
        .coord(l0_out[127:64]),
        .selected(l1_fetch_next[1]),
        .fetch_next_from_0(fetch_next[2]), 
        .fetch_next_from_1(fetch_next[3])
    );

    binary_merger l1_m0 (
        .clock(clock),
        .reset(reset),
        .coord_0(l0_out[63:0]),
        .coord_1(l0_out[127:64]),
        .coord(coord),
        .selected(selected),
        .fetch_next_from_0(l1_fetch_next[0]),
        .fetch_next_from_1(l1_fetch_next[1])
    );

endmodule
