module mod_bit_reverse( in, out );
parameter NUM_BITS = 24;
input wire [NUM_BITS-1:0]in;
output wire [NUM_BITS-1:0]out;
genvar i;
generate
  for(i=0; i<NUM_BITS; i=i+1) 
  begin : block_rev
    assign out[NUM_BITS-1-i] = in[i];
  end
endgenerate
endmodule