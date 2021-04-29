module divider(clk, dividend, divisor, m, n, ready, done, q, rem, num_add, num_sub);

    // Inputs 
    input clk;
    input [31:0] dividend;
    input [31:0] divisor;
    input [4:0] m;
    input [4:0] n;
    input ready;

    // Outputs 
    output reg done = 1;
    output reg [31:0] rem;
    output reg [31:0] q;
    output reg [4:0] num_add ;
    output reg [4:0] num_sub ;
    
    // Module vars
    reg [31:0] temp_divisor;
    reg count_clk = 0;
    reg [4:0] count;

    // Module logic
    always @(posedge clk) begin
        if (ready == 1) begin
            done = 0;
            count = 0;
            q = 0;
            num_add = 0;
            num_sub = 0;
            rem = dividend; 
            temp_divisor = divisor; 
            if (count_clk == 0) begin
                temp_divisor = temp_divisor << (m-n);
                count_clk = 1;
            end
        end 
        else if (done == 0) begin
            count_clk = 0;
            if (count != m-n+1) begin
                if (rem[31] == 1) begin
                    num_add += 1;
                    rem = rem + temp_divisor; 
                    q = q^1;
                    q = (q << 1) | 1;
                    if (count != m-n) begin 
                        temp_divisor = temp_divisor >> 1;
                    end
                end 
                else begin
                    num_sub += 1;
                    rem = rem - temp_divisor;
                    q = (q << 1) | 1;
                    if (count != m-n) begin 
                        temp_divisor = (temp_divisor >> 1);
                    end
                end 
                count++;
            end
            else begin 
                if (rem[31] == 1) begin
                    num_add += 1; 
                    rem <= rem + temp_divisor;
                    q <= q^1; 
                end
                done <= 1;
            end   
        end  
    end

endmodule 