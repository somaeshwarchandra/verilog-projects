`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/28/2026 04:52:39 PM
// Design Name: 
// Module Name: uart_rx
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


module uart_rx#(parameter CLOCK_FREQ=100000000,parameter BAUD_RATE=9600 )(
input clk,
input rst, 
input rx,

output reg [7:0] rx_data,
output reg rx_done

    );
    localparam CLKS_PER_BIT=CLOCK_FREQ/BAUD_RATE;
    reg [1:0]state;
    reg [2:0]bit_count;
    reg [$clog2(CLKS_PER_BIT)-1:0]baud_count;
    reg [7:0]shift_reg;
    
    localparam IDLE =2'b00;
    localparam START=2'b01;
    localparam DATA=2'b10;
    localparam STOP=2'b11;
    always@(posedge clk)
    begin
        if(rst)
        begin
        rx_data<=0;
        bit_count<=0;
        baud_count<=0;
        rx_done<=0;
        shift_reg<=0;
        state<=IDLE;
        end
        
        
        else
        begin
        rx_done<=0;
        case(state)
       
            IDLE:
            begin
                if (!rx)
                begin 
                baud_count<=0;
                bit_count<=0;
                shift_reg<=0;
                state<=START;
                end
            end
            
            START:
            begin
            if (baud_count==(CLKS_PER_BIT/2))
            begin
                if(!rx)
                begin
                baud_count<=0;
                state<=DATA;
                end
                else
                begin
                baud_count<=0;
                state<=IDLE;
                end
             end
             else
                 begin
                 baud_count<=baud_count+1;
                 end
            end
            
            DATA:
            begin
                if (baud_count==(CLKS_PER_BIT-1))
                begin
                baud_count<=0;
                shift_reg<={rx,shift_reg[7:1]};
                    if(bit_count==3'd7)
                    begin
                    bit_count<=0;
                    state<=STOP;
                    end
                    else
                    begin
                    bit_count<=bit_count+1;
                    end
                end
               
                else
                begin
                baud_count<=baud_count+1;
                end
            end
            
            STOP:
            begin
                if (baud_count==(CLKS_PER_BIT-1))
                begin
                  baud_count<=0;
                  if(rx)
                  begin
                  rx_done<=1;
                  rx_data<=shift_reg;
                  end
                  state<=IDLE;
          
                end
                 else
                 begin
                 baud_count<=baud_count+1;
                 end
                    
            end  
       endcase
        end
    
    end
endmodule
