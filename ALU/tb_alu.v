`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/24/2026 02:06:40 AM
// Design Name: 
// Module Name: tb_alu
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


module tb_alu();
reg [7:0]a,b;
reg [2:0]opcode;
wire [7:0]result;
alu dut(.result(result),.a(a),.b(b),.opcode(opcode));//instance
initial begin
a = 8'd10;
b = 8'd5;//intialization
opcode=3'd0;#10;//addition
opcode=3'd1;#10;//subtraction
opcode=3'd2;#10;//and
opcode=3'd3;#10;//or
a=8'd3;b=8'd23;#1;
opcode=3'd4;#10;//xor
opcode=3'd5;#10;//not
opcode=3'd6;#10;//left shift
opcode=3'd7;#10;//right shift
$finish;

end
initial begin
$monitor("t=%0t a=%0d b=%0d opcode=%0d result=%0d",$time,a,b,opcode,result);
end
endmodule
