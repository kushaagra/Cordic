module Mux2to1(shift,x_in,y_in,x_out);
input shift,x_in,y_in;
output x_out;
reg x_out;
always@(*)
begin 
if(shift)
x_out = y_in;
else
x_out = x_in;
end
endmodule
