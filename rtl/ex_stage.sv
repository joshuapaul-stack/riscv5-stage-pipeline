module ex_stage (
    input  logic [31:0] rs1_data,
    input  logic [31:0] rs2_data,
    input  logic [31:0] imm,
    input  logic        alu_src,
    input  logic [3:0]  alu_ctrl,

    output logic [31:0] alu_result,
    output logic        zero
);

    logic [31:0] alu_b;

    // Select ALU operand B
    assign alu_b = alu_src ? imm : rs2_data;

    // Existing ALU
    alu alu_unit (
        .a(rs1_data),
        .b(alu_b),
        .alu_ctrl(alu_ctrl),
        .result(alu_result),
        .zero(zero)
    );

endmodule