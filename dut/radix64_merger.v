// radix64_merger.v
// Author: Andrew Feldman, 11/10/2021
//
// Radix64 merger component built from 5 interconnected quaternary mergers
//

module radix64_merger(input wire clock,
              input wire reset,
              input wire [63:0] coord_0,
              input wire [63:0] coord_1,
              input wire [63:0] coord_2,
              input wire [63:0] coord_3,
              input wire [63:0] coord_4,
              input wire [63:0] coord_5,
              input wire [63:0] coord_6,
              input wire [63:0] coord_7,
              input wire [63:0] coord_8,
              input wire [63:0] coord_9,
              input wire [63:0] coord_10,
              input wire [63:0] coord_11,
              input wire [63:0] coord_12,
              input wire [63:0] coord_13,
              input wire [63:0] coord_14,
              input wire [63:0] coord_15,
              input wire [63:0] coord_16,
              input wire [63:0] coord_17,
              input wire [63:0] coord_18,
              input wire [63:0] coord_19,
              input wire [63:0] coord_20,
              input wire [63:0] coord_21,
              input wire [63:0] coord_22,
              input wire [63:0] coord_23,
              input wire [63:0] coord_24,
              input wire [63:0] coord_25,
              input wire [63:0] coord_26,
              input wire [63:0] coord_27,
              input wire [63:0] coord_28,
              input wire [63:0] coord_29,
              input wire [63:0] coord_30,
              input wire [63:0] coord_31,
              input wire [63:0] coord_32,
              input wire [63:0] coord_33,
              input wire [63:0] coord_34,
              input wire [63:0] coord_35,
              input wire [63:0] coord_36,
              input wire [63:0] coord_37,
              input wire [63:0] coord_38,
              input wire [63:0] coord_39,
              input wire [63:0] coord_40,
              input wire [63:0] coord_41,
              input wire [63:0] coord_42,
              input wire [63:0] coord_43,
              input wire [63:0] coord_44,
              input wire [63:0] coord_45,
              input wire [63:0] coord_46,
              input wire [63:0] coord_47,
              input wire [63:0] coord_48,
              input wire [63:0] coord_49,
              input wire [63:0] coord_50,
              input wire [63:0] coord_51,
              input wire [63:0] coord_52,
              input wire [63:0] coord_53,
              input wire [63:0] coord_54,
              input wire [63:0] coord_55,
              input wire [63:0] coord_56,
              input wire [63:0] coord_57,
              input wire [63:0] coord_58,
              input wire [63:0] coord_59,
              input wire [63:0] coord_60,
              input wire [63:0] coord_61,
              input wire [63:0] coord_62,
              input wire [63:0] coord_63,                                          
              output wire [63:0] coord,
              input wire selected,
              output wire [63:0] fetch_next
);

    wire [255:0] l0_out;
    wire [3:0] l1_fetch_next;  
    
    // First layer of 16 quaternary mergers
    quaternary_merger l0_m0 (
        .clock(clock),
        .reset(reset),
        .coord_0(coord_0),
        .coord_1(coord_1),
        .coord(l0_out[63:0]),
        .selected(l1_fetch_next[0]),
        .fetch_next_from_0(fetch_next[0]),
        .fetch_next_from_1(fetch_next[1])
    );    

endmodule
