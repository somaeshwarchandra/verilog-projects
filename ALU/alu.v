`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/24/2026 02:00:33 AM
// Design Name: 
// Module Name: alu
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module alu(result,a,b,opcode);
input [7:0]a,b;
input [2:0]opcode;
output reg [7:0] result;
always@(*)
begin
case(opcode)
3'd0:result=a+b;//addition
3'd1:result=a-b;//subtraction
3'd2:result=a&b;//and
3'd3:result=a|b;//or
3'd4:result=a^b;//xor
3'd5:result=~a;//not
3'd6:result=a<<1;//left shift
3'd7:result=a>>1;//right shift
default: result = 8'd0;//default
endcase
end
endmodule
