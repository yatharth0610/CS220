module top;

    // Inputs
    reg clk;
    reg [31:0] dividend;
    reg [31:0] divisor;
    reg [4:0] m;
    reg [4:0] n;
    reg ready;

    // Outputs
    wire done;
    wire [31:0] q;
    wire [31:0] rem;
    wire [4:0] num_add;
    wire [4:0] num_sub;
    wire output_valid;

    // Module variables
    reg [3:0] counter = 0;

    // Instantiation of module
    divider DIVIDE(clk, dividend, divisor, m, n, ready, done, q, rem, num_add, num_sub);

    // Setting up clk signal
    initial begin
        forever begin
            clk = 0;
            #5
            clk = 1;
            #5
            clk = 0;
        end
    end

    always @(negedge clk) begin
        if (done == 1 && counter == 0) begin
            dividend <= 7;
            divisor <= 2;
            m <= 3;
            n <= 2;
            ready <= 1;
            counter <= counter + 1;
        end
        else if (done == 1 && counter == 1) begin
            dividend <= 6;
            divisor <= 3;
            m <= 3;
            n <= 2;
            ready <= 1;
            counter <= counter + 1;
        end
        else if (done == 1 && counter == 2) begin
            dividend <= 16;
            divisor <= 3;
            m <= 5;
            n <= 2;
            ready <= 1;
            counter <= counter + 1;
        end
        else if (done == 1 && counter == 3) begin
            dividend <= 16;
            divisor <= 9;
            m <= 5;
            n <= 4;
            ready <= 1;
            counter <= counter + 1;
        end
        else if (done == 1 && counter == 4) begin
            dividend <= 45;
            divisor <= 7;
            m <= 6;
            n <= 3;
            ready <= 1;
            counter <= counter + 1;
        end
        else if (done == 1 && counter == 5) begin
            dividend <= 100;
            divisor <= 17;
            m <= 7;
            n <= 5;
            ready <= 1;
            counter <= counter + 1;
        end
        else if (done == 1 && counter == 6) begin
            dividend <= 111;
            divisor <= 1;
            m <= 7;
            n <= 1;
            ready <= 1;
            counter <= counter + 1;
        end
        else if (done == 1 && counter == 7) begin
            dividend <= 120;
            divisor <= 11;
            m <= 7;
            n <= 4;
            ready <= 1;
            counter <= counter + 1;
        end
        else if (done == 1 && counter == 8) begin
            dividend <= 256;
            divisor <= 33;
            m <= 9;
            n <= 6;
            ready <= 1;
            counter <= counter + 1;
        end
        else if (done == 1 && counter == 9) begin
            dividend <= 53;
            divisor <= 65;
            m <= 6;
            n <= 7;
            ready <= 1;
            counter <= counter + 1;
        end
        else begin 
            ready = 0;
        end
    end

    always @(negedge clk) begin
        if (done == 1 && counter != 0) begin 
            $display("Dividend: %d, Divisor: %d, Quotient: %d, Remainder: %d, Num_additions: %d, Num_subtractions: %d", dividend, divisor, q, rem, num_add, num_sub);
            if (counter == 10) begin 
                $finish;
            end
        end
    end

endmodule 