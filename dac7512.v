module dac7512(
clk,
rst_n,
sclk,
sync,
din,
//data
);

input clk; //时钟输入 50MHz
input rst_n; //复位信号
//input [11:0] data;//ADC输出数据
reg [11:0] data = 12'd1638;//ADC输出数据 
output reg sclk;//DAC时钟
output reg sync;//同步使能信号
output reg din;//数据信号

reg [4:0] count;//数据位累加器 5位  0~31
reg [2:0] clk_count;//时钟计数
reg [1:0] state;//发送数据状态机
reg [11:0] data_reg;//ADC输出数据寄存器
parameter ST_Start = 0;
parameter ST_Data  = 1;
parameter ST_Stop  = 2;

//分频器
reg div_clk;
reg [7:0] div_count;//分频计数器
parameter TimeDivSet = 8'd50;//分频计数设置
always @(posedge clk or negedge rst_n)
begin
	if(!rst_n)
	begin
		div_count <= 0;
		div_clk   <= 0;
	end
	else
	begin
		div_count <= div_count + 1;
		if(div_count >= (TimeDivSet))
		begin
			div_count <= 0;
			div_clk <= ~div_clk;
		end
	end
end

always @(posedge div_clk or negedge rst_n)
begin
	if(!rst_n)
	begin
		count <= 0;
		clk_count <= 0;
		sclk  <= 0;
		sync  <= 0;
		din   <= 0;
		state <= ST_Start;
		data_reg <= 0;
	end
	else
	begin
		case(state)
		ST_Start:
		begin
			clk_count <= clk_count +1;
			case(clk_count)
			3'd0:	begin
					sclk  <= 1;
					sync  <= 1;
					end
			3'd1:	begin
					sclk  <= 0;
					sync  <= 0;
					data_reg <= data;
					end
			3'd2:	begin
					state <= ST_Data;
					clk_count <= 0;
					end
			endcase
		end
		ST_Data:
		begin
			case(clk_count)
			3'd0:	begin
						sclk  <= 1;
						case(count)
						5'd0: din <= 1;
						5'd1: din <= 1;
						5'd2: din <= 0;
						5'd3: din <= 0;
						5'd4: din <= data_reg[11];
						5'd5: din <= data_reg[10];
						5'd6: din <= data_reg[9];
						5'd7: din <= data_reg[8];
						5'd8: din <= data_reg[7];
						5'd9: din <= data_reg[6];
						5'd10: din <= data_reg[5];
						5'd11: din <= data_reg[4];
						5'd12: din <= data_reg[3];
						5'd13: din <= data_reg[2];
						5'd14: din <= data_reg[1];
						5'd15: din <= data_reg[0];
						default:din <= 0;
						endcase
						clk_count <= 1;
						count <= count +1;
					end
			3'd1:	begin
						sclk  <= 0;
						clk_count <= 0;
						if(count > 5'd15)
						begin
							state <= ST_Stop;
						end
					end
			endcase
			
		end
		ST_Stop:
		begin
			case(clk_count)
			3'd0:	begin
					sclk  <= 0;
					sync  <= 1;
					clk_count <= 1;
					end
			3'd1:	begin
					sclk  <= 1;
					end
			endcase
		end
		endcase
	end
end







endmodule


