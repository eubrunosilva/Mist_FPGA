module xevious_mist
(
	output        LED,
	output  [5:0] VGA_R,
	output  [5:0] VGA_G,
	output  [5:0] VGA_B,
	output        VGA_HS,
	output        VGA_VS,
	output        AUDIO_L,
	output        AUDIO_R,
	input         SPI_SCK,
	output        SPI_DO,
	input         SPI_DI,
	input         SPI_SS2,
	input         SPI_SS3,
	input         CONF_DATA0,
	input         CLOCK_27,
	
	output [12:0] SDRAM_A,
	inout  [15:0] SDRAM_DQ,
	output        SDRAM_DQML,
	output        SDRAM_DQMH,
	output        SDRAM_nWE,
	output        SDRAM_nCAS,
	output        SDRAM_nRAS,
	output        SDRAM_nCS,
	output  [1:0] SDRAM_BA,
	output        SDRAM_CLK,
	output        SDRAM_CKE
);

`include "rtl\build_id.v" 

localparam CONF_STR = {
	"XEVIOUS;ROM;",
	"O7,Game,Xevious,SXevious;",
	"O2,Rotate Controls,Off,On;",
	"O34,Scanlines,Off,25%,50%,75%;",
	"O5,Blend,Off,On;",
	"T6,Reset;",
	"V,v1.00.",`BUILD_DATE
};

assign LED = ~ioctl_downl;
assign AUDIO_R = AUDIO_L;
assign SDRAM_CLK = clk_72;
assign SDRAM_CKE = 1;

wire clk_18, clk_72;
wire pll_locked;
pll pll(
	.inclk0(CLOCK_27),
	.c0(clk_18),
	.c1(clk_72),
	.locked(pll_locked)
	);

wire        clk_sys = clk_18;
wire        clk_mem = clk_72;

reg         reset;
always @(posedge clk_sys)
	reset <= status[0] | status[6] | buttons[1] | ioctl_downl;

wire [31:0] status;
wire  [1:0] buttons;
wire  [1:0] switches;
wire  [9:0] kbjoy;
wire  [7:0] joystick_0;
wire  [7:0] joystick_1;
wire        scandoublerD;
wire        ypbpr;
wire [10:0] ps2_key;
wire [10:0] audio;
wire hs, vs;
wire blankn;
wire [3:0] r,g,b;

wire        ioctl_downl;
wire  [7:0] ioctl_index;
wire        ioctl_wr;
wire [24:0] ioctl_addr;
wire  [7:0] ioctl_dout;

data_io data_io(
	.clk_sys       ( clk_sys      ),
	.SPI_SCK       ( SPI_SCK      ),
	.SPI_SS2       ( SPI_SS2      ),
	.SPI_DI        ( SPI_DI       ),
	.ioctl_download( ioctl_downl  ),
	.ioctl_index   ( ioctl_index  ),
	.ioctl_wr      ( ioctl_wr     ),
	.ioctl_addr    ( ioctl_addr   ),
	.ioctl_dout    ( ioctl_dout   )
);

reg port1_req, port2_req;
wire [15:0] cpu1_addr;
wire [15:0] cpu1_q;
wire [15:0] cpu2_addr;
wire [15:0] cpu2_q;
wire [15:0] cpu3_addr;
wire [15:0] cpu3_q;
wire [16:0] fg_addr;
wire [15:0] fg_q;
wire [16:0] bg0_addr;
wire [15:0] bg0_q;
wire [16:0] bg1_addr;
wire [15:0] bg1_q;
wire [16:0] sp1_addr;
wire [15:0] sp1_q;
wire [16:0] sp2_addr;
wire [15:0] sp2_q;

