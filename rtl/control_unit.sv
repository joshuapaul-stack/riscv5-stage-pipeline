module control_unit (
    input  logic [6:0] opcode,

    output logic       reg_write,
    output logic       mem_read,
    output logic       mem_write,
    output logic       mem_to_reg,
    output logic       alu_src,
    output logic       branch,
    output logic       jump,
    output logic [3:0] alu_ctrl
);

    always_comb begin

        // Safe default values
        reg_write  = 1'b0;
        mem_read   = 1'b0;
        mem_write  = 1'b0;
        mem_to_reg = 1'b0;
        alu_src    = 1'b0;
        branch     = 1'b0;
        jump       = 1'b0;
        alu_ctrl   = 4'b0000;

        case (opcode)

            // R-type instructions
            // ADD, SUB, AND, OR, XOR, etc.
            7'b0110011: begin
                reg_write = 1'b1;
                alu_src   = 1'b0;
            end

            // I-type arithmetic
            // ADDI, ANDI, ORI, XORI, etc.
            7'b0010011: begin
                reg_write = 1'b1;
                alu_src   = 1'b1;
            end

            // LOAD
            // LW
            7'b0000011: begin
                reg_write  = 1'b1;
                mem_read   = 1'b1;
                mem_to_reg = 1'b1;
                alu_src    = 1'b1;
            end

            // STORE
            // SW
            7'b0100011: begin
                mem_write = 1'b1;
                alu_src   = 1'b1;
            end

            // BRANCH
            // BEQ, BNE, etc.
            7'b1100011: begin
                branch = 1'b1;
                alu_src = 1'b0;
            end

            // JAL
            7'b1101111: begin
                reg_write = 1'b1;
                jump      = 1'b1;
            end

            // JALR
            7'b1100111: begin
                reg_write = 1'b1;
                jump      = 1'b1;
                alu_src   = 1'b1;
            end

            // Unknown / unsupported instruction
            default: begin
                // Keep all control signals at safe defaults
            end

        endcase
    end

endmodule