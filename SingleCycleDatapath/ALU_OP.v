module ALU_Core(ALUSrc1 , ALUSrc2 , ALUCtrl , ALUResult , Zero);
  input[31:0] ALUSrc1;
  input[31:0] ALUSrc2;
  input[2:0] ALUCtrl;
  
  output Zero;
  reg Zero;
    
  output [31:0]ALUResult;
  reg [31:0]ALUResult;
  
  
  always @(ALUSrc1 or ALUSrc2 or ALUCtrl)
    begin
          
          if(ALUCtrl == 3'b010) //'add'
          begin
               ALUResult = ALUSrc1 + ALUSrc2; 
               if(ALUResult == 32'h0000)
               begin
                      Zero = 1'b1;
               end 
               else
                 begin
                      Zero = 1'b0;
                 end
          end
          
          if(ALUCtrl == 3'b110) // 'sub'
          begin
               ALUResult = ALUSrc1 - ALUSrc2; 
               if(ALUResult == 32'h0000)
               begin
                      Zero = 1'b1;
               end 
               else
                 begin
                      Zero = 1'b0;
                 end
          end
          
          if(ALUCtrl == 3'b000) // 'and'
          begin
               ALUResult = ALUSrc1 & ALUSrc2; 
               if(ALUResult == 32'h0000)
               begin
                      Zero = 1'b1;
               end 
               else
                 begin
                      Zero = 1'b0;
                 end
          end
               
          if(ALUCtrl == 3'b001) // 'or'
          begin
               ALUResult = ALUSrc1 | ALUSrc2; 
               if(ALUResult == 32'h0000)
               begin
                      Zero = 1'b1;
               end 
               else
                 begin
                      Zero = 1'b0;
                 end
          end     
          
          if(ALUCtrl == 3'b111) // 'slt'
          begin
               ALUResult = ALUSrc1 - ALUSrc2; 
               if(ALUResult == 32'h0000)
               begin
                      Zero = 1'b1;
               end 
               else
                 begin
                      Zero = 1'b0;
                 end
          end
        
    end
  
endmodule



module ALU_Control(FunctField, ALUOp, ALUCtrl);
input [5:0]FunctField;
input [1:0]ALUOp;
output [2:0]ALUCtrl;
reg [2:0]ALUCtrl;

always@(FunctField or ALUOp)
begin
    if(ALUOp == 2'b10)      //'Arithmetic' Type Instructions
    begin
      case(FunctField)        
      //begin
        6'b100000: ALUCtrl = 3'b010;    //ADDITION in 'R' Type
        6'b100010: ALUCtrl = 3'b110;    //SUBTRACTION in 'R' Type
        6'b100100: ALUCtrl = 3'b000;    //AND in 'R' Type
        6'b100101: ALUCtrl = 3'b001;    //OR in 'R' Type
        6'b101010: ALUCtrl = 3'b111;    //SLT in 'R' Type
     // end
    endcase
    end
    
    if(ALUOp == 2'b00)     // 'LW/SW' Type Instructions
    begin
        ALUCtrl = 3'b010;               //ADDITION irrespective of the FunctField.
    end
    
    if(ALUOp == 2'b01)    //   'BEQ', 'BNE' Type Instructions
    begin
        ALUCtrl = 3'b110;               //SUBTRACTION irrespective of the FunctField.
    end        
    

    
end   //always block 

endmodule  //ALUOp module

