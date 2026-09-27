module alu_8bit(
    input  [7:0] A,
    input  [7:0] B,
    input  [3:0] ALU_Sel,
    output reg [7:0] ALU_Out,
    output reg CarryOut
);

always @(*) begin
    // Default values
    ALU_Out  = 8'b00000000;
    CarryOut = 1'b0;

    case (ALU_Sel)

        // Arithmetic Operations
        4'b0000:                   // Addition
            {CarryOut, ALU_Out} = A + B;
        

        4'b0001:                     // Subtraction
            {CarryOut, ALU_Out} = A - B;
        

        4'b0010:                    // Increment A
            {CarryOut, ALU_Out} = A + 1;
        

        4'b0011:                      // Decrement A
            {CarryOut, ALU_Out} = A - 1;
        

        // Logical Operations
        4'b0100:                      // AND
            ALU_Out = A & B;
        

        4'b0101:                    // OR
            ALU_Out = A | B;
        

        4'b0110:                      // XOR
            ALU_Out = A ^ B;
        

        4'b0111:                      // NOT A
            ALU_Out = ~A;
        

        // Shift Operations
        4'b1000:                      // Logical Left Shift
            ALU_Out = A << 1;
        

        4'b1001:                     // Logical Right Shift
            ALU_Out = A >> 1;
        

        // Rotate Operations
        4'b1010:                      // Rotate Left
            ALU_Out = {A[6:0], A[7]};
        

        4'b1011:                     // Rotate Right
            ALU_Out = {A[0], A[7:1]};
        

        // Comparison Operations
        4'b1100:                      // Equal
            ALU_Out = (A == B) ? 8'b00000001 : 8'b00000000;
        

        4'b1101:                      // Greater Than
            ALU_Out = (A > B) ? 8'b00000001 : 8'b00000000;
        

        4'b1110:                   // Less Than
            ALU_Out = (A < B) ? 8'b00000001 : 8'b00000000;
        

        4'b1111:                      // Clear Output
            ALU_Out = 8'b00000000;
        

        default: begin
    ALU_Out  = 8'b00000000;
    CarryOut = 1'b0;
	end        

    endcase
end

endmodule
