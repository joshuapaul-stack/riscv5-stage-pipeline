`timescale 1ns/1ps

module tb_rv32i_core;

    logic clk;
    logic rst;

    rv32i_core dut (
        .clk(clk),
        .rst(rst)
    );

    initial clk = 1'b0;
    always #5 clk = ~clk;

    initial begin
        rst = 1'b1;
        repeat (2) @(posedge clk);
        rst = 1'b0;

        repeat (20) @(posedge clk);

        $display("RV32I CORE TEST COMPLETE");
        $finish;
    end

endmodule