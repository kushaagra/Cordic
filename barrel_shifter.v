module barrel_shifter(x_in,x_out,shift);
parameter no_bits = 16;
parameter stages = 4;
input [no_bits-1:0] x_in;
input [stages-1:0] shift;
output [no_bits-1:0] x_out;
wire [no_bits-1:0] temp1,temp2,temp3,temp4;
genvar index;
generate
for(index=0;index<no_bits;index= index+1)
begin: stage_maker
if(index < no_bits-1)
Mux2to1 mux(shift[0],x_in[index],x_in[index+1],temp1[index]);
else
Mux2to1 mux2(shift[0],x_in[index],x_in[index],temp1[index]);
end
endgenerate
genvar index1;
generate
for(index1=0;index1<no_bits;index1= index1+1)
begin: stage_maker1
if(index1 < no_bits-2)
Mux2to1 mux7(shift[1],temp1[index1],temp1[index1+2],temp2[index1]);
else
Mux2to1 mux8(shift[1],temp1[index1],temp1[no_bits-1],temp2[index1]);
end
endgenerate
genvar index2;
generate
for(index2=0;index2<no_bits;index2= index2+1)
begin: stage_maker2
if(index2 < no_bits-4)
Mux2to1 mux3(shift[2],temp2[index2],temp2[index2+4],temp3[index2]);
else
Mux2to1 mux4(shift[2],temp2[index2],temp2[no_bits-1],temp3[index2]);
end
endgenerate
genvar index3;
generate
for(index3=0;index3<no_bits;index3= index3+1)
begin: stage_maker3
if(index3 < no_bits-8)
Mux2to1 mux5(shift[3],temp3[index3],temp3[index3+8],temp4[index3]);
else
Mux2to1 mux6(shift[3],temp3[index3],temp3[no_bits-1],temp4[index3]);
end
endgenerate
assign x_out = temp4;
endmodule
