//============================================================================
//  Arcade: Power Surge
//
//  Port to MiST
//  Copyright (C) 2017 Gehstock
//
// Time pilot by Dar (darfpga@aol.fr) (29/10/2017)
// http://darfpga.blogspot.fr
//
//  This program is free software; you can redistribute it and/or modify it
//  under the terms of the GNU General Public License as published by the Free
//  Software Foundation; either version 2 of the License, or (at your option)
//  any later version.
//
//  This program is distributed in the hope that it will be useful, but WITHOUT
//  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
//  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
//  more details.
//
//  You should have received a copy of the GNU General Public License along
//  with this program; if not, write to the Free Software Foundation, Inc.,
//  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
//============================================================================

module Power_Surge_MiST(
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
	"PSURGE;;",
	"O2,Rotate Controls,Off,On;",
	"O34,Scanlines,Off,25%,50%,75%;",
	"T6,Reset;",
	"V,v1.10.",`BUILD_DATE
};

assign 		LED = 1;
assign 		AUDIO_R = AUDIO_L;
assign 		SDRAM_CLK = clock_48;

wire clock_48, clock_12, clock_14, pll_locked;
pll pll(
	.inclk0(CLOCK_27),
	.c0(clock_48),//24,57600000
	.c1(clock_12),//12.28800000
	.c2(clock_14),//14.31800000
	.locked(pll_locked)
	);


wire [31:0] status;
wire  [1:0] buttons;
wire  [1:0] switches;
wire  [7:0] joystick_0;
wire  [7:0] joystick_1;
wire        scandoublerD;
wire        ypbpr;
reg	[10:0] audio;
wire 			hb, vb;
wire        blankn = ~(hb | vb);
wire 			ce_vid;
wire 			hs, vs;
wire  [4:0] r,g,b;
wire [14:0] rom_addr;
wire [15:0] rom_do;
wire        rom_rd;
wire        ioctl_downl;
wire  [7:0] ioctl_index;
wire        ioctl_wr;
wire [24:0] ioctl_addr;
wire  [7:0] ioctl_dout;
wire        key_strobe;
wire        key_pressed;
wire  [7:0] key_code;

data_io data_io(
	.clk_sys       ( clock_48      ),
	.SPI_SCK       ( SPI_SCK      ),
	.SPI_SS2       ( SPI_SS2      ),
	.SPI_DI        ( SPI_DI       ),
	.ioctl_download( ioctl_downl  ),
	.ioctl_index   ( ioctl_index  ),
	.ioctl_wr      ( ioctl_wr     ),
	.ioctl_addr    ( ioctl_addr   ),
	.ioctl_dout    ( ioctl_dout   )
);
		
sdram rom(
	.*,
	.init          ( ~pll_locked  ),
	.clk           ( clock_48      ),
	.wtbt          ( 2'b00        ),
	.dout          ( rom_do     ),
	.din           ( {ioctl_dout, ioctl_dout} ),
	.addr          ( ioctl_downl ? ioctl_addr : rom_addr ),
	.we            ( ioctl_downl & ioctl_wr ),
	.rd            ( !ioctl_downl & rom_rd),
	.ready()
);

reg reset = 1;
reg rom_loaded = 0;
always @(posedge clock_48) begin
	reg ioctl_downlD;
	ioctl_downlD <= ioctl_downl;
	if (ioctl_downlD & ~ioctl_downl) rom_loaded <= 1;
	reset <= status[0] | buttons[1] | status[6] | ~rom_loaded;
end

power_surge power_surge(
	.clock_12(clock_12),
	.clock_14(clock_14),
	.reset(reset),
	.video_r(r),
	.video_g(g),
	.video_b(b),
	.video_hblank(hb),
	.video_vblank(vb),
	.video_hs(hs),
	.video_vs(vs),
	.audio_out(audio),
	.roms_addr(rom_addr),
	.roms_do(rom_do[7:0]),
	.roms_rd(rom_rd),
	.dip_switch_1("01111000"), // Cabinet Unknown Lives Lives Initial_Energy Unknown Unknown Unknown
	.dip_switch_2("11100000"), // Stop_at_Junctions, Unknown, Unknown, Cheat, Coin_B Coin_B Coin_A Coin_A
	.start2(btn_two_players),
	.start1(btn_one_player),
	.coin1(btn_coin),
	
	.fire1(m_fire),
	.right1(m_right),
	.left1(m_left),
	.down1(m_down),
	.up1(m_up),
	.fire2(m_fire),
	.right2(m_right),
	.left2(m_left),
	.down2(m_down),
	.up2(m_up)
	);
	
mist_video #(.COLOR_DEPTH(5), .SD_HCNT_WIDTH(10)) mist_video(//Wrong Colors have no Idea
	.clk_sys        ( clock_48         ),
	.SPI_SCK        ( SPI_SCK          ),
	.SPI_SS3        ( SPI_SS3          ),
	.SPI_DI         ( SPI_DI           ),
	.R              ( blankn ? r : 0   ),
	.G              ( blankn ? g : 0   ),
	.B              ( blankn ? b : 0   ),
	.HSync          ( hs               ),
	.VSync          ( vs               ),
	.VGA_R          ( VGA_R            ),
	.VGA_G          ( VGA_G            ),
	.VGA_B          ( VGA_B            ),
	.VGA_VS         ( VGA_VS           ),
	.VGA_HS         ( VGA_HS           ),
//	.ce_divider(0),
	.rotate         ( {1'b0,status[2]} ),
	.scandoubler_disable( scandoublerD ),
	.scanlines      ( status[4:3]      ),
	.ypbpr          ( ypbpr            )
	);

user_io #(.STRLEN(($size(CONF_STR)>>3)))user_io(
	.clk_sys        (clock_48       ),
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

dac #(.C_bits(16))dac(
	.clk_i(clock_48),
	.res_n_i(1),
	.dac_i({audio, 5'b00000}),
	.dac_o(AUDIO_L)
	);

wire m_up     = ~status[2] ? btn_right | joystick_0[1] | joystick_1[1] : btn_up | joystick_0[3] | joystick_1[3];
wire m_down   = ~status[2] ? btn_left | joystick_0[0] | joystick_1[0] : btn_down | joystick_0[2] | joystick_1[2];
wire m_left   = ~status[2] ? btn_up | joystick_0[2] | joystick_1[2] : btn_left | joystick_0[1] | joystick_1[1];
wire m_right  = ~status[2] ? btn_down | joystick_0[3] | joystick_1[3] : btn_right | joystick_0[0] | joystick_1[0];
wire m_fire   = btn_fire1 | joystick_0[4] | joystick_1[4];
//wire m_bomb   = btn_fire2 | joystick_0[5] | joystick_1[5];

reg btn_one_player = 0;
reg btn_two_players = 0;
reg btn_left = 0;
reg btn_right = 0;
reg btn_down = 0;
reg btn_up = 0;
reg btn_fire1 = 0;
//reg btn_fire2 = 0;
//reg btn_fire3 = 0;
reg btn_coin  = 0;

always @(posedge clock_48) begin
	reg old_state;
	old_state <= key_strobe;
	if(old_state != key_strobe) begin
		case(key_code)
			'h75: btn_up         	<= key_pressed; // up
			'h72: btn_down        	<= key_pressed; // down
			'h6B: btn_left      		<= key_pressed; // left
			'h74: btn_right       	<= key_pressed; // right
			'h76: btn_coin				<= key_pressed; // ESC
			'h05: btn_one_player   	<= key_pressed; // F1
			'h06: btn_two_players  	<= key_pressed; // F2
//			'h14: btn_fire3 			<= key_pressed; // ctrl
//			'h11: btn_fire2 			<= key_pressed; // alt
			'h29: btn_fire1   		<= key_pressed; // Space
		endcase
	end
end

endmodule 