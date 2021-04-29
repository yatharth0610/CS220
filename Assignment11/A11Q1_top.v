module top;

    // Inputs
    reg clk;
    reg [31:0] multiplicand;
    reg [31:0] multiplier;
    reg [4:0] m;
    reg [4:0] n;
    reg ready;

    // Outputs
    wire done;
    wire [31:0] product;
    wire [4:0] num_add;
    wire [4:0] num_sub;
    wire output_valid;

    // Module variables
    reg [3:0] counter = 0;

    // Instantiation of module
    multiplier MULTIPLY(clk, multiplicand, multiplier, ready, done, product, num_add, num_sub);

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
            multiplicand <= 117;
            multiplier <= 253;
            ready <= 1;
            counter <= counter + 1;
        end
        else if (done == 1 && counter == 1) begin
            multiplicand <= -526;
            multiplier <= -1000;
            ready <= 1;
            counter <= counter + 1;
        end
        else if (done == 1 && counter == 2) begin
            multiplicand <= 100000;
            multiplier <= -4523;
            ready <= 1;
            counter <= counter + 1;
        end
        else if (done == 1 && counter == 3) begin
            multiplicand <= 15616;
            multiplier <= 0;
            ready <= 1;
            counter <= counter + 1;
        end
        else if (done == 1 && counter == 4) begin
            multiplicand <= -45;
            multiplier <= 1;
            ready <= 1;
            counter <= counter + 1;
        end
        else if (done == 1 && counter == 5) begin
            multiplicand <= 0;
            multiplier <= 171;
            ready <= 1;
            counter <= counter + 1;
        end
        else if (done == 1 && counter == 6) begin
            multiplicand <= 111;
            multiplier <= -0;
            ready <= 1;
            counter <= counter + 1;
        end
        else if (done == 1 && counter == 7) begin
            multiplicand <= 1024;
            multiplier <= 2048;
            ready <= 1;
            counter <= counter + 1;
        end
        else if (done == 1 && counter == 8) begin
            multiplicand <= 256;
            multiplier <= -33;
            ready <= 1;
            counter <= counter + 1;
        end
        else if (done == 1 && counter == 9) begin
            multiplicand <= 513;
            multiplier <= 65;
            ready <= 1;
            counter <= counter + 1;
        end
        else begin 
            ready = 0;
        end
    end

    always @(negedge clk) begin
        if (done == 1 && counter != 0) begin 
            $display("multiplicand: %d, multiplier: %d, binary_multiplier: %b, product: %d, Num_additions: %d, Num_subtractions: %d", $signed(multiplicand), $signed(multiplier), multiplier, $signed(product), num_add, num_sub);
            if (counter == 10) begin 
                $finish;
            end
        end
    end

endmodule 