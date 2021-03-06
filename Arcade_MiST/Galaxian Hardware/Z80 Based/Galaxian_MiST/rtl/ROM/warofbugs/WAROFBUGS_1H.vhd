-- generated with romgen v3.0 by MikeJ
library ieee;
  use ieee.std_logic_1164.all;
  use ieee.std_logic_unsigned.all;
  use ieee.numeric_std.all;

entity WAROFBUGS_1H is
  port (
    CLK         : in    std_logic;
    ADDR        : in    std_logic_vector(10 downto 0);
    DATA        : out   std_logic_vector(7 downto 0)
    );
end;

architecture RTL of WAROFBUGS_1H is


  type ROM_ARRAY is array(0 to 2047) of std_logic_vector(7 downto 0);
  constant ROM : ROM_ARRAY := (
    x"38",x"7C",x"C2",x"82",x"86",x"7C",x"38",x"00", -- 0x0000
    x"02",x"02",x"FE",x"FE",x"42",x"02",x"00",x"00", -- 0x0008
    x"62",x"F2",x"BA",x"9A",x"9E",x"CE",x"46",x"00", -- 0x0010
    x"8C",x"DE",x"F2",x"B2",x"92",x"86",x"04",x"00", -- 0x0018
    x"08",x"FE",x"FE",x"C8",x"68",x"38",x"18",x"00", -- 0x0020
    x"1C",x"BE",x"A2",x"A2",x"A2",x"E6",x"E4",x"00", -- 0x0028
    x"0C",x"9E",x"92",x"92",x"D2",x"7E",x"3C",x"00", -- 0x0030
    x"C0",x"E0",x"B0",x"9E",x"8E",x"C0",x"C0",x"00", -- 0x0038
    x"0C",x"6E",x"9A",x"9A",x"B2",x"F2",x"6C",x"00", -- 0x0040
    x"78",x"FC",x"96",x"92",x"92",x"F2",x"60",x"00", -- 0x0048
    x"3E",x"7E",x"C8",x"88",x"C8",x"7E",x"3E",x"00", -- 0x0050
    x"6C",x"FE",x"92",x"92",x"92",x"FE",x"FE",x"00", -- 0x0058
    x"44",x"C6",x"82",x"82",x"C6",x"7C",x"38",x"00", -- 0x0060
    x"38",x"7C",x"C6",x"82",x"82",x"FE",x"FE",x"00", -- 0x0068
    x"82",x"92",x"92",x"92",x"FE",x"FE",x"00",x"00", -- 0x0070
    x"80",x"90",x"90",x"90",x"90",x"FE",x"FE",x"00", -- 0x0078
    x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00", -- 0x0080
    x"3E",x"7E",x"C8",x"88",x"C8",x"7E",x"3E",x"00", -- 0x0088
    x"6C",x"FE",x"92",x"92",x"92",x"FE",x"FE",x"00", -- 0x0090
    x"44",x"C6",x"82",x"82",x"C6",x"7C",x"38",x"00", -- 0x0098
    x"38",x"7C",x"C6",x"82",x"82",x"FE",x"FE",x"00", -- 0x00A0
    x"82",x"92",x"92",x"92",x"FE",x"FE",x"00",x"00", -- 0x00A8
    x"80",x"90",x"90",x"90",x"90",x"FE",x"FE",x"00", -- 0x00B0
    x"9E",x"9E",x"92",x"82",x"C6",x"7C",x"38",x"00", -- 0x00B8
    x"FE",x"FE",x"10",x"10",x"10",x"FE",x"FE",x"00", -- 0x00C0
    x"82",x"82",x"FE",x"FE",x"82",x"82",x"00",x"00", -- 0x00C8
    x"FC",x"FE",x"02",x"02",x"02",x"06",x"04",x"00", -- 0x00D0
    x"82",x"C6",x"6E",x"3C",x"18",x"FE",x"FE",x"00", -- 0x00D8
    x"02",x"02",x"02",x"02",x"FE",x"FE",x"00",x"00", -- 0x00E0
    x"FE",x"FE",x"70",x"38",x"70",x"FE",x"FE",x"00", -- 0x00E8
    x"FE",x"FE",x"1C",x"38",x"70",x"FE",x"FE",x"00", -- 0x00F0
    x"7C",x"FE",x"82",x"82",x"82",x"FE",x"7C",x"00", -- 0x00F8
    x"70",x"F8",x"88",x"88",x"88",x"FE",x"FE",x"00", -- 0x0100
    x"7A",x"FC",x"8E",x"8A",x"82",x"FE",x"7C",x"00", -- 0x0108
    x"72",x"F6",x"9E",x"8C",x"88",x"FE",x"FE",x"00", -- 0x0110
    x"0C",x"5E",x"D2",x"92",x"92",x"F6",x"64",x"00", -- 0x0118
    x"80",x"80",x"FE",x"FE",x"80",x"80",x"00",x"00", -- 0x0120
    x"FC",x"FE",x"02",x"02",x"02",x"FE",x"FC",x"00", -- 0x0128
    x"F0",x"F8",x"1C",x"0E",x"1C",x"F8",x"F0",x"00", -- 0x0130
    x"F8",x"FE",x"1C",x"38",x"1C",x"FE",x"F8",x"00", -- 0x0138
    x"C6",x"EE",x"7C",x"38",x"7C",x"EE",x"C6",x"00", -- 0x0140
    x"C0",x"F0",x"1E",x"1E",x"F0",x"C0",x"00",x"00", -- 0x0148
    x"C2",x"E2",x"F2",x"BA",x"9E",x"8E",x"86",x"00", -- 0x0150
    x"3C",x"42",x"81",x"A5",x"A5",x"99",x"42",x"3C", -- 0x0158
    x"38",x"78",x"F8",x"F8",x"F8",x"F8",x"78",x"38", -- 0x0160
    x"00",x"10",x"00",x"2F",x"87",x"20",x"00",x"10", -- 0x0168
    x"38",x"68",x"F8",x"D7",x"7F",x"D8",x"78",x"28", -- 0x0170
    x"38",x"78",x"F8",x"F8",x"F8",x"F8",x"78",x"38", -- 0x0178
    x"38",x"78",x"F8",x"F8",x"F8",x"F8",x"78",x"38", -- 0x0180
    x"00",x"10",x"00",x"2F",x"87",x"20",x"00",x"10", -- 0x0188
    x"38",x"68",x"F8",x"D7",x"7F",x"D8",x"78",x"28", -- 0x0190
    x"38",x"78",x"F8",x"F8",x"F8",x"F8",x"78",x"38", -- 0x0198
    x"00",x"00",x"00",x"03",x"0F",x"1F",x"41",x"00", -- 0x01A0
    x"08",x"3C",x"FE",x"E7",x"8F",x"FE",x"FC",x"00", -- 0x01A8
    x"00",x"41",x"1F",x"0F",x"03",x"00",x"00",x"00", -- 0x01B0
    x"00",x"FC",x"FE",x"8F",x"E7",x"FE",x"3C",x"08", -- 0x01B8
    x"06",x"08",x"03",x"24",x"40",x"10",x"20",x"40", -- 0x01C0
    x"60",x"10",x"00",x"30",x"0A",x"21",x"10",x"00", -- 0x01C8
    x"88",x"A8",x"24",x"08",x"40",x"26",x"10",x"03", -- 0x01D0
    x"15",x"15",x"24",x"80",x"12",x"60",x"04",x"90", -- 0x01D8
    x"00",x"00",x"00",x"00",x"04",x"00",x"08",x"09", -- 0x01E0
    x"00",x"00",x"00",x"00",x"80",x"20",x"80",x"50", -- 0x01E8
    x"00",x"02",x"08",x"04",x"00",x"00",x"00",x"00", -- 0x01F0
    x"90",x"00",x"20",x"40",x"00",x"00",x"00",x"00", -- 0x01F8
    x"00",x"00",x"08",x"08",x"E5",x"15",x"15",x"3A", -- 0x0200
    x"00",x"00",x"80",x"90",x"20",x"4E",x"5F",x"BB", -- 0x0208
    x"3A",x"15",x"15",x"E5",x"08",x"08",x"00",x"00", -- 0x0210
    x"A3",x"5B",x"4E",x"20",x"90",x"80",x"00",x"00", -- 0x0218
    x"00",x"00",x"01",x"22",x"14",x"15",x"15",x"3A", -- 0x0220
    x"00",x"00",x"20",x"48",x"90",x"2E",x"5F",x"BB", -- 0x0228
    x"3A",x"15",x"15",x"14",x"22",x"01",x"00",x"00", -- 0x0230
    x"A3",x"5B",x"2E",x"90",x"48",x"20",x"00",x"00", -- 0x0238
    x"10",x"48",x"2C",x"1C",x"06",x"02",x"00",x"00", -- 0x0240
    x"00",x"02",x"04",x"05",x"8E",x"2C",x"98",x"20", -- 0x0248
    x"00",x"40",x"00",x"00",x"00",x"01",x"00",x"00", -- 0x0250
    x"00",x"40",x"33",x"8C",x"60",x"1E",x"C0",x"38", -- 0x0258
    x"11",x"0A",x"0E",x"04",x"06",x"02",x"00",x"00", -- 0x0260
    x"10",x"14",x"14",x"1C",x"8C",x"28",x"98",x"20", -- 0x0268
    x"00",x"40",x"00",x"00",x"00",x"01",x"00",x"00", -- 0x0270
    x"01",x"42",x"3C",x"81",x"7E",x"00",x"84",x"78", -- 0x0278
    x"00",x"00",x"01",x"01",x"00",x"06",x"06",x"00", -- 0x0280
    x"50",x"90",x"24",x"44",x"18",x"00",x"80",x"40", -- 0x0288
    x"00",x"06",x"06",x"00",x"01",x"01",x"00",x"00", -- 0x0290
    x"40",x"80",x"00",x"18",x"44",x"24",x"90",x"50", -- 0x0298
    x"00",x"06",x"01",x"01",x"00",x"06",x"06",x"00", -- 0x02A0
    x"00",x"00",x"3C",x"40",x"1F",x"00",x"80",x"C0", -- 0x02A8
    x"00",x"06",x"06",x"00",x"01",x"01",x"06",x"00", -- 0x02B0
    x"C0",x"80",x"00",x"1F",x"40",x"38",x"00",x"00", -- 0x02B8
    x"00",x"FF",x"00",x"9F",x"CF",x"9F",x"00",x"FF", -- 0x02C0
    x"FF",x"FF",x"FF",x"C1",x"BE",x"BE",x"80",x"FF", -- 0x02C8
    x"88",x"77",x"00",x"FF",x"80",x"77",x"80",x"FF", -- 0x02D0
    x"BF",x"80",x"BF",x"FF",x"FE",x"FE",x"80",x"FF", -- 0x02D8
    x"FF",x"80",x"77",x"80",x"FF",x"7E",x"00",x"7E", -- 0x02E0
    x"FE",x"80",x"DE",x"FF",x"C9",x"B6",x"B6",x"C9", -- 0x02E8
    x"FF",x"00",x"CF",x"9F",x"00",x"FF",x"7E",x"76", -- 0x02F0
    x"FF",x"C1",x"B6",x"B6",x"CF",x"FE",x"80",x"DE", -- 0x02F8
    x"7C",x"FE",x"CE",x"C0",x"E0",x"FE",x"7E",x"3C", -- 0x0300
    x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00", -- 0x0308
    x"7E",x"FF",x"EF",x"E7",x"7D",x"3C",x"1C",x"08", -- 0x0310
    x"00",x"00",x"00",x"00",x"00",x"80",x"80",x"80", -- 0x0318
    x"7C",x"FE",x"FE",x"C8",x"C0",x"FE",x"7E",x"3C", -- 0x0320
    x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00", -- 0x0328
    x"7E",x"FF",x"9F",x"DD",x"65",x"35",x"1C",x"08", -- 0x0330
    x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00", -- 0x0338
    x"7C",x"FE",x"FE",x"E2",x"C0",x"EE",x"7E",x"3C", -- 0x0340
    x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00", -- 0x0348
    x"7E",x"FF",x"EF",x"ED",x"79",x"38",x"38",x"10", -- 0x0350
    x"00",x"00",x"00",x"00",x"00",x"80",x"40",x"00", -- 0x0358
    x"7C",x"FE",x"FC",x"F0",x"E6",x"CE",x"7E",x"3C", -- 0x0360
    x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00", -- 0x0368
    x"7E",x"FF",x"9F",x"DF",x"65",x"35",x"1C",x"08", -- 0x0370
    x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00", -- 0x0378
    x"7C",x"FE",x"CE",x"C0",x"E0",x"FE",x"7E",x"3C", -- 0x0380
    x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00", -- 0x0388
    x"7C",x"FE",x"CE",x"C0",x"E0",x"FE",x"7E",x"3C", -- 0x0390
    x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00", -- 0x0398
    x"7C",x"FE",x"FE",x"C8",x"C2",x"FE",x"7E",x"3C", -- 0x03A0
    x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00", -- 0x03A8
    x"7C",x"FE",x"FE",x"C8",x"C2",x"FE",x"7E",x"3C", -- 0x03B0
    x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00", -- 0x03B8
    x"7C",x"FE",x"FE",x"E0",x"C2",x"EE",x"7E",x"3C", -- 0x03C0
    x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00", -- 0x03C8
    x"7C",x"FE",x"FE",x"E0",x"C2",x"EE",x"7E",x"3C", -- 0x03D0
    x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00", -- 0x03D8
    x"7C",x"FE",x"FE",x"F0",x"E6",x"CE",x"7E",x"3C", -- 0x03E0
    x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00", -- 0x03E8
    x"7C",x"FE",x"FE",x"F0",x"E6",x"CE",x"7E",x"3C", -- 0x03F0
    x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00", -- 0x03F8
    x"00",x"80",x"40",x"60",x"30",x"38",x"3C",x"3C", -- 0x0400
    x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00", -- 0x0408
    x"7C",x"FE",x"CE",x"C0",x"E0",x"FE",x"7E",x"3C", -- 0x0410
    x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00", -- 0x0418
    x"20",x"30",x"18",x"1C",x"3C",x"3C",x"7C",x"7C", -- 0x0420
    x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00", -- 0x0428
    x"7C",x"FE",x"FE",x"C8",x"C2",x"FE",x"7E",x"3C", -- 0x0430
    x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00", -- 0x0438
    x"00",x"0C",x"1C",x"3C",x"38",x"38",x"78",x"7C", -- 0x0440
    x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00", -- 0x0448
    x"7C",x"FE",x"FE",x"E0",x"C2",x"EE",x"7E",x"3C", -- 0x0450
    x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00", -- 0x0458
    x"00",x"03",x"07",x"0E",x"1E",x"3C",x"3C",x"78", -- 0x0460
    x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00", -- 0x0468
    x"7C",x"FE",x"FE",x"F0",x"E6",x"CE",x"7E",x"3C", -- 0x0470
    x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00", -- 0x0478
    x"00",x"80",x"40",x"60",x"30",x"38",x"3C",x"3C", -- 0x0480
    x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00", -- 0x0488
    x"7E",x"FF",x"EF",x"E5",x"7D",x"3D",x"1C",x"08", -- 0x0490
    x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00", -- 0x0498
    x"20",x"30",x"18",x"1C",x"3C",x"3C",x"7C",x"7C", -- 0x04A0
    x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00", -- 0x04A8
    x"7E",x"FF",x"9F",x"DD",x"65",x"34",x"1C",x"08", -- 0x04B0
    x"00",x"00",x"00",x"00",x"00",x"80",x"40",x"00", -- 0x04B8
    x"00",x"0C",x"1C",x"3C",x"38",x"38",x"78",x"7C", -- 0x04C0
    x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00", -- 0x04C8
    x"7E",x"FF",x"EF",x"E5",x"7C",x"3C",x"1C",x"08", -- 0x04D0
    x"00",x"00",x"00",x"00",x"80",x"40",x"40",x"00", -- 0x04D8
    x"00",x"03",x"07",x"0E",x"1E",x"3C",x"3C",x"78", -- 0x04E0
    x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00", -- 0x04E8
    x"7E",x"FF",x"9F",x"DF",x"65",x"35",x"1D",x"08", -- 0x04F0
    x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00", -- 0x04F8
    x"7E",x"FF",x"EF",x"E7",x"7D",x"3D",x"1C",x"08", -- 0x0500
    x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00", -- 0x0508
    x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00", -- 0x0510
    x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00", -- 0x0518
    x"7E",x"FF",x"EF",x"E7",x"7D",x"3D",x"1C",x"08", -- 0x0520
    x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00", -- 0x0528
    x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00", -- 0x0530
    x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00", -- 0x0538
    x"7E",x"FF",x"EF",x"E7",x"7D",x"3D",x"1C",x"08", -- 0x0540
    x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00", -- 0x0548
    x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00", -- 0x0550
    x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00", -- 0x0558
    x"7E",x"FF",x"EF",x"E7",x"7D",x"3D",x"1C",x"08", -- 0x0560
    x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00", -- 0x0568
    x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00", -- 0x0570
    x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00", -- 0x0578
    x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00", -- 0x0580
    x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00", -- 0x0588
    x"00",x"80",x"40",x"60",x"30",x"38",x"3C",x"3C", -- 0x0590
    x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00", -- 0x0598
    x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00", -- 0x05A0
    x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00", -- 0x05A8
    x"20",x"30",x"18",x"1C",x"3C",x"3C",x"7C",x"7C", -- 0x05B0
    x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00", -- 0x05B8
    x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00", -- 0x05C0
    x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00", -- 0x05C8
    x"00",x"0C",x"1C",x"3C",x"38",x"38",x"78",x"7C", -- 0x05D0
    x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00", -- 0x05D8
    x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00", -- 0x05E0
    x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00", -- 0x05E8
    x"00",x"03",x"07",x"0E",x"1E",x"3C",x"3C",x"78", -- 0x05F0
    x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00", -- 0x05F8
    x"7C",x"FE",x"CE",x"C0",x"E0",x"FE",x"7E",x"7C", -- 0x0600
    x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00", -- 0x0608
    x"7F",x"3F",x"3F",x"1E",x"1C",x"0F",x"0F",x"07", -- 0x0610
    x"C0",x"00",x"E0",x"F0",x"E0",x"C0",x"80",x"00", -- 0x0618
    x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00", -- 0x0620
    x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00", -- 0x0628
    x"3C",x"78",x"71",x"73",x"3F",x"1F",x"0E",x"00", -- 0x0630
    x"7C",x"F0",x"FE",x"EF",x"CE",x"FC",x"F8",x"70", -- 0x0638
    x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00", -- 0x0640
    x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00", -- 0x0648
    x"1C",x"18",x"18",x"1B",x"1F",x"0F",x"03",x"00", -- 0x0650
    x"18",x"7D",x"FD",x"CD",x"DE",x"DC",x"F8",x"70", -- 0x0658
    x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00", -- 0x0660
    x"08",x"1C",x"3D",x"7D",x"E7",x"EF",x"FF",x"7E", -- 0x0668
    x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00", -- 0x0670
    x"7C",x"FE",x"CE",x"C0",x"E0",x"FE",x"7E",x"7C", -- 0x0678
    x"7C",x"FE",x"CE",x"C0",x"E0",x"FE",x"7E",x"3C", -- 0x0680
    x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00", -- 0x0688
    x"3C",x"3E",x"1E",x"1F",x"0F",x"0F",x"07",x"01", -- 0x0690
    x"E0",x"70",x"78",x"F8",x"F8",x"F0",x"E0",x"C0", -- 0x0698
    x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00", -- 0x06A0
    x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00", -- 0x06A8
    x"3C",x"78",x"71",x"73",x"3F",x"1F",x"0E",x"00", -- 0x06B0
    x"18",x"CC",x"CE",x"DE",x"FE",x"FC",x"F8",x"70", -- 0x06B8
    x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00", -- 0x06C0
    x"00",x"00",x"00",x"00",x"00",x"00",x"1C",x"3E", -- 0x06C8
    x"00",x"00",x"03",x"07",x"07",x"07",x"07",x"03", -- 0x06D0
    x"7F",x"FF",x"FF",x"FF",x"FE",x"FC",x"38",x"80", -- 0x06D8
    x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00", -- 0x06E0
    x"00",x"1C",x"3F",x"7F",x"EF",x"E7",x"F3",x"78", -- 0x06E8
    x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00", -- 0x06F0
    x"7C",x"FE",x"CE",x"C0",x"E0",x"FE",x"7E",x"7C", -- 0x06F8
    x"40",x"26",x"19",x"C6",x"39",x"06",x"39",x"C6", -- 0x0700
    x"20",x"40",x"80",x"30",x"C0",x"00",x"C0",x"30", -- 0x0708
    x"00",x"09",x"19",x"00",x"00",x"00",x"00",x"00", -- 0x0710
    x"00",x"00",x"80",x"00",x"00",x"00",x"00",x"00", -- 0x0718
    x"40",x"26",x"19",x"C6",x"39",x"06",x"39",x"C6", -- 0x0720
    x"20",x"40",x"80",x"30",x"C0",x"00",x"C0",x"30", -- 0x0728
    x"00",x"09",x"19",x"00",x"00",x"00",x"00",x"00", -- 0x0730
    x"00",x"00",x"80",x"00",x"00",x"00",x"00",x"00", -- 0x0738
    x"46",x"2F",x"1F",x"CF",x"3F",x"0F",x"3F",x"C6", -- 0x0740
    x"20",x"40",x"80",x"30",x"C0",x"00",x"C0",x"30", -- 0x0748
    x"00",x"09",x"19",x"00",x"00",x"00",x"00",x"00", -- 0x0750
    x"00",x"00",x"80",x"00",x"00",x"00",x"00",x"00", -- 0x0758
    x"40",x"26",x"19",x"C6",x"39",x"06",x"39",x"C6", -- 0x0760
    x"20",x"40",x"80",x"30",x"C0",x"00",x"C0",x"30", -- 0x0768
    x"00",x"09",x"19",x"00",x"00",x"00",x"00",x"00", -- 0x0770
    x"00",x"00",x"80",x"00",x"00",x"00",x"00",x"00", -- 0x0778
    x"09",x"17",x"3C",x"1B",x"3F",x"EF",x"DF",x"BF", -- 0x0780
    x"80",x"E0",x"F8",x"CC",x"F4",x"DE",x"EF",x"FF", -- 0x0788
    x"77",x"57",x"DB",x"77",x"3F",x"19",x"0F",x"04", -- 0x0790
    x"EA",x"EA",x"DB",x"7E",x"EC",x"9C",x"F8",x"40", -- 0x0798
    x"03",x"07",x"1F",x"1F",x"3B",x"3F",x"37",x"36", -- 0x07A0
    x"C0",x"E0",x"F0",x"F8",x"7C",x"DC",x"7C",x"AC", -- 0x07A8
    x"3F",x"3D",x"37",x"1B",x"1F",x"1F",x"0F",x"07", -- 0x07B0
    x"6C",x"FC",x"DC",x"BC",x"F8",x"F8",x"F0",x"E0", -- 0x07B8
    x"24",x"94",x"4C",x"FF",x"FF",x"4C",x"94",x"24", -- 0x07C0
    x"24",x"94",x"4C",x"FF",x"FF",x"4C",x"94",x"24", -- 0x07C8
    x"24",x"94",x"4C",x"FF",x"FF",x"4C",x"94",x"24", -- 0x07D0
    x"24",x"94",x"4C",x"FF",x"FF",x"4C",x"94",x"24", -- 0x07D8
    x"1E",x"3F",x"7E",x"00",x"00",x"7E",x"3F",x"1E", -- 0x07E0
    x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00", -- 0x07E8
    x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00", -- 0x07F0
    x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00"  -- 0x07F8
  );

begin

  p_rom : process
  begin
    wait until rising_edge(CLK);
       DATA <= ROM(to_integer(unsigned(ADDR)));
  end process;
end RTL;