sdram sdram(
	.*,
	.init_n        ( pll_locked   ),
	.clk           ( clk_mem      ),

	// port1 used for CPU 1-2-3-fg-bg
	.port1_req     ( port1_req    ),
	.port1_ack     ( ),
	.port1_a       ( ioctl_addr[23:1] ),
	.port1_ds      ( {ioctl_addr[0], ~ioctl_addr[0]} ),
	.port1_we      ( ioctl_downl ),
	.port1_d       ( {ioctl_dout, ioctl_dout} ),
	.port1_q       ( ),

	.cpu1_addr     ( cpu1_addr[15:1] ),
	.cpu1_q        ( cpu1_q    ),
	.cpu2_addr     ( cpu2_addr[15:1] ),
	.cpu2_q        ( cpu2_q    ),
	.cpu3_addr     ( cpu3_addr[15:1] ),
	.cpu3_q        ( cpu3_q    ),
	.fg_addr       ( fg_addr[16:1] ),
	.fg_q          ( fg_q    ),
	.bg0_addr      ( bg0_addr[16:1] ),
	.bg0_q         ( bg0_q    ),
	.bg1_addr      ( bg1_addr[16:1] ),
	.bg1_q         ( bg1_q    ),

	// port2 for sprite graphx
	.port2_req     ( port2_req ),
	.port2_ack     ( ),
	.port2_a       ( ioctl_addr[23:1] ),
	.port2_ds      ( {ioctl_addr[0], ~ioctl_addr[0]} ),
	.port2_we      ( ioctl_downl ),
	.port2_d       ( {ioctl_dout, ioctl_dout} ),
	.port2_q       ( ),

	.sp1_addr      ( sp1_addr[16:1] ),
	.sp1_q         ( sp1_q    ),
	.sp2_addr      ( sp2_addr[16:1] ),
	.sp2_q         ( sp2_q    )

);

// data upload controller
always @(posedge clk_sys) begin
	reg        ioctl_wr_last = 0;

	ioctl_wr_last <= ioctl_wr;
	if (ioctl_downl) begin
		if (~ioctl_wr_last && ioctl_wr) begin
			port1_req <= ~port1_req;
			port2_req <= ~port2_req;
		end
	end
end

xevious xevious(
	.clock_18          ( clk_sys ),
	.reset             ( reset ),
	.cpu1_addr_o       ( cpu1_addr ),
	.cpu1_rom_do       ( cpu1_addr[0] ? cpu1_q[15:8] : cpu1_q[7:0] ),
	.cpu2_addr_o       ( cpu2_addr ),
	.cpu2_rom_do       ( cpu2_addr[0] ? cpu2_q[15:8] : cpu2_q[7:0] ),
	.cpu3_addr_o       ( cpu3_addr ),
	.cpu3_rom_do       ( cpu3_addr[0] ? cpu3_q[15:8] : cpu3_q[7:0] ),
	.fg_addr_o         ( fg_addr ),
	.fg_rom_do         ( fg_addr[0] ? fg_q[15:8] : fg_q[7:0] ),
	.bg0_addr_o        ( bg0_addr ),
	.bg0_rom_do        ( bg0_addr[0] ? bg0_q[15:8] : bg0_q[7:0] ),
	.bg1_addr_o        ( bg1_addr ),
	.bg1_rom_do        ( bg1_addr[0] ? bg1_q[15:8] : bg1_q[7:0] ),
	.sp_grphx_1_addr_o ( sp1_addr ),
	.sp_grphx_1_do     ( sp1_addr[0] ? sp1_q[15:8] : sp1_q[7:0] ),
	.sp_grphx_2_addr_o ( sp2_addr ),
	.sp_grphx_2_do     ( sp2_addr[0] ? sp2_q[15:8] : sp2_q[7:0] ),

	.video_r(r),
	.video_g(g),
	.video_b(b),
	.video_hs(hs),
	.video_vs(vs),
	.video_blankn(blankn),
	.audio(audio),
	.freeze(status[7]),
	.coin(btn_coin),
	.start1(btn_one_player),
	.left(m_left),
	.right(m_right),
	.up(m_up),
	.down(m_down),
	.fire(m_fire),
	.bomb(m_bomb),
	.start2(btn_two_players)
	);

