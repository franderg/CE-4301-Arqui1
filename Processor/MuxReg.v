`timescale 1ns / 1ps

module MuxReg(Output, Input0, Input1, Input2, Selector);
    output reg [4:0] Output;
    input [4:0] Input0, Input1, Input2;
    input [1:0] Selector;
    
    initial begin
        Output=5'd0;
    end 
    
	 
    always @ (Input0 or Input1 or Input2 or Selector) begin
        case (Selector)
            0: Output = Input0;
            1: Output = Input1;
            2: Output = Input2;
            default: Output = 3'd0;
        endcase
    end
endmodule