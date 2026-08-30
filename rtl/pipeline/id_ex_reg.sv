module id_ex_reg (
    input  logic        clk,
    input  logic        rst,
    input  logic        stall,
    input  logic        flush,

    // Data from ID stage
    input  logic [31:0] pc_in,
    input  logic [31:0] rs1_data_in,
    input  logic [31:0] rs2_data_in,
    input  logic [31:0] imm_in,

    input  logic [4:0]  rs1_addr_in,
    input  logic [4:0]  rs2_addr_in,
    input  logic [4:0]  rd_addr_in,

    input  logic [2:0]  funct3_in,
    input  logic [6:0]  funct7_in,

    // Control signals from ID stage
    input  logic        reg_write_in,
    input  logic        mem_read_in,
    input  logic        mem_write_in,
    input  logic        mem_to_reg_in,
    input  logic        alu_src_in,
    input  logic [3:0]  alu_ctrl_in,

    // Data toward EX stage
    output logic [31:0] pc_out,
    output logic [31:0] rs1_data_out,
    output logic [31:0] rs2_data_out,
    output logic [31:0] imm_out,

    output logic [4:0]  rs1_addr_out,
    output logic [4:0]  rs2_addr_out,
    output logic [4:0]  rd_addr_out,

    output logic [2:0]  funct3_out,
    output logic [6:0]  funct7_out,

    // Control signals toward EX stage
    output logic        reg_write_out,
    output logic        mem_read_out,
    output logic        mem_write_out,
    output logic        mem_to_reg_out,
    output logic        alu_src_out,
    output logic [3:0]  alu_ctrl_out
);

    always_ff @(posedge clk) begin
        if (rst || flush) begin
            pc_out        <= 32'b0;
            rs1_data_out  <= 32'b0;
            rs2_data_out  <= 32'b0;
            imm_out       <= 32'b0;

            rs1_addr_out  <= 5'b0;
            rs2_addr_out  <= 5'b0;
            rd_addr_out   <= 5'b0;

            funct3_out    <= 3'b0;
            funct7_out    <= 7'b0;

            reg_write_out <= 1'b0;
            mem_read_out  <= 1'b0;
            mem_write_out <= 1'b0;
            mem_to_reg_out <= 1'b0;
            alu_src_out   <= 1'b0;
            alu_ctrl_out  <= 4'b0;
        end
        else if (stall) begin
            // Insert a bubble into EX stage
            reg_write_out <= 1'b0;
            mem_read_out  <= 1'b0;
            mem_write_out <= 1'b0;
            mem_to_reg_out <= 1'b0;
        end
        else begin
            pc_out        <= pc_in;
            rs1_data_out  <= rs1_data_in;
            rs2_data_out  <= rs2_data_in;
            imm_out       <= imm_in;

            rs1_addr_out  <= rs1_addr_in;
            rs2_addr_out  <= rs2_addr_in;
            rd_addr_out   <= rd_addr_in;

            funct3_out    <= funct3_in;
            funct7_out    <= funct7_in;

            reg_write_out <= reg_write_in;
            mem_read_out  <= mem_read_in;
            mem_write_out <= mem_write_in;
            mem_to_reg_out <= mem_to_reg_in;
            alu_src_out   <= alu_src_in;
            alu_ctrl_out  <= alu_ctrl_in;
        end
    end

endmodule