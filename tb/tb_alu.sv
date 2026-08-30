`timescale 1ns/1ps

module tb_alu;

    logic [31:0] a;
    logic [31:0] b;
    logic [3:0]  alu_ctrl;
    logic [31:0] result;
    logic        zero;

    alu dut (
        .a(a),
        .b(b),
        .alu_ctrl(alu_ctrl),
        .result(result),
        .zero(zero)
    );

    task check;
        input [31:0] expected;
        begin
            #1;
            if (result !== expected) begin
                $display("FAIL: ctrl=%b a=%h b=%h result=%h expected=%h",
                         alu_ctrl, a, b, result, expected);
                $finish;
            end

            if (expected == 32'b0) begin
                if (zero !== 1'b1) begin
                    $display("FAIL: ZERO flag should be 1");
                    $finish;
                end
            end
            else begin
                if (zero !== 1'b0) begin
                    $display("FAIL: ZERO flag should be 0");
                    $finish;
                end
            end

            $display("PASS: ctrl=%b result=%h zero=%b",
                     alu_ctrl, result, zero);
        end
    endtask

    initial begin

        // ADD
        a = 32'd10;
        b = 32'd5;
        alu_ctrl = 4'b0000;
        check(32'd15);

        // SUB
        a = 32'd10;
        b = 32'd5;
        alu_ctrl = 4'b0001;
        check(32'd5);

        // AND
        a = 32'hF0F0F0F0;
        b = 32'h0FF00FF0;
        alu_ctrl = 4'b0010;
        check(32'h00F000F0);

        // OR
        a = 32'hF0000000;
        b = 32'h0000000F;
        alu_ctrl = 4'b0011;
        check(32'hF000000F);

        // XOR
        a = 32'hAAAAAAAA;
        b = 32'hFFFFFFFF;
        alu_ctrl = 4'b0100;
        check(32'h55555555);

        // SLT
        a = 32'd5;
        b = 32'd10;
        alu_ctrl = 4'b0101;
        check(32'd1);

        // SLL
        a = 32'h00000001;
        b = 32'd4;
        alu_ctrl = 4'b0110;
        check(32'h00000010);

        // SRL
        a = 32'h00000010;
        b = 32'd2;
        alu_ctrl = 4'b0111;
        check(32'h00000004);

        // SRA
        a = 32'h80000010;
        b = 32'd2;
        alu_ctrl = 4'b1000;
        check(32'hE0000004);

        // ZERO result test
        a = 32'd5;
        b = 32'd5;
        alu_ctrl = 4'b0001;
        check(32'd0);

        $display("");
        $display("================================");
        $display("       ALU TESTS PASSED");
        $display("================================");

        $finish;
    end

endmodule