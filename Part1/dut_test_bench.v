`timescale 1ns /1ns

module dut_test_bench;

// All testbench code goes inside this module
wire [7:0] S1 ; 
wire Overflow1 ;
wire Data_ready ;

reg [7:0] A1 , B1 ;
reg cin;
reg Data_valid;


reg clk ;
reg rest_n ;


dut_8bit_addr my_module(.clk(clk),
			.reset_n(rest_n),
			.Data_val(Data_valid),
			.Value_a(A1),
			.Value_b(B1),
			.c_in(cin),
			.Sum_result(S1),
			.Sum_carry(Overflow1),
			.Data_ready(Data_ready)
			);


always begin 
    #5 clk = ~clk ;
end


initial begin
  $monitor ("A1=%b, B1=%b, cin=%b, Data_valid=%b, rest_n=%b, S1=%b, Overflow1=%b ,Data_ready=%b ", A1, B1, cin, Data_valid, rest_n, S1, Overflow1, Data_ready);
  rest_n = 1'b0 ; 
  clk = 1'b0 ;
  A1 = 8'b0;
  B1 = 8'b0;
  cin = 1'b0;
  Data_valid = 1'b0;
  #5 rest_n = 1'b1 ; Data_valid = 1'b1;  

  #10 A1=8'b00000011; B1=8'b00000101; cin=1'b0; rest_n = 1'b1 ; Data_valid = 1'b1;  // a=3 , b=5 , cin=0 then we will see the sum = 8 two cycles after this

  #10 A1=8'b00000011; B1=8'b00000111; cin=1'b1; rest_n = 1'b1 ; Data_valid = 1'b1;

  #10 A1=8'b00000010; B1=8'b00000011; cin=1'b0; rest_n = 1'b1 ; Data_valid = 1'b1; // a=2,b=3 , s=8 the sum of 3 and  5 two cycles befor

  #10 A1=8'b00001110; B1=8'b00010111; cin=1'b0; rest_n = 1'b1 ; Data_valid = 1'b1;

  #10 A1=8'b10000101; B1=8'b10000000; cin=1'b0; rest_n = 1'b1 ; Data_valid = 1'b1;

  #10 A1=8'b00011001; B1=8'b00110000; cin=1'b0; rest_n = 1'b1 ; Data_valid = 1'b0;  // data_val = 0 

  #10 A1=8'b00000011; B1=8'b00000010; cin=1'b1; rest_n = 1'b1 ; Data_valid = 1'b1;  // this cycle show sum = 0 becuse one sycle befor Data_valid  = 0

  #10 A1=8'b11010111; B1=8'b00000001; cin=1'b0; rest_n = 1'b1 ; Data_valid = 1'b1;

  #10 A1=8'b00000011; B1=8'b00000111; cin=1'b1; rest_n = 1'b1 ; Data_valid = 1'b1;

  #10 A1=8'b11111001; B1=8'b00000000; cin=1'b1; rest_n = 1'b0 ; Data_valid = 1'b1;  // rest_n = 0 then 3 cycles we will see 0 at all output signals

  #10 A1=8'b11111111; B1=8'b11111111; cin=1'b0; rest_n = 1'b1 ; Data_valid = 1'b1;

  #10 A1=8'b00000011; B1=8'b00000011; cin=1'b0; rest_n = 1'b1 ; Data_valid = 1'b1;

  #10 A1=8'b00000011; B1=8'b00000011; cin=1'b0; rest_n = 1'b1 ; Data_valid = 1'b1;

  #2000 $finish;
end
endmodule 
