module rv32i_core (
    input  logic        clk,
    input  logic        rst,
    output logic [31:0] pc
);

    always_ff @(posedge clk) begin
        if (rst)
            pc <= 32'h0000_0000;
        else
            pc <= pc + 32'd4;
    end

endmodule