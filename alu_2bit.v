// 2-bit ALU in Verilog
// Operations (opcode):
//   3'b000 : AND
//   3'b001 : OR
//   3'b010 : ADD
//   3'b011 : SUB
//   3'b100 : XOR
//   3'b101 : NOT A
//   3'b110 : NAND
//   3'b111 : NOR

module alu_2bit (
    input  [1:0] A,
    input  [1:0] B,
    input  [2:0] opcode,
    output reg [2:0] result,
    output reg zero
);

    always @(*) begin
        case (opcode)
            3'b000: result = {1'b0, A & B};              // AND
            3'b001: result = {1'b0, A | B};              // OR
            3'b010: result = A + B;                      // ADD (3-bit, MSB = carry-out)
            3'b011: result = {A < B ? 1'b1 : 1'b0, A - B}; // SUB (MSB = borrow)
            3'b100: result = {1'b0, A ^ B};           // XOR
            3'b101: result = {1'b0, ~A};              // NOT A
            3'b110: result = {1'b0, ~(A & B)};        // NAND
            3'b111: result = {1'b0, ~(A | B)};        // NOR
            default: result = 3'b000;
        endcase
        zero = (result == 3'b000) ? 1'b1 : 1'b0;
    end

endmodule
