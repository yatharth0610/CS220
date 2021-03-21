module processor(clk, input_valid, op, read1, read2, write, write_data, read_data_1, read_data_2, arith_out, done);

    // Inputs
    input clk;
    input input_valid;
    input [2:0] op;
    input [4:0] read1;
    input [4:0] read2;
    input [4:0] write;
    input [15:0] write_data;

    // Outputs
    output reg [15:0] read_data_1;
    output reg [15:0] read_data_2;
    output reg[15:0] arith_out;
    output reg done = 0;

    // Variables for module
    reg [4:0] read_reg1;
    reg [4:0] read_reg2;
    reg [4:0] write_reg;
    reg [15:0] data;
    reg [2:0] valid_bits;
    wire [15:0] out1;
    wire [15:0] out2;
    wire output_valid;
    reg [4:0] count = 0;
    reg [15:0] math_temp;

    // Instantiation of reg_file module
    reg_file mem(clk, read_reg1, read_reg2, write_reg, data, valid_bits, out1, out2, output_valid);

    always @(negedge clk) begin
        $display("output_valid: %b", output_valid);
        if (output_valid == 1) begin
            // done = 1;
            if (op == 3'b000) begin
                valid_bits = 3'b000;
                done = 1;
            end
            else if (op == 3'b001) begin
                valid_bits = 3'b000;
                read_data_1 = out1;
                done = 1;
            end 
            else if (op == 3'b010) begin
                read_data_1 = out1;
                read_data_2 = out2;
                done = 1;
            end 
            else if (op == 3'b011) begin
                valid_bits = 3'b000;
                read_data_1 = out1;
                done = 1;
            end 
            else if (op == 3'b100) begin
                valid_bits = 3'b000;
                read_data_1 = out1;
                read_data_2 = out2;
                done = 1;
            end  
            else if (op == 3'b101) begin
                read_data_1 = out1;
                read_data_2 = out2;
                if (count < 19) begin
                    count = count + 1;
                end
                else begin
                    arith_out = math_temp;
                    count = 0;
                    done = 1;
                end
                if (count == 17) begin
                    math_temp = read_data_1 + read_data_2;
                end
            end
            else if (op == 3'b110) begin
                read_data_1 = out1;
                read_data_2 = out2;
                if (count < 19) begin
                    count = count + 1;
                end
                else begin
                    arith_out = math_temp;
                    count = 0;
                    done = 1;
                end
                if (count == 17) begin
                    math_temp = read_data_1 - read_data_2;
                end
            end
            else if (op == 3'b111) begin
                //$display("<%d>, Val1 <%d>, <%d>", $time, count, done);
                read_data_1 = out1;
                //$display("<%d>, Val1 <%d>, <%d>", $time, read_data_1, out1);
                if (count < 20) begin
                    count = count + 1;
                    //$display("lol");
                end
                else begin
                    arith_out = math_temp;
                    count = 0;
                    done = 1;
                    //$display("<%d>, l", $time);
                end
                if (count == 17) begin
                    math_temp = read_data_1 << read2;
                    //$display("read_data_1 : %b, read2 : %b", read_data_1, read2);
                end
            end
        end
    end

    always @(posedge clk) begin 
        // $display("Hi, op : %b, input_valid: %b", op, input_valid);
        if (input_valid == 1) begin
            done = 0;
            if (op == 3'b000) begin
                valid_bits = 3'b001;
                write_reg = write;
                data = write_data;
            end
            else if (op == 3'b001) begin
                valid_bits = 3'b100;
                read_reg1 = read1;
            end 
            else if (op == 3'b010) begin
                valid_bits = 3'b110;
                read_reg1 = read1;
                read_reg2 = read2;
            end 
            else if (op == 3'b011) begin
                valid_bits = 3'b101;
                read_reg1 = read1;
                write_reg = write;
                data = write_data;
            end 
            else if (op == 3'b100) begin
                valid_bits = 3'b111;
                read_reg1 = read1;
                read_reg2 = read2;
                write_reg = write;
                data = write_data;
            end  
            else if (op == 3'b101) begin
                valid_bits = 3'b110;
                read_reg1 = read1;
                read_reg2 = read2;
                if(count > 17) begin
                    valid_bits = 3'b001;
                    write_reg = write;
                    data = math_temp;
                end
            end
            else if (op == 3'b110) begin
                valid_bits = 3'b110;
                read_reg1 = read1;
                read_reg2 = read2;
                if(count > 17) begin
                    valid_bits = 3'b001;
                    write_reg = write;
                    data = math_temp;
                end
            end
            else if (op == 3'b111) begin
                //$display("Val <%d>", count);
                valid_bits = 3'b100;
                read_reg1 = read1;
                if(count > 17) begin
                    //$display("Hi");
                    valid_bits = 3'b001;
                    write_reg = write;
                    data = math_temp;
                end
            end
        end
    end

endmodule