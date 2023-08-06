// SPDX-License-Identifier: MIT

module top_module(
    input clk,
    input areset,

    input  predict_valid,
    input  [6:0] predict_pc,
    output predict_taken,
    output [6:0] predict_history,

    input train_valid,
    input train_taken,
    input train_mispredicted,
    input [6:0] train_history,
    input [6:0] train_pc
);

    reg [2*128-1:0] PHT;
    
    wire [6:0] predict_index = predict_pc ^ predict_history;
    wire [6:0] train_index = train_pc ^ train_history;
    
    wire [1:0] train_target = PHT[train_index*2 +: 2];
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            PHT <= {128{2'b01}};
            predict_history <= 7'd0;
        end else begin
            if (train_valid) begin
                if (train_taken) PHT[train_index*2 +: 2] <= (train_target == 2'b11)? 2'b11 : train_target + 2'b01;
                else PHT[train_index*2 +: 2] <= (train_target == 2'b00)? 2'b00 : train_target - 2'b01;
            end 
            
            if (train_valid & train_mispredicted)
                predict_history <= {train_history[5:0], train_taken};
            else if (predict_valid) begin
                predict_history <= {predict_history[5:0], predict_taken};
            end
        end
    end
    
    assign predict_taken = PHT[predict_index*2 +: 2] >= 2'd2;
    
endmodule

