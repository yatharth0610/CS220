module multiplier(clk, multiplicand, multiplier, ready, done, product, num_add, num_sub);

    // Inputs 
    input clk;
    input [31:0] multiplicand;
    input [31:0] multiplier;
    input ready;

    // Outputs 
    output reg done = 1;
    output reg [31:0] product;
    output reg [4:0] num_add ;
    output reg [4:0] num_sub ;
    
    // Module vars
    reg [5:0] count;
    reg curr;
    reg [31:0] temp = 32'b11111111111111111111111111111111;
    reg [31:0] check;

    // Module logic
    always @(posedge clk) begin
        if (ready == 1) begin
            done = 0;
            count = 0;
            product = 0;
            curr = 0;
            num_add = 0;
            num_sub = 0; 
        end 
        else if (done == 0) begin
            if (curr == 1) begin
                check = multiplier ^ temp;
                if (check <= (1<<(count-2))) begin
                    done <= 1;
                end
            end
            else if (curr == 0) begin
                if (multiplier <= (1 << (count-2))) begin
                    done <= 1;
                end
            end
            if (count == 32) begin
                done <= 1;
            end
            else begin
                if (curr != multiplier[count]) begin
                    if (curr == 0) begin
                        product = product - (multiplicand << count);
                        num_sub = num_sub + 1;
                    end
                    else begin
                        product = product + (multiplicand << count);
                        num_add = num_add + 1;
                    end
                    curr = multiplier[count];
                end
                count = count + 1;
            end
        end  
    end

endmodule 
