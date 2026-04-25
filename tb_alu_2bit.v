// Testbench for 2-bit ALU
`timescale 1ns/1ps

module tb_alu_2bit;

    reg  [1:0] A, B;
    reg  [2:0] opcode;
    wire [2:0] result;
    wire       zero;

    // Instantiate the ALU
    alu_2bit uut (
        .A(A),
        .B(B),
        .opcode(opcode),
        .result(result),
        .zero(zero)
    );

    task check;
        input [1:0] a_in, b_in;
        input [2:0] op_in;
        input [2:0] expected;
        input exp_zero;
        begin
            A = a_in; B = b_in; opcode = op_in;
            #10;
            if (result !== expected || zero !== exp_zero) begin
                $display("FAIL: A=%b B=%b opcode=%b | result=%b (exp %b) zero=%b (exp %b)",
                         a_in, b_in, op_in, result, expected, zero, exp_zero);
            end else begin
                $display("PASS: A=%b B=%b opcode=%b | result=%b zero=%b",
                         a_in, b_in, op_in, result, zero);
            end
        end
    endtask

    initial begin
        // AND
        check(2'b11, 2'b10, 3'b000, 3'b010, 1'b0);
        check(2'b01, 2'b10, 3'b000, 3'b000, 1'b1);
        // OR
        check(2'b01, 2'b10, 3'b001, 3'b011, 1'b0);
        check(2'b00, 2'b00, 3'b001, 3'b000, 1'b1);
        // ADD
        check(2'b01, 2'b01, 3'b010, 3'b010, 1'b0);
        check(2'b11, 2'b01, 3'b010, 3'b100, 1'b0); // 3+1=4, carry set
        check(2'b00, 2'b00, 3'b010, 3'b000, 1'b1);
        // SUB
        check(2'b11, 2'b01, 3'b011, 3'b010, 1'b0); // 3-1=2, no borrow
        check(2'b10, 2'b10, 3'b011, 3'b000, 1'b1); // 2-2=0, no borrow
        check(2'b01, 2'b11, 3'b011, 3'b110, 1'b0); // 1-3 underflow, borrow=1, diff=2
        // XOR
        check(2'b11, 2'b01, 3'b100, 3'b010, 1'b0);
        check(2'b11, 2'b11, 3'b100, 3'b000, 1'b1);
        // NOT A
        check(2'b10, 2'b00, 3'b101, 3'b001, 1'b0);
        check(2'b11, 2'b00, 3'b101, 3'b000, 1'b1);
        // NAND
        check(2'b11, 2'b10, 3'b110, 3'b001, 1'b0);
        check(2'b00, 2'b11, 3'b110, 3'b011, 1'b0);
        // NOR
        check(2'b00, 2'b00, 3'b111, 3'b011, 1'b0);
        check(2'b11, 2'b11, 3'b111, 3'b000, 1'b1);

        $display("Simulation complete.");
        $finish;
    end

endmodule
