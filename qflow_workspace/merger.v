// merger.v
// Author: Andrew Feldman, 11/10/2021
//
// Top-level merger component with registered output

`define BTS 8
`define RDX 128

module merger
              (input wire clock,
              input wire reset,
              input wire [(`BTS*`RDX-1):0] coord_in,
              output reg [(`BTS-1):0] coord,
              input wire selected,
              output reg [(`RDX-1):0]  fetch_next
);

    localparam MERGER_COORD_BITS = `BTS;
    localparam MERGER_RADIX = `RDX;

    // Will plug into the outputs of a combinational merger
    wire [(MERGER_COORD_BITS-1):0] coord_wire;
    wire [(MERGER_RADIX-1):0] fetch_next_wire;

    // Characterize the tree of binary mergers comprising this radix-R merger
    // Number of binary merger tree nodes:
    localparam BINARY_MERGER_COUNT = MERGER_RADIX - 1; 
    // Number of fetch/select signals between binary mergers
    localparam FETCH_WIRE_COUNT = BINARY_MERGER_COUNT + MERGER_RADIX; 
    // Aggregate size of nets carrying coordinates between binary merge units
    localparam COORD_WIRE_COUNT = MERGER_COORD_BITS * FETCH_WIRE_COUNT; 
    // Pointers to where the coord_in input net "hooks in" to the tree of coordinate nets
    localparam LEAF_END_IDX = FETCH_WIRE_COUNT - 1;
    localparam LEAF_START_IDX = LEAF_END_IDX - MERGER_RADIX + 1;
    
    // Flattened tree structures for fetch/select wires and coordinate nets between binary mergers
    wire [(FETCH_WIRE_COUNT-1):0] fetch_wires;
    wire [(COORD_WIRE_COUNT-1):0] coord_wires;

    // Create the tree of binary mergers based on the localparams above
    generate
        genvar node_idx;
        for (node_idx = 0; node_idx < BINARY_MERGER_COUNT; node_idx = node_idx + 1) begin
            binary_merger merger_tree_node (
                .clock(clock),
                .reset(reset),
                .coord_in(coord_wires[((node_idx*2 + 3)*MERGER_COORD_BITS - 1):((node_idx*2 + 1)*MERGER_COORD_BITS)]),
                .coord(coord_wires[((node_idx + 1)*MERGER_COORD_BITS - 1):(node_idx*MERGER_COORD_BITS)]),
                .selected(fetch_wires[node_idx]),
                .fetch_next(fetch_wires[(node_idx*2 + 2):(node_idx*2 + 1)]) 
            );
            
            //defparam merger_tree_node.MERGER_COORD_BITS = MERGER_COORD_BITS;
            
        end
    endgenerate
    
    // Hook the tree of coordinate nets up to the
    // top-level input wires
    assign coord_wires[(MERGER_COORD_BITS*FETCH_WIRE_COUNT - 1):(MERGER_COORD_BITS*LEAF_START_IDX)] = coord_in;
    assign fetch_wires[0] = selected;

    // Final layer of sequential logic -
    // hook the tree of coordinate nets & fetch/select wires
    // up to the top-level output registers
    always @(posedge clock) begin
        if (reset) begin
            coord <= 0;
            fetch_next <= 0;
        end else if (clock) begin
            coord <= coord_wires[(MERGER_COORD_BITS - 1):0];
            fetch_next <= fetch_wires[LEAF_END_IDX:LEAF_START_IDX]; 
        end
    end

endmodule

module binary_merger 
              (
              input wire clock,
              input wire reset,
              input wire [(2*`BTS-1):0] coord_in,
              output wire [(`BTS-1):0] coord,
              input wire selected,
              output wire [1:0] fetch_next
);
    
    localparam MERGER_COORD_BITS = `BTS;

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
