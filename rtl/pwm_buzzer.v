module pwm_buzzer (
    input   wire            clk             ,
    input   wire            rst_n           ,
    input   wire    [17:0]  freq_data       ,
    input   wire            work_en         ,
    input   wire            end_cnt_300ms   ,


    output  reg             buzzer
);  
    wire            flag            ;
    wire    [14:0]  duty_data       ;//占空比数据
    reg     [17:0]	cnt_freq        ;//音符音频计数器



    //音谱计时模块
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            cnt_freq <= 18'd0;
        end
        else if (end_cnt_300ms) begin
            cnt_freq <= 18'd0;
        end
        else if(cnt_freq == freq_data - 1)begin
            cnt_freq <= 18'd0;
        end 
        else if(work_en) begin
            cnt_freq <= cnt_freq + 18'd1;
        end 
    end


    assign duty_data = freq_data >> 2;//占空比25%

    assign flag = ((cnt_freq >= duty_data) && work_en) ? 1'b1:1'b0;//前50%为低电平，后50%为高电平
    
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            buzzer <= 1'b1;
        end
        else if (flag) begin
            buzzer <= 1'b0;
        end
        else begin
            buzzer <= 1'b1;
        end
    end

endmodule