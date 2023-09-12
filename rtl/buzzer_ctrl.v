/*---------------------------------------------------------------*/
/*----------------module:                  ----------------------*/
/*-----------create_time:                  ----------------------*/
/*------------------name:yangHaidong       ----------------------*/
/*---------------------------------------------------------------*/
module buzzer_ctrl(
    input	wire		    clk		    ,
    input	wire		    rst_n	    ,
    //输入信号
    input	wire    [1:0]   work_en	    ,
    //输出信号
    output  wire            end_note    ,   
    output	wire	        buzzer	
);
    //内部信号
    parameter   TIME_300ms  = 25'd14_999_999;//300ms
    parameter   
                L_1     = 18'd191131,
                L_2     = 18'd170242,
                L_3     = 18'd151699,
                L_4     = 18'd143184,
                L_5     = 18'd127551,
                L_6     = 18'd113636,
                L_7     = 18'd101235,

                Z_1     = 18'd95547,
                Z_2     = 18'd85135,
                Z_3     = 18'd75838,
                Z_4     = 18'd71582,
                Z_5     = 18'd63775,
                Z_6     = 18'd56818,
                Z_7     = 18'd50607,

                H_1     = 18'd47801,  
                H_2     = 18'd42553,
                H_3     = 18'd37900,
                H_4     = 18'd37550,
                H_5     = 18'd31850,
                H_6     = 18'd28400,
                H_7     = 18'd25400;

    parameter   NOTES_lzlh      = 7'd31,
                NOTES_xxx       = 7'd41;
    
    reg     [17:0]	freq_data       ;
    wire    [6:0]   NOTES           ;//音符个数

    reg     [24:0]  cnt_300ms       ;//300ms计数器
    wire            add_cnt_300ms   ;
    wire            end_cnt_300ms   ;


    reg     [7:0]	cnt_note        ;//音符数据寄存器
    wire            add_cnt_note    ;
    wire            end_cnt_note    ;


    //模块例化
    pwm_buzzer u_pwm_buzzer(
    /* input   wire            */   .clk            (clk            ),
    /* input   wire            */   .rst_n          (rst_n          ),
    /* input   wire    [17:0]  */   .freq_data      (freq_data      ),
    /* input   wire    [1:0]  */    .work_en        (|work_en       ),
                                    .end_cnt_300ms  (end_cnt_300ms  ),

    /* output  reg             */   .buzzer         (buzzer         )
    );

    //内部逻辑


    
    //300ms计数器
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            cnt_300ms <= 24'd0;
        end
        else if (work_en == 2'd0) begin
            cnt_300ms <= 24'd0;
        end
        else begin
            if (add_cnt_300ms) begin
                if (end_cnt_300ms) begin
                    cnt_300ms <= 24'd0;
                end
                else begin
                    cnt_300ms <= cnt_300ms + 1'b1;
                end
            end
            else begin
                cnt_300ms <= cnt_300ms;
            end
        end
    end

    assign add_cnt_300ms = work_en; 
    assign end_cnt_300ms = add_cnt_300ms && cnt_300ms == TIME_300ms;//计满300ms


    //音符个数计数器
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            cnt_note <= 7'd0;
        end
        else if (work_en == 2'd0) begin
            cnt_note <= 7'd0;
        end
        else begin
            if (add_cnt_note) begin
                if (end_cnt_note ) begin
                    cnt_note <= 7'd0;
                end
                else begin
                    cnt_note <= cnt_note + 7'd1;
                end
            end
            else begin
                cnt_note <= cnt_note;
            end
        end
    end

    assign add_cnt_note = end_cnt_300ms;
    assign end_cnt_note = add_cnt_note && cnt_note == NOTES_lzlh && end_cnt_300ms;
    assign NOTES = work_en == 2'd1 ? NOTES_lzlh : NOTES_xxx; //根据选择的歌曲切换音符个数
    assign end_note = end_cnt_note;

    //根据当前音符序号来给频率计数器赋值
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            freq_data <= 18'd0;
        end
        else begin
            case (work_en)
                2'd1: begin
                    case(cnt_note)
                        //两只老虎
                        7'd0    :	freq_data = H_1;
                        7'd1    :	freq_data = H_2;
                        7'd2    :	freq_data = H_3;
                        7'd3    :	freq_data = H_1;

                        7'd4    :	freq_data = H_1;
                        7'd5    :	freq_data = H_2;
                        7'd6    :	freq_data = H_3;
                        7'd7    :	freq_data = H_1;

                        7'd8    :	freq_data = H_3;
                        7'd9    :	freq_data = H_4;
                        7'd10   :	freq_data = H_5;

                        7'd11   :	freq_data = H_3;
                        7'd12   :	freq_data = H_4;
                        7'd13   :	freq_data = H_5;

                        7'd14   :	freq_data = H_5;
                        7'd15   :	freq_data = H_6;
                        7'd16   :	freq_data = H_5;
                        7'd17   :	freq_data = H_4;
                        7'd18   :	freq_data = H_3;
                        7'd19   :	freq_data = H_1;

                        7'd20   :	freq_data = H_5;
                        7'd21   :	freq_data = H_6;
                        7'd22   :	freq_data = H_5;
                        7'd23   :	freq_data = H_4;
                        7'd24   :	freq_data = H_3;
                        7'd25   :	freq_data = H_1;

                        7'd26   :	freq_data = H_1;
                        7'd27   :	freq_data = H_5;
                        7'd28   :	freq_data = H_1;

                        7'd29   :	freq_data = H_1;
                        7'd30   :	freq_data = H_5;
                        7'd31   :	freq_data = H_1;

                        default:freq_data = H_1;
                    endcase
                end
                2'd2: begin
                    case (cnt_note)
                        //小星星
                        7'd0   :	freq_data = H_1;//1
                        7'd1   :	freq_data = H_1;//1
                        7'd2   :	freq_data = H_5;//5
                        7'd3   :	freq_data = H_5;//5
                        7'd4   :	freq_data = H_6;//6
                        7'd5   :	freq_data = H_6;//6
                        7'd6   :	freq_data = H_5;//5
                        7'd7   :	freq_data = H_4;//4
                        7'd8   :	freq_data = H_4;//4
                        7'd9   :	freq_data = H_3;//3
                        7'd10   :	freq_data = H_3;//3
                        7'd11   :	freq_data = H_2;//2
                        7'd12   :	freq_data = H_2;//2
                        7'd13   :	freq_data = H_1;//1
                        7'd14   :	freq_data = H_5;//5
                        7'd15   :	freq_data = H_5;//5
                        7'd16   :	freq_data = H_4;//4
                        7'd17   :	freq_data = H_4;//4
                        7'd18   :	freq_data = H_3;//3
                        7'd19   :	freq_data = H_3;//3
                        7'd20   :	freq_data = H_2;//2
                        7'd21   :	freq_data = H_5;//5
                        7'd22   :	freq_data = H_5;//5
                        7'd23   :	freq_data = H_4;//4
                        7'd24   :	freq_data = H_4;//4
                        7'd25   :	freq_data = H_3;//3
                        7'd26   :	freq_data = H_3;//3
                        7'd27   :	freq_data = H_2;//2
                        7'd28   :	freq_data = H_1;//1
                        7'd29   :	freq_data = H_1;//1
                        7'd30   :	freq_data = H_5;//5
                        7'd31   :	freq_data = H_5;//5
                        7'd32   :	freq_data = H_6;//6
                        7'd33   :	freq_data = H_6;//6
                        7'd34   :	freq_data = H_5;//5

                        7'd35   :	freq_data = H_4;//4
                        7'd36   :	freq_data = H_4;//4
                        7'd37   :	freq_data = H_3;//3
                        7'd38   :	freq_data = H_3;//3
                        7'd39   :	freq_data = H_2;//2
                        7'd40   :	freq_data = H_2;//2
                        7'd41   :	freq_data = H_1;//1
                        default :   freq_data = H_1;
                    endcase
                end
                default: freq_data = H_1;
            endcase
        end
    end

endmodule