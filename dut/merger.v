// merger.v
// Author: Andrew Feldman, 11/10/2021
//
// Top-level merger component with registered output

module merger
              #(parameter MERGER_COORD_BITS = 32,
                parameter MERGER_RADIX = 2  
              )
              (input wire clock,
              input wire reset,
              input wire [(MERGER_RADIX*MERGER_COORD_BITS-1):0] coord_in,
              output reg [(MERGER_COORD_BITS-1):0] coord,
              input selected,
              output reg [(MERGER_RADIX-1):0]  fetch_next
);

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
        for (node_idx = 0; node_idx < BINARY_MERGER_COUNT; node_idx = node_idx + 1) begin
            binary_merger merger_tree_node (
                .clock(clock),
                .reset(reset),
                .coord_in(coord_wires[((node_idx*2 + 2)*MERGER_COORD_BITS - 1):((node_idx*2 + 1)*MERGER_COORD_BITS)]),
                .coord(coord_wires[((node_idx + 1)*MERGER_COORD_BITS - 1):(node_idx*MERGER_COORD_BITS)]),
                .selected(fetch_wires[node_idx]),
                .fetch_next(fetch_wires[(node_idx*2 + 2):(node_idx*2 + 1)])
            );
            
            defparam merger_tree_node.MERGER_COORD_BITS = MERGER_COORD_BITS;
        end
    endgenerate
    
    // Hook the tree of coordinate nets up to the
    // top-level input wires
    assign coord_wires[(MERGER_COORD_BITS*FETCH_WIRE_COUNT - 1):(MERGER_COORD_BITS*LEAF_START_IDX)] = coord_in;
    assign fetch_wires[0] = select;

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
