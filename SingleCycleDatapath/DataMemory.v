module DataMemory(inputAddress, inputData32bit, outputData32bit, MemRead, MemWrite);

input [31:0]inputAddress;
//input READ_Bar;
input [31:0]inputData32bit;
input MemRead, MemWrite;
output [31:0]outputData32bit;

/////// THE MAIN MEMORY REGISTERS WHICH HOLD EMULATE THE ACTUAL RAM. 
        reg [7:0]MM[255:0];
///////

reg [7:0]address;
reg [7:0]dataBuff;
reg [31:0]outputData32bit;

integer addressInt, i, j, placeVal,var, baseAddress;
genvar k;

always @( inputData32bit or inputAddress or MemRead or MemWrite)
begin

  address=inputAddress[7:0];
    
  //calculating address as an integer

  addressInt = 0;  // the integer equivalent of the 8 bit address we have got in the address[]
  placeVal = 1;   // the placevalue for the unit place is 1.
  
  for( i=0 ; i<8 ; i=i+1 )
  begin
      
      if(address[i] == 1'b1)
        addressInt = addressInt + placeVal;
        
      placeVal = placeVal * 2;
  end
  
  //calculated address as an integer, stored in addressInt
  


  if(MemRead == 1)  // the memory is being read from.
  begin
    
    baseAddress = addressInt;  // i is the variable pointing to the address location pointed by the input address
        
    // now copying the 8 bits of the pointed address one by one.   
    
    ///BIG ENDIAN
    for(i=0 ; i<4 ; i=i+1)
    begin 
       for(j = 0 ; j < 8 ; j = j+1 )
        begin
           outputData32bit[j] = MM[baseAddress + i][j];           
        end 
    end    
        
    
       
  end               //End of readbar condition 1
  
   
  
  if(MemWrite == 1) // the memory is being written into
  begin
    baseAddress = addressInt;
    
    // the given data is being written into the place pointed by the address            
    
    ///BIG ENDIAN
    for(i=0 ; i<4 ; i = i + 1)
    begin
      
      for(j = 0 ; j < 8 ; j = j+1 )
         begin
             MM[baseAddress + i][j] = inputData32bit[j] ;
         end     
      
    end   
    
      
  end               // End of data writing block
  
  
    
end  // end of the always block




endmodule



