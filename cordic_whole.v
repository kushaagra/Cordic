

module cordic_whole(z_in,x_out,y_out,z_out,clk);
parameter n_bit = 12;
input clk;
input [n_bit-1:0] z_in;
output reg [n_bit+3:0] x_out,y_out;
output reg[n_bit-1:0] z_out;
reg [n_bit-1:0] angle_store [9:0];
////storing 6 values only now;
///reg signed [n_bit-1:0] x_reg;
///reg signed [n_bit-1:0] y_reg;
reg signed [n_bit+3:0] x_reg;
reg signed [n_bit+3:0] y_reg;
reg [n_bit-1:0] z_reg;
reg [3:0] pointer;
////reg [n_bit-1:0] temp_x;
///reg [n_bit-1:0] temp_y;
reg [n_bit+3:0] temp_x;
reg [n_bit+3:0] temp_y;
wire d,d2;
wire [n_bit+3:0] shifted_x,shifted_y,x_out1,y_out1;
wire [n_bit-1:0] z_out1,angle;
barrel_shifter shifter1(x_reg,shifted_x,pointer);
barrel_shifter shifter2(y_reg,shifted_y,pointer);
//assign shifted_x = x_reg >>> pointer;
///assign shifted_y = y_reg >>> pointer;
assign d = z_reg[n_bit-1];
assign d2 = ~d;

defparam adder1.noBits = 16;
defparam adder2.noBits = 16; 
assign angle = angle_store[pointer];
RippleCarryAdder adder1(x_reg,shifted_y,d2,x_out1);
RippleCarryAdder adder2(y_reg,shifted_x,d,y_out1);
RippleCarryAdder adder3(z_reg,angle,d2,z_out1);
///subtracting adder1(x_reg,shifted_y,d,x_out1);
///addering adder2(y_reg,shifted_x,d,y_out1);

////subtracting adder3(z_reg,angle,d,z_out1);
initial 
begin
z_reg = z_in;
pointer = 0;
temp_x = 16'b0010011011011110;
temp_y = 16'b0000000000000000;
angle_store[0] = 12'b001100100100;
angle_store[1] =12'b000111011010;

angle_store [2] = 12'b000011111010;
angle_store [3] = 12'b000001111111;
angle_store [4] = 12'b000000111111;
angle_store [5] = 12'b000000011111;
angle_store [6] = 12'b000000001111;
angle_store [7] = 12'b000000000111;
angle_store [8] = 12'b000000000011;
angle_store [9] = 12'b000000000001;
end

always@ (posedge clk)
begin
if(pointer ==9 )
begin
x_reg <= temp_x;
y_reg <= temp_y;
pointer <=0;
z_reg <= z_in;
x_out <= x_out1;
y_out <=y_out1;
z_out<= z_out1; 
end
else
begin
x_reg <= x_out1;
y_reg <= y_out1;
z_reg <= z_out1;
//$display("z_out is here %d %d %d",z_out1,x_out1,y_out1);
///y<= z_out;
///x_out <=y_out1;
pointer <= pointer+1;
end
end
endmodule
