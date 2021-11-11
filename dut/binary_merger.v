// binary_merger.v
// Author: Andrew Feldman, 11/10/2021
//
// Parameterized binary merger component

module binary_merger 
              #(parameter MERGER_COORD_BITS = 32)
              (
              input wire clock,
              input wire reset,
              input wire [(2*MERGER_COORD_BITS-1):0] coord_in,
              output wire [(MERGER_COORD_BITS-1):0] coord,
              input wire selected,
              output wire [1:0] fetch_next
);
    
    wire comparison;
    wire [(MERGER_COORD_BITS-1):0] coord_0;
    wire [(MERGER_COORD_BITS-1):0] coord_1;

    // Breakout separate coordinates from input net
    assign coord_0 = coord_in[(MERGER_COORD_BITS-1):0];
    assign coord_1 = coord_in[(2*MERGER_COORD_BITS-1):MERGER_COORD_BITS];
    assign fetch_next = {fetch_next_from_1,fetch_next_from_0};

    // Merge
    assign comparison = (coord_0 < coord_1);
    assign coord = comparison ? coord_0 : coord_1;
    assign fetch_next_from_0 = comparison & selected;
    assign fetch_next_from_1 = (~comparison) & selected;

endmodule
