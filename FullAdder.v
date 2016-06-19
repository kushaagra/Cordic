module FullAdder(x,y,c_in,s,c);
input x,y,c_in;
output s,c;
assign s = (x^y)^c_in;
assign c = (x & y) | (c_in & (x ^ y));
endmodule
