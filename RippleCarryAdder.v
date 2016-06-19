
module RippleCarryAdder(x_in,y_in,d,z_out);
// synopsys template
parameter noBits = 12;
input [(noBits-1):0] x_in;
input [(noBits-1):0] y_in;
input d;
output [(noBits-1):0] z_out;
wire [(noBits-1):0] interCarry;
wire [(noBits-1):0] ymod_n;
genvar i;
generate
for(i=0;i< noBits;i=i+1)
	begin: gen_code_label2
	 assign ymod_n[i] = y_in[i]^d;
	 end
endgenerate
FullAdder ripple0(x_in[0],ymod_n[0],d,z_out[0],interCarry[0]);
genvar index;
generate
for(index = 1;index < noBits;index = index+1)
 begin: gen_code_label
   FullAdder ripple1(x_in[index],ymod_n[index],interCarry[index-1],z_out[index],interCarry[index]);
	end
endgenerate
endmodule
