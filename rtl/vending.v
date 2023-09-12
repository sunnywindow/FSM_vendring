/*---------------------------------------------------------------*/
/*----------------module:                  ----------------------*/
/*-----------create_time:                  ----------------------*/
/*------------------name:yanghaidong       ----------------------*/
/*---------------------------------------------------------------*/
module vending(
    input	wire		        clk		    ,
    input	wire		        rst_n	    ,
    //输入信号
    input	wire    [3:0]		key_in	    ,
    //输出信号
    output  reg     [3:0]       led         ,
    output  reg     [5:0]       dot         ,
    output  reg     [24:0]      seg_value   ,
    output  reg     [1:0]       buzzer_en     
);
    //内部信号
    parameter   MAX_1S = 49_999_999;//1s

    parameter 
                IDLE    = 5'b00001,
                COIN    = 5'b00010,
                SUBMIT  = 5'b00100,//提交
                SUCCESS = 5'b01000,//购买成功
                FAIL    = 5'b10000;//购买失败

    reg     [4:0]   cstate,nstate   ;

    reg     [25:0]  cnt_1s          ;//1s计数器
    wire            add_cnt_1s      ;
    wire            end_cnt_1s      ;

    reg     [2:0]   cnt_4s          ;//通过1s计数器实现的4s计数器
    wire            add_cnt_4s      ;
    wire            end_cnt_4s      ;

    reg     [3:0]   goods           ;//选择商品
    reg     [9:0]   pay_money       ;//顾客所付付金额
    reg     [9:0]   change          ;//找零

    reg     [3:0]   key_r           ;//按键保存

    reg     [7:0]   buy_number      ;//购买数量
    
    wire    [9:0]   ram_data        ;//ram中读取的商品价格

    reg     [9:0]   summary         ;//商品总价格
    wire            rden            ;

    
    //模块例化
    //ram例化,读取商品单价
    ram_10x32	ram_10x32_inst (
	    .aclr       (~rst_n         ),
	    .address    ({1'b0,goods}   ),
	    .clock      (clk            ),
	    .data       (               ),
	    .rden       (rden           ),
	    .wren       (1'b0           ),
	    .q          (ram_data       )
	);
    assign rden = 1'b1;

   
    //内部逻辑
    //1s计数器和4s计数器用于在succes和FAIL状态回到IDLE状态
    //1s计数器
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            cnt_1s <= 26'd0;
        end
        else begin
            if (add_cnt_1s) begin
                if (end_cnt_1s) begin
                    cnt_1s <= 26'd0;
                end
                else begin
                    cnt_1s <= cnt_1s + 26'd1;
                end
            end
            else begin
                cnt_1s <= cnt_1s;
            end
        end
    end

    assign add_cnt_1s = cstate == SUCCESS || cstate == FAIL;//当在SUCCESS或者FAIL状态时开始计时
    assign end_cnt_1s = add_cnt_1s && cnt_1s == MAX_1S;

    //4s计数器
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            cnt_4s <= 3'd0;
        end
        else begin
            if (add_cnt_4s) begin
                if (end_cnt_4s) begin
                    cnt_4s <= 3'd0;
                end
                else begin
                    cnt_4s <= cnt_4s + 3'd1;
                end
            end
            else begin
                cnt_4s <= cnt_4s;
            end
        end
    end

    assign add_cnt_4s = end_cnt_1s;
    assign end_cnt_4s = add_cnt_4s && cnt_4s == 3;

    //第一段状态机
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            cstate <= IDLE;
        end
        else begin
            cstate <= nstate;
        end
    end

    //第二段状态机
    always @(*) begin
        case (cstate)
            IDLE   : begin
                if (key_in == 4'b1000) begin
                    nstate = COIN;
                end
                else begin
                    nstate = IDLE;
                end
            end
            COIN   : begin
                if (key_in == 4'b1000 ) begin
                    nstate = SUBMIT;
                end
                else begin
                    nstate = COIN;
                end
            end
            SUBMIT :begin//所付的钱大于等于所需的跳转到success，否则跳转到失败
                if (summary <= pay_money) begin
                    nstate = SUCCESS;
                end
                else if (summary > pay_money) begin
                    nstate = FAIL;
                end
                else begin
                    nstate = SUBMIT;
                end
            end
            SUCCESS:begin
                if (end_cnt_4s) begin
                    nstate = IDLE;
                end
                else begin
                    nstate = SUCCESS;
                end
            end
            FAIL   :begin
                if (end_cnt_4s) begin
                    nstate = IDLE;
                end
                else begin
                    nstate = FAIL;
                end
            end
            default: nstate = IDLE;
        endcase
    end

    //第三段状态机
    //商品选择，只要在IDLE状态才能选择商品,商品有16个
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            goods <= 5'd0;
        end
        else if (cstate == IDLE && key_in == 4'b0100) begin//记录一次商品的价格时将商品切换回第一件商品
            goods <= 5'd0;
        end
        else if ((cstate == FAIL || cstate == SUCCESS)&&end_cnt_4s) begin //回到第一件商品
            goods <= 5'd0;
        end 
        else if (goods == 5'd15) begin
            goods <= 5'd0;
        end
        else if (key_in==5'b0001 && cstate == IDLE) begin
            goods <= goods + 5'd1;
        end
        else begin
            goods <= goods;
        end
    end

    //商品个数选择，只要在IDLE状态才能选择商品个数，最大5个
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            buy_number <= 8'd1;
        end
        else if ((cstate == FAIL || cstate == SUCCESS)&&end_cnt_4s) begin //记录一次商品的价格时将商品数量切换回1
            buy_number <= 8'd1;
        end
        else if (cstate == IDLE && key_in == 4'b0100) begin
            buy_number <= 8'd1;
        end
        else if (buy_number == 8'd6) begin
            buy_number <= 8'd1;
        end
        else if (key_in==4'b0010 && cstate == IDLE) begin//增加个数
            buy_number <= buy_number + 8'd1;
        end
        else begin
            buy_number <= buy_number;
        end
    end

    //商品所需的总金额，所选商品1单价*个数+所选商品2单价*个数+......
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            summary <= 10'd0;
        end
        else if ((cstate == FAIL || cstate == SUCCESS)&&end_cnt_4s) begin //清零
            summary <= 10'd0;
        end 
        else if (cstate == IDLE && key_in == 4'b0100) begin
            summary <= summary + ram_data * buy_number;
        end
        else begin
            summary <= summary;
        end
    end

    //顾客所付金额，在COIN状态生效，按下key[0]付0.1元(记录为1)，key[1]付0.5元(记录为5)，key[2]付1元(记录为10)
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            pay_money <= 32'd0;
        end
        else if(cstate == IDLE) begin//IDLE状态清空
            pay_money <= 32'd0;
        end
        else if (cstate == COIN) begin
            if (key_in == 4'b0001 ) begin
                pay_money <= pay_money + 32'd1;
            end
            else if (key_in == 4'b0010) begin
                pay_money <= pay_money + 32'd5;
            end
            else if (key_in == 4'b0100) begin
                pay_money <= pay_money + 32'd10;
            end
            else begin
                pay_money <= pay_money;
            end
        end
        else begin
            pay_money <= pay_money;
        end
    end

    //根据用户选择的商品与所付金额找零,success状态时找零，fail状态退回所付金额
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            change <= 10'd0;
        end
        else if (cstate == SUCCESS) begin
           change <= pay_money - summary;
        end
        else if (cstate == FAIL) begin
            change <= pay_money;
        end
        else begin
            change <= 10'd0;
        end
    end

    //按键状态保存，用于LED显示，提示所做操作
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            key_r <= 4'b0000;
        end
        else if (key_in == 4'b0001) begin
            key_r <= 4'b0001;
        end
        else if (key_in == 4'b0010) begin
            key_r <= 4'b0010;
        end
        else if (key_in == 4'b0100) begin
            key_r <= 4'b0100;
        end
        else if (key_in == 4'b1000) begin
            key_r <= 4'b1000;
        end
        else begin
            key_r <= key_r;
        end
    end

    //LED灯显示
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            led <= 4'b0000;
        end
        else begin
            case (cstate)
                IDLE,COIN : led <= key_r;//选择商品和投币时通过LED灯显示上一步按键操作
                SUCCESS : begin
                    case (cnt_4s)
                        3'd0: led <= 4'b0000;
                        3'd1: led <= 4'b1111;
                        3'd2: led <= 4'b0000;
                        3'd3: led <= 4'b1111;
                        default: led <= 4'b0000;
                    endcase
                end
                FAIL    : begin
                    case (cnt_4s)
                        3'd0: led <= 4'b0001;
                        3'd1: led <= 4'b0011;
                        3'd2: led <= 4'b0111;
                        3'd3: led <= 4'b1111;
                        default: led <= 4'b0000;
                    endcase
                end
                default:led <= 4'b0000;
            endcase
        end
    end

    //数码管显示数据
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            seg_value <= 25'd0;
        end
        else begin
            case (cstate)
                IDLE    : seg_value <= (goods + 2'd1)*100000 + ram_data * 100 + buy_number;//显示所选商品，所选商品单价，购买数量
                COIN    : seg_value <= summary * 1000 + pay_money;//显示商品所需总价格，所投硬币总金额
                SUCCESS : seg_value <= summary * 1000 + change;//商品所需总价格，找零金额
                FAIL    : seg_value <= change;//显示退回金额
                default : seg_value <= 25'd0;
            endcase
        end
    end

    //蜂鸣器信号，当购买成功时响曲1，购买失败时响曲2
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            buzzer_en <= 2'b0;
        end
        else if (cstate == SUCCESS) begin
            buzzer_en <= 2'd1;
        end
        else if (cstate == FAIL) begin
            buzzer_en <= 2'd2;
        end
        else begin
            buzzer_en <= 2'd0;
        end
    end

    //数码管小数点显示
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            dot <= 6'b111_111;
        end
        else begin
            case (cstate)//数码管从右到左
                IDLE: dot <= 6'b110_010;//商品种类(1位).商品单价(三位,前两位与第三位有小数点).商品个数(两位)
                COIN: dot <= 6'b101_001;//商品总价(三位,前两位与第三位有小数点).所投金额(三位,前两位与第三位有小数点)
                SUCCESS: dot <= 6'b101_001;//商品总价(三位,前两位与第三位有小数点).找零金额(三位,前两位与第三位有小数点)
                FAIL : dot <= 6'b101_111;//退款金额(最低两位,中间有小数点)
                default: dot <= 6'b111_111;
            endcase
        end
    end
endmodule