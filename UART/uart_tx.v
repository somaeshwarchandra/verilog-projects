`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/26/2026 04:39:45 PM
// Design Name: 
// Module Name: uart_tx
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


module uart_tx(
input clk,
input rst,
input [7:0]data_in,//input parallel data
input tx_start,//indicates the start of transmission

output reg tx,//serial ouput
output reg tx_busy,//it indicates that uart is transmitting data
output reg tx_done //it indicated that transmission is done

    );
    
    parameter CLOCK_FREQ=100000000;
    parameter BAUD_RATE=9600;
    localparam CLKS_PER_BIT = CLOCK_FREQ/BAUD_RATE;

    reg [7:0]tx_data;//data may change mid transmission so we use temp reg   
    reg [1:0]state;//for knowing the state we are in
    reg [2:0]bit_count;//for counting the data bits transmission
    reg [$clog2(CLKS_PER_BIT)-1:0]baud_count;//for maintaing baud rate 0-10416 for 1 bit
        
    localparam IDLE=2'b00;//states
    localparam START=2'b01; 
    localparam DATA=2'b10;
    localparam STOP=2'b11;
    
    always @(posedge clk)
    begin
    if(rst)
    begin
    state<=IDLE;
    tx_data<=0;
    bit_count<=0;
    baud_count<=0;
    
    tx_done<=0;
    tx_busy<=0;
    tx<=1;//it sends a stream of 1's when uart is not transmitting the data 
    end
    
    
    
    else
    begin
    tx_done<=0;
    
    
    case(state)
    IDLE:
    begin
    if(!tx_start)
    begin
    tx<=1;
    //tx_done<=0;
    tx_busy<=0;
    end
    else 
    begin
    tx<=1;
    tx_busy<=1;
    tx_data<=data_in;
    tx_done<=0;
    bit_count<=0;
    baud_count<=0;
    state<=START;
    end
    end
    
    
    START:
    begin
    tx<=0;
    if (baud_count < (CLKS_PER_BIT-1) )
    begin
    baud_count<=baud_count+1;
    end
    
    
    else
    begin
    baud_count<=0;
    state<=DATA;
    end
    end
    
    
    DATA:
    begin
    tx<=tx_data[bit_count];
    if (baud_count < (CLKS_PER_BIT-1) )
    begin
    baud_count<=baud_count+1;
    end
    
    else
    begin
    baud_count<=0;
    if(bit_count<7)
    begin
    bit_count<=bit_count+1;
    end
    else
    begin
    bit_count<=0;
    state<=STOP;
    end
    end
    end
    
    STOP:
    begin
    tx<=1;
    if(baud_count < (CLKS_PER_BIT-1))
    begin
    baud_count<=baud_count+1;
    end
    else
    begin
    baud_count<=0;
    tx_busy<=0;
    tx_done<=1;
    state<=IDLE;
    end
    end
    default:
    begin
    state<=IDLE;
    end
    endcase
    end
    end
endmodule