mist_video #(.COLOR_DEPTH(4), .SD_HCNT_WIDTH(10)) mist_video(
	.clk_sys(clk_sys),
	.SPI_SCK(SPI_SCK),
	.SPI_SS3(SPI_SS3),
	.SPI_DI(SPI_DI),
	.R(blankn ? r : 0),
	.G(blankn ? g : 0),
	.B(blankn ? b : 0),
	.HSync(hs),
	.VSync(vs),
	.VGA_R(VGA_R),
	.VGA_G(VGA_G),
	.VGA_B(VGA_B),
	.VGA_VS(VGA_VS),
	.VGA_HS(VGA_HS),
	.ce_divider(1'b1),
	.rotate({1'b1,status[2]}),
	.scanlines(status[4:3]),
	.blend(status[5]),
	.scandoubler_disable(scandoublerD),
	.ypbpr(ypbpr)
	);

user_io #(
	.STRLEN(($size(CONF_STR)>>3)))
user_io(
	.clk_sys        (clk_sys        ),
	.conf_str       (CONF_STR       ),
	.SPI_CLK        (SPI_SCK        ),
	.SPI_SS_IO      (CONF_DATA0     ),
	.SPI_MISO       (SPI_DO         ),
	.SPI_MOSI       (SPI_DI         ),
	.buttons        (buttons        ),
	.switches       (switches       ),
	.scandoubler_disable (scandoublerD	  ),
	.ypbpr          (ypbpr          ),
	.key_strobe     (key_strobe     ),
	.key_pressed    (key_pressed    ),
	.key_code       (key_code       ),
	.joystick_0     (joystick_0     ),
	.joystick_1     (joystick_1     ),
	.status         (status         )
	);

dac #(
	.C_bits(11))
dac(
	.clk_i(clk_sys),
	.res_n_i(1),
	.dac_i(audio),
	.dac_o(AUDIO_L)
	);

//											Rotated														Normal
wire m_up     = ~status[2] ? btn_left | joystick_0[1] | joystick_1[1] : btn_up | joystick_0[3] | joystick_1[3];
wire m_down   = ~status[2] ? btn_right | joystick_0[0] | joystick_1[0] : btn_down | joystick_0[2] | joystick_1[2];
wire m_left   = ~status[2] ? btn_down | joystick_0[2] | joystick_1[2] : btn_left | joystick_0[1] | joystick_1[1];
wire m_right  = ~status[2] ? btn_up | joystick_0[3] | joystick_1[3] : btn_right | joystick_0[0] | joystick_1[0];

wire m_fire   = btn_fire1 | joystick_0[4] | joystick_1[4];
wire m_bomb   = btn_fire2 | joystick_0[5] | joystick_1[5];

reg btn_one_player = 0;
reg btn_two_players = 0;
reg btn_left = 0;
reg btn_right = 0;
reg btn_down = 0;
reg btn_up = 0;
reg btn_fire1 = 0;
reg btn_fire2 = 0;
reg btn_fire3 = 0;
reg btn_coin  = 0;
wire       key_pressed;
wire [7:0] key_code;
wire       key_strobe;

always @(posedge clk_sys) begin
	if(key_strobe) begin
		case(key_code)
			'h75: btn_up         	<= key_pressed; // up
			'h72: btn_down        	<= key_pressed; // down
			'h6B: btn_left      	<= key_pressed; // left
			'h74: btn_right       	<= key_pressed; // right
			'h76: btn_coin			<= key_pressed; // ESC
			'h05: btn_one_player   	<= key_pressed; // F1
			'h06: btn_two_players  	<= key_pressed; // F2
			'h14: btn_fire3 		<= key_pressed; // ctrl
			'h11: btn_fire2 		<= key_pressed; // alt
			'h29: btn_fire1   		<= key_pressed; // Space
		endcase
	end
end

endmodule 