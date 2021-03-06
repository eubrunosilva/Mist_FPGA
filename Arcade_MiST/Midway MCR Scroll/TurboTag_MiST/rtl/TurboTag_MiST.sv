//============================================================================
//  Arcade: Spy Hunter by DarFPGA
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

module SpyHunter_MiST(
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

`include "rtl/build_id.v"

localparam CONF_STR = {
	"TURBOTAG;ROM;",
	"O2,Rotate Controls,Off,On;",
	"O5,Blend,Off,On;",
	"O6,Service,Off,On;",
	"T0,Reset;",
	"V,v1.0.",`BUILD_DATE
};

assign LED = ~ioctl_downl;
assign SDRAM_CLK = clk_mem;
assign SDRAM_CKE = 1;

wire clk_sys, clk_mem;
wire pll_locked;
pll_mist pll(
	.inclk0(CLOCK_27),
	.areset(0),
	.c0(clk_sys),
	.c1(clk_mem),
	.locked(pll_locked)
	);

wire [31:0] status;
wire  [1:0] buttons;
wire  [1:0] switches;
wire [15:0] joystick_0;
wire [15:0] joystick_1;
wire        scandoublerD;
wire        ypbpr;
wire [15:0] audio_l, audio_r;
wire  [9:0] csd_audio;
wire        hs, vs, cs;
wire        blankn;
wire  [2:0] g, r, b;
wire [15:0] rom_addr;
wire [15:0] rom_do;
wire [14:1] csd_addr;
wire [15:0] csd_do;
wire [14:0] sp_addr;
wire [31:0] sp_do;
wire        ioctl_downl;
wire  [7:0] ioctl_index;
wire        ioctl_wr;
wire [24:0] ioctl_addr;
wire  [7:0] ioctl_dout;
wire  [7:0] steering;
wire  [7:0] gas;

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

// ROM structure:

//  0000 -  DFFF - Main ROM (8 bit)
//  E000 -  FFFF - Super Sound board ROM (8 bit)
// 10000 - 17FFF - CSD ROM (16 bit)
// 18000 -         Sprite ROMs (32 bit)

// spy-hunter_cpu_pg0_2-9-84.6d 
// spy-hunter_cpu_pg1_2-9-84.7d 
// spy-hunter_cpu_pg2_2-9-84.8d 
// spy-hunter_cpu_pg3_2-9-84.9d 
// spy-hunter_cpu_pg4_2-9-84.10d 
// spy-hunter_cpu_pg5_2-9-84.11d

// spy-hunter_snd_0_sd_11-18-83.a7 
// spy-hunter_snd_1_sd_11-18-83.a8

// spy-hunter_cs_deluxe_u17_b_11-18-83.u17 
// spy-hunter_cs_deluxe_u18_d_11-18-83.u18 
// spy-hunter_cs_deluxe_u7_a_11-18-83.u7 
// spy-hunter_cs_deluxe_u8_c_11-18-83.u8

// spy-hunter_video_1fg_11-18-83.a7 
// spy-hunter_video_0fg_11-18-83.a8 
// spy-hunter_video_3fg_11-18-83.a5 
// spy-hunter_video_2fg_11-18-83.a6 
// spy-hunter_video_5fg_11-18-83.a3 
// spy-hunter_video_4fg_11-18-83.a4 
// spy-hunter_video_7fg_11-18-83.a1 
// spy-hunter_video_6fg_11-18-83.a2

wire [24:0] rom_ioctl_addr = ~ioctl_addr[16] ? ioctl_addr : // 8 bit ROMs
                             {ioctl_addr[24:16], ioctl_addr[15], ioctl_addr[13:0], ioctl_addr[14]}; // 16 bit ROM
wire [24:0] sp_ioctl_addr = ioctl_addr - 17'h16000;

