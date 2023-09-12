/*--------------------------------------------------------------------*/
/*----------------module:vending_top            ----------------------*/
/*-----------create_time:2023/8/9--13:52:07     ----------------------*/
/*------------------name:yanghaidong            ----------------------*/
/*--------------------------------------------------------------------*/
module vending_top(
    input	wire		        clk		,
    input	wire		        rst_n	,
    //输入信号
    input	wire	[3:0]		key	    ,
    //输出信号
    output	wire    [5:0]	    sel	    ,
    output	wire	[7:0]	    seg	    ,
    output	wire	[3:0]		led	    ,
    output	wire	            buzzer	
);
    //内部信号
    wire    [3:0]   key_out     ;
    wire    [24:0]  seg_value   ;
    wire    [1:0]   buzzer_en   ;
    wire    [5:0]   dot         ;

    //模块例化

    //按键消抖模块
    key_debounce u_key_debounce (
    /* input   wire        */           .clk                (clk                ),
    /* input   wire        */           .rst_n              (rst_n              ),
    /* input   wire [3:0]  */           .key_in             (key                ),

    /* output  wire [3:0]  */           .key_out            (key_out            )
    );

    //售货机状态模块
    vending u_vending(
    /* input	wire		     */     .clk		        (clk                ),
    /* input	wire		     */     .rst_n	            (rst_n              ),
    /* //输入信号 */
    /* input	wire    [2:0]	 */	    .key_in	            (key_out            ),
    //输出信号
    /* //输出信号 */
    /* output  reg     [3:0]    */      .led                (led                ),
    /*output  reg     [5:0]      */     .dot                (dot                ),
    /* output  reg     [24:0]   */      .seg_value          (seg_value          ),
    /* output	wire	    	 */	    .buzzer_en		    (buzzer_en          )
    );

    //数码管显示模块
    seg_driver u_seg_driver(
    /* input	wire		  */        .clk		        (clk                ),
    /* input	wire		  */        .rst_n	            (rst_n              ),
    /* //输入信号 */
    /*input   wire    [5:0]   */        .dot                (dot                ),
    /*input   wire    [24:0]  */        .seg_value          (seg_value          ),
    /* //输出信号 */
    /* output	reg     [5:0] */	    .sel	            (sel                ),
    /* output	reg		[7:0] */	    .seg	            (seg                )
    );

    //蜂鸣器发声模块
    buzzer_ctrl u_buzzer_ctrl(
    /* input	wire		    */      .clk		        (clk                ),
    /* input	wire		    */      .rst_n	            (rst_n              ),
    /* //输入信号 */
    /* input	wire	        */      .work_en	        (buzzer_en          ),
    /* //输出信号 */
    /* output  wire       */            .end_note           (                   ),//播完一次曲子后停止
    /* output	wire	        */      .buzzer	            (buzzer             )
    );

    //内部逻辑









endmodule