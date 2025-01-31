module expand_dut_test_bench;

// All testbench code goes inside this module
wire [7:0] S1 ; 
wire Overflow1 ;
wire Data_ready ;
wire [7:0] Des_rd_value ;

reg [7:0] A1 , B1 ;
reg cin;
reg clk ;
reg rest_n ;
reg Data_val ; 

reg [2:0] Des_address ;
reg [7:0] Des_value ;
reg Des_req_valid ;
reg Des_wr_rd ;


dut_8bit_addr_expand my_module(.clk(clk),
			.reset_n(rest_n),
			.Data_val(Data_val),
			.Value_a(A1),
			.Value_b(B1),
			.c_in(cin),
			.Des_address(Des_address),
			.Des_value(Des_value),
			.Des_req_valid(Des_req_valid),
			.Des_wr_rd(Des_wr_rd),
			.Sum_result(S1),
			.Sum_carry(Overflow1),
			.Data_ready(Data_ready),
			.Des_rd_value(Des_rd_value)
			);

initial begin
  $monitor ("A1=%d , B1=%d , cin=%d , Data_val=%d , rest_n=%d , Des_address=%d  , Des_value=%d , Des_req_valid=%d, Des_wr_rd=%d,   S1=%d , Overflow1=%d , Data_ready=%d , Des_rd_value=%d ", A1, B1, cin, Data_val, rest_n, Des_address, Des_value,Des_req_valid,Des_wr_rd, S1, Overflow1,Data_ready,Des_rd_value);
  rest_n = 0 ;
  clk = 1'b0 ;
  A1 = 8'b0;
  B1 = 8'b0;
  cin = 1'b0;
  Data_val = 1'b0;

  #5  A1 = 8'b00000000 ; B1 = 8'b00000000 ; cin = 0; rest_n =1 ;  Data_val =1 ; Des_address = 3'b000 ; Des_value = 8'b00000011 ; Des_req_valid = 0  ; Des_wr_rd = 1 ;

  #10 A1 = 8'b11111111 ; B1 = 8'b00000111 ; cin = 0; rest_n =1 ; Data_val = 1 ; Des_address = 3'b000  ; Des_value = 8'b00000011 ; Des_req_valid = 0 ; Des_wr_rd = 0 ;

  #10 A1 = 8'b00001000 ; B1 = 8'b00000001 ; cin = 0; rest_n =1 ; Data_val = 1 ; Des_address = 3'b001  ; Des_value = 8'b00000111 ; Des_req_valid = 0 ; Des_wr_rd = 1 ;

  #10 A1 = 8'b00111111 ; B1 = 8'b00001111 ; cin = 0; rest_n =1 ; Data_val = 1 ; Des_address = 3'b001  ; Des_value = 8'b00000010 ; Des_req_valid = 0 ; Des_wr_rd = 1 ;

  #10 A1 = 8'b00001001 ; B1 = 8'b00001011 ; cin = 0; rest_n =1 ; Data_val = 1 ; Des_address = 3'b001  ; Des_value = 8'b00001110 ; Des_req_valid = 1 ; Des_wr_rd = 1 ;  // Des_req_valid == 1 + write  ==> write 11 to offset reg (and general reg
  
  #10 A1 = 8'b11111111 ; B1 = 8'b00000101 ; cin = 0; rest_n =1 ; Data_val = 1 ; Des_address = 3'b000  ; Des_value = 8'b00000001 ; Des_req_valid = 1 ; Des_wr_rd = 1 ;  // Des_req_valid == 1 + write  ==> write 1 to control reg

  #10 A1 = 8'b00000001 ; B1 = 8'b00001111 ; cin = 0; rest_n =1 ; Data_val = 1 ; Des_address = 3'b001  ; Des_value = 8'b00001111 ; Des_req_valid = 1 ; Des_wr_rd = 1 ;  // write 15 to offset reg (and general reg)

  #10 A1 = 8'b00001111 ; B1 = 8'b00111111 ; cin = 0; rest_n =1 ; Data_val = 1 ; Des_address = 3'b001  ; Des_value = 8'b00000111 ; Des_req_valid = 1 ; Des_wr_rd = 0 ;  // Des_req_valid == 1 + read  ==> read 14 from  general reg to Des_rd_value

  #10 A1 = 8'b00010011 ; B1 = 8'b00001111 ; cin = 0; rest_n =1 ; Data_val = 1 ; Des_address = 3'b001  ; Des_value = 8'b00001110 ; Des_req_valid = 0 ; Des_wr_rd = 1 ; 

  #10 A1 = 8'b00001101 ; B1 = 8'b00011100 ; cin = 0; rest_n =1 ; Data_val = 0 ; Des_address = 3'b001  ; Des_value = 8'b00000111 ; Des_req_valid = 0 ; Des_wr_rd = 1 ;  // Data_val = 0 

  #10 A1 = 8'b00010000 ; B1 = 8'b00001100 ; cin = 0; rest_n =1 ; Data_val = 1 ; Des_address = 3'b001  ; Des_value = 8'b00001110 ; Des_req_valid = 0 ; Des_wr_rd = 1 ; 

  #10 A1 = 8'b00011101 ; B1 = 8'b00111101 ; cin = 0; rest_n =1 ; Data_val = 1 ; Des_address = 3'b001  ; Des_value = 8'b00000111 ; Des_req_valid = 0 ; Des_wr_rd = 1 ;

  #10 A1 = 8'b00000111 ; B1 = 8'b00001111 ; cin = 0; rest_n =1 ; Data_val = 1 ; Des_address = 3'b000  ; Des_value = 8'b00000011 ; Des_req_valid = 0 ; Des_wr_rd = 0 ;

  #2000 $finish;
 end
 
always begin 
    #5 clk = ~clk ;
end

endmodule
