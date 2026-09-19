module regfile (
    input  logic        clk,
    input  logic        rst,

    input  logic [4:0]  rs1,
    input  logic [4:0]  rs2,
    input  logic [4:0]  rd,

    input  logic [31:0] write_data,
    input  logic        reg_write,

    output logic [31:0] rs1_data,
    output logic [31:0] rs2_data
);

    logic [31:0] regs [0:31];

    integer i;

    always_ff @(posedge clk) begin
        if (rst) begin
            for (i = 0; i < 32; i = i + 1)
                regs[i] <= 32'b0;
        end
        else if (reg_write && (rd != 5'd0)) begin
            regs[rd] <= write_data;
        end
    end

    assign rs1_data = (rs1 == 5'd0) ? 32'b0 : regs[rs1];
    assign rs2_data = (rs2 == 5'd0) ? 32'b0 : regs[rs2];

endmodule