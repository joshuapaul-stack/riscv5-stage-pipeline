module alu_control (
    input  logic [6:0] opcode,
    input  logic [2:0] funct3,
    input  logic       funct7_bit,

    output logic [3:0] alu_ctrl
);

    always_comb begin

        // Default: ADD
        alu_ctrl = 4'b0000;

        case (opcode)

            // R-type
            7'b0110011: begin
                case (funct3)

                    3'b000: begin
                        if (funct7_bit)
                            alu_ctrl = 4'b0001; // SUB
                        else
                            alu_ctrl = 4'b0000; // ADD
                    end

                    3'b111: alu_ctrl = 4'b0010; // AND
                    3'b110: alu_ctrl = 4'b0011; // OR
                    3'b100: alu_ctrl = 4'b0100; // XOR
                    3'b010: alu_ctrl = 4'b0101; // SLT
                    3'b011: alu_ctrl = 4'b0110; // SLTU
                    3'b001: alu_ctrl = 4'b0111; // SLL

                    3'b101: begin
                        if (funct7_bit)
                            alu_ctrl = 4'b1001; // SRA
                        else
                            alu_ctrl = 4'b1000; // SRL
                    end

                    default: alu_ctrl = 4'b0000;

                endcase
            end

            // I-type arithmetic
            7'b0010011: begin
                case (funct3)

                    3'b000: alu_ctrl = 4'b0000; // ADDI
                    3'b111: alu_ctrl = 4'b0010; // ANDI
                    3'b110: alu_ctrl = 4'b0011; // ORI
                    3'b100: alu_ctrl = 4'b0100; // XORI
                    3'b010: alu_ctrl = 4'b0101; // SLTI
                    3'b011: alu_ctrl = 4'b0110; // SLTIU
                    3'b001: alu_ctrl = 4'b0111; // SLLI

                    3'b101: begin
                        if (funct7_bit)
                            alu_ctrl = 4'b1001; // SRAI
                        else
                            alu_ctrl = 4'b1000; // SRLI
                    end

                    default: alu_ctrl = 4'b0000;

                endcase
            end

            // LOAD / STORE / JALR
            // Address calculation = ADD
            7'b0000011,
            7'b0100011,
            7'b1100111: begin
                alu_ctrl = 4'b0000;
            end

            // BRANCH
            // Comparison handled through subtraction
            7'b1100011: begin
                alu_ctrl = 4'b0001;
            end

            default: begin
                alu_ctrl = 4'b0000;
            end

        endcase
    end

endmodule