reg port1_req, port2_req;
sdram sdram(
	.*,
	.init_n        ( pll_locked   ),
	.clk           ( clk_mem      ),

	// port1 used for main + sound CPUs
	.port1_req     ( port1_req    ),
	.port1_ack     ( ),
	.port1_a       ( rom_ioctl_addr[23:1] ),
	.port1_ds      ( {rom_ioctl_addr[0], ~rom_ioctl_addr[0]} ),
	.port1_we      ( ioctl_downl ),
	.port1_d       ( {ioctl_dout, ioctl_dout} ),
	.port1_q       ( ),

	.cpu1_addr     ( ioctl_downl ? 16'hffff : {1'b0, rom_addr[15:1]} ),
	.cpu1_q        ( rom_do ),
	// need higher priority for CSD
	.cpu2_addr     ( ioctl_downl ? 16'hffff : (16'h7000 + csd_addr[14:1]) ),
	.cpu2_q        ( csd_do ),
	.cpu3_addr     ( 16'hffff ),
	.cpu3_q        ( ),

	// port2 for sprite graphics
	.port2_req     ( port2_req ),
	.port2_ack     ( ),
	.port2_a       ( {sp_ioctl_addr[14:0], sp_ioctl_addr[16]} ), // merge sprite roms to 32-bit wide words
	.port2_ds      ( {sp_ioctl_addr[15], ~sp_ioctl_addr[15]} ),
	.port2_we      ( ioctl_downl ),
	.port2_d       ( {ioctl_dout, ioctl_dout} ),
	.port2_q       ( ),

	.sp_addr       ( ioctl_downl ? 15'h7fff : sp_addr ),
	.sp_q          ( sp_do )
);

// ROM download controller
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

// reset signal generation
reg reset = 1;
reg rom_loaded = 0;
always @(posedge clk_sys) begin
	reg ioctl_downlD;
	reg [15:0] reset_count;
	ioctl_downlD <= ioctl_downl;

	// generate a second reset signal - needed for some reason
	if (status[0] | buttons[1] | ~rom_loaded) reset_count <= 16'hffff;
	else if (reset_count != 0) reset_count <= reset_count - 1'd1;

	if (ioctl_downlD & ~ioctl_downl) rom_loaded <= 1;
	reset <= status[0] | buttons[1] | ~rom_loaded | (reset_count == 16'h0001);

end

turbo_tag_control turbo_tagcontrol(
	.clock_40(clk_sys),
	.reset(reset),
	.vsync(vs),
	.gas_plus(m_up),
	.gas_minus(m_down),
	.steering_plus(m_right),
	.steering_minus(m_left),
	.steering(steering),
	.gas(gas)
  );

turbo_tag turbo_tag(
	.clock_40(clk_sys),
	.reset(reset),
	.video_r(r),
	.video_g(g),
	.video_b(b),
	.video_blankn(blankn),
	.video_hs(hs),
	.video_vs(vs),
	.video_csync(cs),
	.tv15Khz_mode(scandoublerD),
	.separate_audio(1'b0),
	.audio_out_l(audio_l),
	.audio_out_r(audio_r),
	.csd_audio_out(csd_audio),
	.coin1(btn_coin),
	.coin2(1'b0),
	.gas(gas),
	.steering(steering),
	.start1(btn_one_player),
	.start2(btn_two_players),
	.shift(m_fire1),
	.left(m_left),
	.center(btn_fire2),
	.right(m_right),
	.service(status[6]),
	.cpu_rom_addr ( rom_addr        ),
	.cpu_rom_do   ( rom_addr[0] ? rom_do[15:8] : rom_do[7:0] ),
	.csd_rom_addr ( csd_addr        ),
	.csd_rom_do   ( csd_do          ),
	.sp_addr      ( sp_addr         ),
	.sp_graphx32_do ( sp_do         )
);

wire vs_out;
wire hs_out;
assign VGA_VS = scandoublerD | vs_out;
assign VGA_HS = scandoublerD ? cs : hs_out;

mist_video #(.COLOR_DEPTH(3), .SD_HCNT_WIDTH(10)) mist_video(
	.clk_sys        ( clk_sys          ),
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
	.VGA_VS         ( vs_out           ),
	.VGA_HS         ( hs_out           ),
	.rotate         ( {1'b1,status[2]} ),
	.ce_divider     ( 1                ),
	.blend          ( status[5]        ),
	.scandoubler_disable(1),//scandoublerD ),
	.no_csync       ( 1'b1             ),
	.ypbpr          ( ypbpr            )
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
	.C_bits(10))
dac_l(
	.clk_i(clk_sys),
	.res_n_i(1),
	.dac_i(csd_audio),
	.dac_o(AUDIO_L)
	);

dac #(
	.C_bits(10))
dac_r(
	.clk_i(clk_sys),
	.res_n_i(1),
	.dac_i(csd_audio),
	.dac_o(AUDIO_R)
	);	

wire m_up     = ~status[2] ? btn_left  | joystick_0[1] | joystick_1[1] : btn_up    | joystick_0[3] | joystick_1[3];
wire m_down   = ~status[2] ? btn_right | joystick_0[0] | joystick_1[0] : btn_down  | joystick_0[2] | joystick_1[2];
wire m_left   = ~status[2] ? btn_down  | joystick_0[2] | joystick_1[2] : btn_left  | joystick_0[1] | joystick_1[1];
wire m_right  = ~status[2] ? btn_up    | joystick_0[3] | joystick_1[3] : btn_right | joystick_0[0] | joystick_1[0];
wire m_fire1   = btn_fire1 | joystick_0[4] | joystick_1[4];
wire m_fire2   = btn_fire2 | joystick_0[5] | joystick_1[5];
wire m_fire3   = btn_fire3 | joystick_0[6] | joystick_1[6];
wire m_fire4   = btn_fire4 | joystick_0[7] | joystick_1[7];

reg btn_left = 0;
reg btn_right = 0;
reg btn_down = 0;
reg btn_up = 0;
reg btn_fire1 = 0;
reg btn_fire2 = 0;
reg btn_fire3 = 0;
reg btn_fire4 = 0;
reg btn_coin  = 0;
reg btn_one_player  = 0;
reg btn_two_players  = 0;
wire       key_pressed;
wire [7:0] key_code;
wire       key_strobe;

always @(posedge clk_sys) begin
	if(key_strobe) begin
		case(key_code)
			'h75: btn_up          <= key_pressed; // up
			'h72: btn_down        <= key_pressed; // down
			'h6B: btn_left        <= key_pressed; // left
			'h74: btn_right       <= key_pressed; // right
			'h76: btn_coin        <= key_pressed; // ESC
			'h05: btn_one_player  <= key_pressed; // F1
			'h06: btn_two_players <= key_pressed; // F2
			'h12: btn_fire4       <= key_pressed; // shift left
			'h14: btn_fire3       <= key_pressed; // ctrl left
			'h11: btn_fire2       <= key_pressed; // alt left
			'h29: btn_fire1       <= key_pressed; // Space
		endcase
	end
end

endmodule 