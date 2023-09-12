/*---------------------------------------------------------------*/
/*-------------tb_module:                  ----------------------*/
/*-----------create_time:                  ----------------------*/
/*------------------name:yanghaidong       ----------------------*/
/*---------------------------------------------------------------*/
`timescale 1ns/1ns
module top_tb();
    //内部信号
    parameter	CYCLE = 20  ;
    reg		        clk		; 
    reg		        rst_n	;
    reg     [3:0]   key     ;
    reg             wren    ;
    reg     [9:0]   data_in ;
    wire    [5:0]   sel     ;
    wire    [7:0]   seg     ;
    wire            buzzer  ;

    //模块例化
    vending_top u_vending_top(
    /* input	wire		  */    .clk	    (clk	    ),
    /* input	wire		  */    .rst_n	    (rst_n      ),
    /* input	wire	[3:0] */    .key	    (key	    ),
    /* output	wire    [5:0] */    .sel	    (sel	    ),
    /* output	wire	[7:0] */	.seg	    (seg	    ),
    /* output	wire	[3:0] */	.led	    (led	    ),
    /*output	wire	      */    .buzzer	    (buzzer     )
    );
    defparam    u_vending_top.u_key_debounce.MAX_20ms   = 100;
    defparam    u_vending_top.u_vending.MAX_1S          = 1000;
    defparam    u_vending_top.u_seg_driver.TIME_20us    = 10;
    defparam    u_vending_top.u_buzzer_ctrl.TIME_300ms  = 300;
    defparam    u_vending_top.u_buzzer_ctrl.H_1         = 400;
    defparam    u_vending_top.u_buzzer_ctrl.H_2         = 350;
    defparam    u_vending_top.u_buzzer_ctrl.H_3         = 300;
    defparam    u_vending_top.u_buzzer_ctrl.H_4         = 250;
    defparam    u_vending_top.u_buzzer_ctrl.H_5         = 200;
    defparam    u_vending_top.u_buzzer_ctrl.H_6         = 150;
    defparam    u_vending_top.u_buzzer_ctrl.H_7         = 100;


    //测试逻辑
    initial begin
        clk		= 1'b0;
        rst_n	= 1'b0;
        wren    = 1'b0;
        data_in = 10'd0;
        key     = 4'b1111;
    end

    always #(CYCLE/2) clk = ~clk;

    initial begin
        #(CYCLE+3) rst_n = 1'b1;
        key_press1; //购买数量加1，现在为2
        key_press2; //记录当前总价格
        key_press0; //选择第二件商品
        key_press2; //记录当前总价格
        key_press3; //确认，进入投币
        repeat(20) begin //投币20元
            key_press2;
        end
        key_press1; //投币20.5元
        key_press0;//投币20.6元
        key_press3;//确认,付款结算
        #(300000);
        
        key_press0; //选择第二件商品
        key_press1; //购买数量加1，现在为2
        key_press3; //确认，进入投币
        key_press2; //投币0.5元
        key_press3;//确认,付款结算
        #(CYCLE * 2000);
        $stop(2);
    end

    task  key_press0; // 任务名
		begin
			key     = 4'b1110;
			#(200 * CYCLE);
			key     = 4'b1111;
			#(200 * CYCLE);
		end 
	endtask
    task  key_press1; // 任务名
		begin
			key     = 4'b1101;
			#(200 * CYCLE);
			key     = 4'b1111;
			#(200 * CYCLE);
		end 
	endtask
    task  key_press2; // 任务名
		begin
			key     = 4'b1011;
			#(200 * CYCLE);
			key     = 4'b1111;
			#(200 * CYCLE);
		end 
	endtask
    task  key_press3; // 任务名
		begin
			key     = 4'b0111;
			#(200 * CYCLE);
			key     = 4'b1111;
			#(200 * CYCLE);
		end 
	endtask
endmodule