module LeftShifter_2bit(inData,outData);
  
  input [31:0]inData;
  output [31:0]outData;
  reg [31:0]outData;
  
  always@(inData)
    begin
      
      outData=inData<<2;
  
    end
    
endmodule    

