`ifndef TRANSACTION_V
`define TRANSACTION_V

class transaction;

    rand logic [7:0] A;
    rand logic [7:0] B;
    rand logic [3:0] ALU_Sel;

    logic [7:0] ALU_Out;
    logic       CarryOut;

    logic [7:0] exp_ALU_Out;
    logic       exp_CarryOut;

    function void calculate();

        exp_ALU_Out  = 8'b0;
        exp_CarryOut = 1'b0;

        case (ALU_Sel)

            4'b0000: {exp_CarryOut, exp_ALU_Out} = A + B;
            4'b0001: {exp_CarryOut, exp_ALU_Out} = A - B;
            4'b0010: {exp_CarryOut, exp_ALU_Out} = A + 1;
            4'b0011: {exp_CarryOut, exp_ALU_Out} = A - 1;

            4'b0100: exp_ALU_Out = A & B;
            4'b0101: exp_ALU_Out = A | B;
            4'b0110: exp_ALU_Out = A ^ B;
            4'b0111: exp_ALU_Out = ~A;

            4'b1000: exp_ALU_Out = A << 1;
            4'b1001: exp_ALU_Out = A >> 1;

            4'b1010: exp_ALU_Out = {A[6:0], A[7]};
            4'b1011: exp_ALU_Out = {A[0], A[7:1]};

            4'b1100: exp_ALU_Out = (A == B) ? 8'b1 : 8'b0;
            4'b1101: exp_ALU_Out = (A > B)  ? 8'b1 : 8'b0;
            4'b1110: exp_ALU_Out = (A < B)  ? 8'b1 : 8'b0;

            4'b1111: exp_ALU_Out = 8'b0;

            default: begin
                exp_ALU_Out  = 8'b0;
                exp_CarryOut = 1'b0;
            end

        endcase

    endfunction

endclass

`endif
