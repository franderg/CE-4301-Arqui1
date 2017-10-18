module sevenSeg(R,Seg);
	
	input [3:0] R;

	output reg [6:0] Seg;

	always @ (R)begin
		case (R)
			4'd0 :  Seg = 7'b1000000;
			4'd1 :  Seg = 7'b1111001;
			4'd2 :  Seg = 7'b0100100;
			4'd3 :  Seg = 7'b0110000;
			4'd4 :  Seg = 7'b0011001;
			4'd5 :  Seg = 7'b0010010;
			4'd6 :  Seg = 7'b0000010;
			4'd7 :  Seg = 7'b1111000;
			4'd8 :  Seg = 7'b0000000;
			4'd9 :  Seg = 7'b0010000;
			4'd10 :  Seg = 7'b0001000;
			4'd11 :  Seg = 7'b0000011;
			4'd12 :  Seg = 7'b1000110;
			4'd13 :  Seg = 7'b0100001;
			4'd14 :  Seg = 7'b0000110;
			4'd15 :  Seg = 7'b0001110;
			default :  Seg = 7'b1000000;
		endcase
	end
endmodule
