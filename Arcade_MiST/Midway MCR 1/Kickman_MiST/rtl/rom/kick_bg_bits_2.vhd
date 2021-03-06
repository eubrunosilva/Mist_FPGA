library ieee;
use ieee.std_logic_1164.all,ieee.numeric_std.all;

entity kick_bg_bits_2 is
port (
	clk  : in  std_logic;
	addr : in  std_logic_vector(11 downto 0);
	data : out std_logic_vector(7 downto 0)
);
end entity;

architecture prom of kick_bg_bits_2 is
	type rom is array(0 to  4095) of std_logic_vector(7 downto 0);
	signal rom_data: rom := (
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"0A",X"00",X"02",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"AA",X"00",X"AA",X"00",X"AA",X"00",X"AA",X"00",X"AA",X"00",X"AA",X"00",X"AA",X"00",X"AA",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"55",X"55",X"55",X"55",X"55",X"55",X"55",X"55",X"55",X"55",X"00",X"00",X"55",X"55",X"55",X"55",
		X"55",X"55",X"55",X"55",X"55",X"55",X"55",X"55",X"55",X"55",X"55",X"55",X"55",X"55",X"00",X"00",
		X"55",X"55",X"55",X"55",X"00",X"00",X"55",X"55",X"55",X"55",X"55",X"55",X"55",X"55",X"55",X"55",
		X"45",X"54",X"45",X"54",X"45",X"54",X"45",X"54",X"45",X"54",X"40",X"00",X"55",X"55",X"55",X"55",
		X"45",X"54",X"45",X"54",X"45",X"54",X"45",X"54",X"45",X"54",X"45",X"54",X"45",X"54",X"40",X"00",
		X"00",X"00",X"00",X"00",X"55",X"54",X"55",X"54",X"55",X"54",X"55",X"54",X"55",X"54",X"55",X"54",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"55",X"50",X"55",X"54",X"55",X"55",X"55",X"55",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"55",X"55",X"55",X"55",X"55",X"55",X"55",X"55",X"55",X"55",X"55",X"55",X"55",X"55",X"55",X"55",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"55",X"55",X"55",X"55",X"55",X"55",X"55",X"55",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"0A",X"A0",X"08",X"00",X"0A",X"A0",X"08",X"00",X"0A",X"A0",X"00",X"00",X"0A",X"A0",
		X"00",X"00",X"0A",X"A0",X"08",X"20",X"08",X"20",X"02",X"80",X"00",X"00",X"0A",X"A0",X"00",X"20",
		X"0A",X"A0",X"00",X"20",X"0A",X"A0",X"00",X"00",X"0A",X"A0",X"08",X"80",X"0A",X"A0",X"00",X"00",
		X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"A9",X"AA",X"A5",X"AA",X"A5",X"AA",X"95",X"AA",X"95",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"0C",X"00",X"0F",X"00",X"03",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"03",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"0C",X"00",X"0C",X"00",X"0F",X"00",X"0F",X"00",X"0F",X"C0",X"0F",X"C0",X"03",X"F0",X"03",X"FC",
		X"03",X"FF",X"00",X"FF",X"00",X"FF",X"00",X"3F",X"00",X"0F",X"00",X"03",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"03",X"00",X"00",X"00",X"00",X"0C",X"00",X"00",X"00",X"00",X"0C",
		X"55",X"5A",X"55",X"5A",X"55",X"56",X"55",X"55",X"55",X"55",X"55",X"55",X"55",X"55",X"55",X"55",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"40",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"40",X"04",X"C0",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"40",X"04",X"C0",X"0C",X"C0",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"40",X"04",X"C0",X"0C",X"C0",X"0C",X"C0",X"00",X"00",
		X"00",X"00",X"00",X"40",X"04",X"C0",X"0C",X"C0",X"0C",X"C0",X"0C",X"C0",X"3F",X"FF",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"03",X"55",X"00",X"00",
		X"00",X"00",X"04",X"C0",X"0C",X"C0",X"0C",X"C0",X"0C",X"C0",X"3F",X"FF",X"7F",X"FF",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"0D",X"54",X"0D",X"14",X"0D",X"55",X"00",X"00",
		X"00",X"00",X"05",X"55",X"05",X"55",X"04",X"01",X"04",X"01",X"05",X"55",X"05",X"55",X"00",X"00",
		X"00",X"00",X"04",X"01",X"04",X"01",X"05",X"55",X"05",X"55",X"00",X"01",X"00",X"01",X"00",X"00",
		X"00",X"00",X"04",X"55",X"04",X"55",X"04",X"41",X"04",X"41",X"05",X"41",X"05",X"41",X"00",X"00",
		X"00",X"00",X"04",X"41",X"04",X"41",X"04",X"41",X"04",X"41",X"05",X"55",X"05",X"55",X"00",X"00",
		X"00",X"00",X"01",X"50",X"01",X"50",X"00",X"10",X"00",X"10",X"05",X"55",X"05",X"55",X"00",X"00",
		X"00",X"00",X"05",X"41",X"04",X"41",X"04",X"41",X"04",X"41",X"04",X"55",X"04",X"55",X"00",X"00",
		X"00",X"00",X"05",X"55",X"05",X"55",X"04",X"11",X"04",X"11",X"04",X"15",X"04",X"15",X"00",X"00",
		X"00",X"00",X"00",X"00",X"05",X"00",X"04",X"00",X"04",X"00",X"05",X"55",X"05",X"55",X"00",X"00",
		X"00",X"00",X"05",X"55",X"05",X"55",X"04",X"41",X"04",X"41",X"05",X"55",X"05",X"55",X"00",X"00",
		X"00",X"00",X"05",X"51",X"05",X"51",X"04",X"11",X"04",X"11",X"05",X"55",X"05",X"55",X"00",X"00",
		X"00",X"00",X"0C",X"C0",X"0C",X"C0",X"3F",X"FF",X"3F",X"FF",X"7F",X"FF",X"7F",X"FF",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"40",X"04",X"C0",X"0C",X"C0",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"03",X"55",X"03",X"45",X"03",X"55",X"03",X"55",X"00",X"00",
		X"00",X"00",X"3F",X"FF",X"7F",X"FF",X"7F",X"FF",X"7F",X"FF",X"3F",X"FF",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"40",X"04",X"C0",X"0C",X"C0",X"0C",X"C0",X"00",X"00",
		X"00",X"00",X"00",X"00",X"03",X"55",X"03",X"45",X"03",X"55",X"03",X"55",X"03",X"FF",X"00",X"00",
		X"00",X"00",X"7F",X"FF",X"7F",X"FF",X"7F",X"FF",X"3F",X"FF",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"05",X"55",X"05",X"55",X"04",X"10",X"04",X"10",X"05",X"55",X"05",X"55",X"00",X"00",
		X"00",X"00",X"05",X"55",X"05",X"55",X"05",X"11",X"05",X"11",X"05",X"55",X"00",X"15",X"00",X"00",
		X"00",X"00",X"05",X"55",X"05",X"55",X"04",X"01",X"04",X"01",X"04",X"01",X"04",X"01",X"00",X"00",
		X"00",X"00",X"05",X"55",X"05",X"55",X"04",X"01",X"05",X"05",X"05",X"55",X"01",X"54",X"00",X"00",
		X"00",X"00",X"05",X"55",X"05",X"55",X"04",X"41",X"04",X"41",X"04",X"41",X"04",X"01",X"00",X"00",
		X"00",X"00",X"05",X"55",X"05",X"55",X"04",X"10",X"04",X"10",X"04",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"05",X"55",X"05",X"55",X"04",X"01",X"04",X"01",X"04",X"15",X"04",X"15",X"00",X"00",
		X"00",X"00",X"05",X"55",X"05",X"55",X"00",X"10",X"00",X"10",X"05",X"55",X"05",X"55",X"00",X"00",
		X"00",X"00",X"04",X"01",X"04",X"01",X"05",X"55",X"05",X"55",X"04",X"01",X"04",X"01",X"00",X"00",
		X"00",X"00",X"00",X"15",X"00",X"15",X"04",X"01",X"04",X"01",X"05",X"55",X"05",X"55",X"04",X"00",
		X"00",X"00",X"05",X"55",X"05",X"55",X"01",X"50",X"05",X"14",X"04",X"05",X"04",X"01",X"00",X"00",
		X"00",X"00",X"05",X"55",X"05",X"55",X"00",X"01",X"00",X"01",X"00",X"05",X"00",X"05",X"00",X"00",
		X"00",X"00",X"05",X"55",X"05",X"55",X"04",X"00",X"05",X"55",X"04",X"00",X"05",X"55",X"00",X"00",
		X"00",X"00",X"05",X"55",X"05",X"55",X"01",X"40",X"00",X"54",X"05",X"55",X"05",X"55",X"00",X"00",
		X"00",X"00",X"05",X"55",X"05",X"55",X"04",X"01",X"04",X"01",X"05",X"55",X"05",X"55",X"00",X"00",
		X"00",X"00",X"05",X"55",X"05",X"55",X"04",X"10",X"04",X"10",X"05",X"50",X"05",X"50",X"00",X"00",
		X"00",X"00",X"05",X"55",X"05",X"55",X"04",X"01",X"04",X"05",X"05",X"55",X"05",X"55",X"00",X"00",
		X"00",X"00",X"05",X"55",X"05",X"55",X"04",X"40",X"04",X"50",X"05",X"55",X"05",X"45",X"00",X"00",
		X"00",X"00",X"05",X"41",X"04",X"41",X"04",X"41",X"04",X"55",X"04",X"55",X"00",X"00",X"00",X"00",
		X"00",X"00",X"05",X"00",X"04",X"01",X"05",X"55",X"05",X"55",X"04",X"01",X"05",X"00",X"00",X"00",
		X"00",X"00",X"05",X"55",X"05",X"55",X"00",X"01",X"00",X"01",X"05",X"55",X"05",X"55",X"00",X"00",
		X"00",X"00",X"04",X"00",X"05",X"50",X"05",X"55",X"00",X"15",X"05",X"50",X"04",X"00",X"00",X"00",
		X"00",X"00",X"05",X"55",X"05",X"55",X"00",X"01",X"05",X"55",X"00",X"01",X"05",X"55",X"00",X"00",
		X"00",X"00",X"04",X"01",X"05",X"15",X"00",X"50",X"05",X"40",X"05",X"10",X"04",X"05",X"00",X"00",
		X"00",X"00",X"04",X"00",X"05",X"40",X"01",X"55",X"00",X"55",X"05",X"00",X"04",X"00",X"00",X"00",
		X"00",X"00",X"04",X"05",X"04",X"15",X"04",X"51",X"05",X"41",X"05",X"01",X"04",X"01",X"00",X"00",
		X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",
		X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",
		X"00",X"00",X"00",X"01",X"00",X"05",X"00",X"05",X"00",X"15",X"00",X"55",X"00",X"AA",X"00",X"AA",
		X"00",X"00",X"00",X"01",X"00",X"05",X"00",X"05",X"00",X"15",X"00",X"55",X"00",X"AA",X"00",X"AA",
		X"55",X"55",X"55",X"55",X"55",X"55",X"55",X"55",X"55",X"55",X"55",X"55",X"AA",X"AA",X"AA",X"AA",
		X"AA",X"AA",X"AA",X"AA",X"6A",X"AA",X"6A",X"AA",X"5A",X"AA",X"5A",X"AA",X"AA",X"AA",X"AA",X"AA",
		X"00",X"2A",X"00",X"2A",X"00",X"2A",X"00",X"2A",X"00",X"2A",X"00",X"2A",X"00",X"2A",X"00",X"2A",
		X"00",X"AA",X"00",X"AA",X"00",X"AA",X"00",X"AA",X"00",X"AA",X"00",X"AA",X"00",X"AA",X"00",X"AA",
		X"AA",X"55",X"A9",X"55",X"A9",X"55",X"A5",X"55",X"95",X"55",X"95",X"55",X"55",X"55",X"55",X"55",
		X"00",X"00",X"00",X"40",X"04",X"C0",X"0C",X"C0",X"0C",X"C0",X"0C",X"C0",X"3F",X"FF",X"00",X"00",
		X"00",X"00",X"03",X"55",X"03",X"55",X"03",X"55",X"03",X"FF",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"04",X"C0",X"0C",X"C0",X"3F",X"FF",X"7F",X"FF",X"7F",X"FF",X"7F",X"FF",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"03",X"55",X"03",X"45",X"03",X"55",X"03",X"55",X"00",X"00",
		X"00",X"00",X"0C",X"C0",X"3F",X"FF",X"7F",X"FF",X"7F",X"FF",X"3F",X"FF",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"03",X"55",X"03",X"45",X"03",X"55",X"03",X"55",X"03",X"FF",X"00",X"00",
		X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"6A",X"AA",X"6A",X"AA",X"5A",X"AA",
		X"00",X"00",X"7F",X"FF",X"7F",X"FF",X"3F",X"FF",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"D5",X"00",X"D5",X"00",X"FF",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"FF",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"56",X"AA",X"55",X"AA",X"55",X"AA",X"55",X"6A",X"55",X"5A",X"55",X"5A",X"55",X"56",X"55",X"55",
		X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"6A",X"00",X"00",
		X"AA",X"AA",X"AA",X"9A",X"A9",X"BA",X"AB",X"BA",X"AB",X"BA",X"BF",X"FF",X"7F",X"FF",X"00",X"00",
		X"AA",X"AA",X"AA",X"AA",X"55",X"80",X"45",X"40",X"55",X"40",X"55",X"80",X"FF",X"AA",X"00",X"00",
		X"AA",X"AA",X"A9",X"AA",X"D5",X"6F",X"D1",X"5F",X"D5",X"5F",X"D5",X"6F",X"FF",X"EA",X"AA",X"AA",
		X"AA",X"AA",X"AA",X"AA",X"AA",X"B5",X"AA",X"B4",X"AA",X"B5",X"AA",X"B5",X"AA",X"BF",X"AA",X"AA",
		X"AA",X"AA",X"AA",X"AA",X"AA",X"AD",X"AA",X"AD",X"AA",X"AD",X"AA",X"AD",X"AA",X"AF",X"AA",X"AA",
		X"00",X"10",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"0C",X"C0",X"04",X"C0",X"00",X"40",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"0C",X"C0",X"0C",X"C0",X"0C",X"C0",X"04",X"C0",X"00",X"40",X"00",X"00",X"00",X"00",X"00",X"00",
		X"7F",X"FF",X"3F",X"FF",X"0C",X"C0",X"0C",X"C0",X"0C",X"C0",X"04",X"C0",X"00",X"40",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"7F",X"FF",X"7F",X"FF",X"3F",X"FF",X"0C",X"C0",X"0C",X"C0",X"0C",X"C0",X"04",X"C0",X"00",X"40",
		X"0D",X"55",X"0D",X"55",X"0D",X"14",X"0D",X"54",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"3F",X"FF",X"7F",X"FF",X"7F",X"FF",X"3F",X"FF",X"3F",X"FF",X"0C",X"C0",X"0C",X"C0",X"04",X"C0",
		X"03",X"55",X"03",X"55",X"03",X"55",X"03",X"45",X"03",X"55",X"00",X"00",X"00",X"00",X"00",X"00",
		X"0C",X"C0",X"0C",X"C0",X"04",X"C0",X"00",X"40",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"3F",X"FF",X"7F",X"FF",X"7F",X"FF",X"7F",X"FF",X"3F",X"FF",X"00",X"00",X"00",X"00",
		X"0C",X"C0",X"0C",X"C0",X"0C",X"C0",X"04",X"C0",X"00",X"40",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"03",X"FF",X"03",X"55",X"03",X"55",X"03",X"45",X"03",X"55",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"3F",X"FF",X"7F",X"FF",X"7F",X"FF",X"7F",X"FF",X"3F",X"FF",
		X"7F",X"FF",X"3F",X"FF",X"0C",X"C0",X"0C",X"C0",X"0C",X"C0",X"04",X"C0",X"00",X"40",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"03",X"FF",X"03",X"55",X"03",X"55",X"03",X"55",X"03",X"55",
		X"03",X"45",X"03",X"55",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"3F",X"FF",X"7F",X"FF",X"7F",X"FF",X"7F",X"FF",X"3F",X"FF",X"0C",X"C0",X"04",X"C0",X"00",X"40",
		X"03",X"FF",X"03",X"55",X"03",X"55",X"03",X"45",X"03",X"55",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"3F",X"FF",X"7F",X"FF",X"7F",X"FF",X"7F",X"FF",X"3F",X"FF",X"0C",X"C0",X"0C",X"C0",
		X"00",X"00",X"03",X"FF",X"03",X"55",X"03",X"55",X"03",X"45",X"03",X"55",X"00",X"00",X"00",X"00",
		X"00",X"00",X"FF",X"C0",X"D5",X"4F",X"D5",X"5F",X"D1",X"5F",X"D5",X"4F",X"00",X"00",X"00",X"00",
		X"00",X"00",X"FF",X"C0",X"D5",X"4F",X"D5",X"5F",X"D1",X"5F",X"D5",X"4F",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"3F",X"00",X"35",X"00",X"35",X"00",X"34",X"00",X"35",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"0F",X"00",X"0D",X"00",X"0D",X"00",X"0D",X"00",X"0D",X"00",X"00",X"00",X"00",
		X"00",X"00",X"0A",X"00",X"00",X"A0",X"00",X"A0",X"0A",X"00",X"00",X"00",X"00",X"00",X"AA",X"AA",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"03",X"00",X"03",X"00",X"0F",X"00",X"3F",
		X"0F",X"FF",X"3F",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",
		X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FD",X"55",X"FD",X"55",X"F5",X"55",X"D5",X"55",
		X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"55",X"55",X"55",X"55",X"55",X"55",X"55",X"55",
		X"AA",X"AA",X"AA",X"AA",X"EA",X"AA",X"EA",X"AA",X"5A",X"AA",X"56",X"AA",X"55",X"AA",X"55",X"6A",
		X"00",X"00",X"00",X"00",X"00",X"03",X"00",X"0F",X"00",X"3F",X"00",X"3F",X"00",X"FF",X"03",X"FF",
		X"00",X"03",X"00",X"0F",X"00",X"3F",X"00",X"FF",X"00",X"FF",X"03",X"FF",X"0F",X"FF",X"3F",X"FF",
		X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"EA",X"AA",X"FA",X"AA",
		X"FE",X"AA",X"FE",X"AA",X"FF",X"AA",X"FF",X"AA",X"FF",X"EA",X"FF",X"FA",X"FF",X"FE",X"FF",X"FE",
		X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",
		X"00",X"0A",X"00",X"0A",X"00",X"2A",X"00",X"AA",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"0F",X"FF",X"3F",X"FF",X"FF",X"FF",X"FF",X"FF",
		X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"FA",X"AA",X"FE",X"AA",X"FF",X"AA",X"FF",X"AA",
		X"02",X"AA",X"0A",X"AA",X"2A",X"AA",X"2A",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",
		X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",
		X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",
		X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",
		X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",
		X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",
		X"00",X"0A",X"00",X"0A",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",
		X"00",X"00",X"00",X"00",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",
		X"00",X"00",X"00",X"00",X"00",X"0A",X"00",X"0A",X"00",X"2A",X"00",X"AA",X"00",X"AA",X"02",X"AA",
		X"00",X"02",X"00",X"02",X"00",X"02",X"00",X"0A",X"00",X"0A",X"00",X"0A",X"00",X"0A",X"00",X"0A",
		X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",
		X"FE",X"AA",X"FF",X"AA",X"FF",X"EA",X"FF",X"EA",X"3F",X"FA",X"00",X"FA",X"FF",X"FF",X"3F",X"FF",
		X"00",X"02",X"00",X"02",X"0A",X"AA",X"2A",X"AA",X"2A",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",
		X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",
		X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",
		X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"EA",X"AA",X"FA",X"AA",X"FA",X"AA",
		X"03",X"FF",X"03",X"FF",X"03",X"FF",X"00",X"FF",X"00",X"FF",X"00",X"3F",X"00",X"3F",X"00",X"3F",
		X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",
		X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",
		X"FF",X"EA",X"FF",X"EA",X"FF",X"FA",X"FF",X"FE",X"FF",X"FE",X"00",X"3F",X"3F",X"FF",X"3F",X"FF",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"2A",X"00",X"AA",X"00",X"AA",X"02",X"AA",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",
		X"AA",X"AA",X"EA",X"AA",X"FA",X"AA",X"FA",X"AA",X"FE",X"AA",X"FF",X"AA",X"FF",X"AA",X"FF",X"EA",
		X"0F",X"FF",X"0F",X"FF",X"0F",X"FF",X"0F",X"FF",X"3F",X"FF",X"3F",X"FF",X"3F",X"FF",X"3F",X"FF",
		X"FA",X"AA",X"FE",X"AA",X"FF",X"AA",X"3F",X"EA",X"FF",X"EA",X"FF",X"FA",X"03",X"FA",X"FF",X"FF",
		X"00",X"FF",X"00",X"FF",X"00",X"FF",X"00",X"FF",X"03",X"FF",X"03",X"FF",X"03",X"FF",X"03",X"FF",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"3F",X"00",X"3F",X"00",X"3F",X"00",X"3F",X"00",X"FF",
		X"FF",X"AA",X"FF",X"EA",X"C3",X"FA",X"FF",X"FE",X"FF",X"FE",X"F3",X"FE",X"FC",X"0F",X"FC",X"FF",
		X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"FA",X"AA",X"FA",X"AA",X"FE",X"AA",
		X"55",X"55",X"15",X"55",X"05",X"55",X"01",X"55",X"00",X"55",X"00",X"15",X"00",X"05",X"00",X"01",
		X"55",X"55",X"55",X"56",X"55",X"6A",X"55",X"AA",X"5A",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",
		X"55",X"55",X"55",X"55",X"55",X"55",X"55",X"55",X"55",X"55",X"55",X"55",X"55",X"56",X"55",X"6A",
		X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",
		X"2A",X"AA",X"2A",X"AA",X"2A",X"AA",X"2A",X"AA",X"2A",X"AA",X"2A",X"AA",X"2A",X"AA",X"2A",X"AA",
		X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",
		X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",
		X"FF",X"AA",X"FE",X"AA",X"FA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",
		X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FE",X"FF",X"EA",X"FE",X"AA",X"FA",X"AA",
		X"3F",X"FF",X"0F",X"FF",X"03",X"FF",X"AB",X"FF",X"AA",X"FF",X"AA",X"BF",X"AA",X"AF",X"AA",X"AB",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"AA",X"00",X"AA",X"00",X"AA",X"00",X"AA",X"00",X"AA",
		X"00",X"AA",X"00",X"AA",X"00",X"AA",X"00",X"2A",X"00",X"02",X"00",X"00",X"00",X"00",X"00",X"00",
		X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"2A",X"AA",X"00",X"00",X"00",X"00",
		X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"00",X"AA",X"00",X"AA",
		X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",
		X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",
		X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",
		X"AA",X"AA",X"AA",X"AA",X"FF",X"AA",X"FE",X"AA",X"EA",X"AA",X"EA",X"AA",X"EA",X"AA",X"EA",X"AA",
		X"AA",X"AA",X"AA",X"AA",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"00",X"00",X"00",X"00",
		X"00",X"AA",X"00",X"AA",X"00",X"FF",X"00",X"3F",X"00",X"0F",X"00",X"03",X"00",X"00",X"00",X"00",
		X"FF",X"EA",X"FF",X"FA",X"FF",X"FE",X"FF",X"FE",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",
		X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",
		X"FE",X"CE",X"CE",X"CE",X"CF",X"CE",X"CC",X"CF",X"FC",X"CE",X"EC",X"FE",X"EF",X"EE",X"EC",X"EE",
		X"AA",X"FE",X"AA",X"CE",X"AA",X"CE",X"AA",X"CF",X"AA",X"CE",X"AA",X"FE",X"AA",X"EE",X"AA",X"EF",
		X"00",X"00",X"00",X"14",X"14",X"41",X"15",X"51",X"14",X"41",X"04",X"41",X"00",X"14",X"00",X"00",
		X"00",X"00",X"00",X"00",X"04",X"51",X"04",X"40",X"04",X"40",X"05",X"40",X"00",X"00",X"00",X"00",
		X"55",X"55",X"40",X"01",X"41",X"41",X"44",X"11",X"44",X"11",X"44",X"11",X"40",X"01",X"55",X"55",
		X"0F",X"FF",X"0F",X"FF",X"0F",X"FF",X"03",X"FF",X"03",X"FF",X"00",X"FF",X"00",X"3F",X"00",X"03",
		X"00",X"03",X"00",X"3F",X"00",X"FF",X"03",X"FF",X"03",X"FF",X"0F",X"FF",X"0F",X"FF",X"0F",X"FF",
		X"FF",X"F0",X"FF",X"F0",X"FF",X"F0",X"FF",X"C0",X"FF",X"C0",X"FF",X"00",X"FC",X"00",X"C0",X"00",
		X"C0",X"00",X"FC",X"00",X"FF",X"00",X"FF",X"C0",X"FF",X"C0",X"FF",X"F0",X"FF",X"F0",X"FF",X"F0",
		X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",
		X"CF",X"FF",X"3F",X"FF",X"F3",X"FC",X"F3",X"F3",X"C3",X"FF",X"CF",X"FF",X"FF",X"FF",X"FF",X"FF",
		X"FC",X"FF",X"FF",X"0F",X"FF",X"CF",X"FF",X"F0",X"FF",X"FF",X"00",X"00",X"FC",X"FC",X"F3",X"FF",
		X"FF",X"FF",X"FF",X"FF",X"FF",X"00",X"FF",X"3F",X"FF",X"3F",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",
		X"FF",X"CF",X"FF",X"3F",X"FF",X"30",X"FF",X"3F",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",
		X"FC",X"00",X"FF",X"FF",X"0C",X"FF",X"3F",X"3F",X"FF",X"CF",X"F0",X"00",X"FF",X"FF",X"FF",X"FC",
		X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"03",X"FF",X"C0",X"0F",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",
		X"FF",X"FF",X"FC",X"FF",X"FF",X"3F",X"FF",X"00",X"FF",X"FF",X"FF",X"FF",X"FF",X"FC",X"FF",X"C3",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"0C",X"00",X"0C",X"00",X"0C",X"FF",X"FC",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"0C",X"00",X"0C",X"00",X"0C",X"00",X"0C",X"00",X"0C",X"00",X"0C",X"00",X"0C",X"00",X"0C",
		X"00",X"0C",X"00",X"0C",X"00",X"0C",X"FF",X"FC",X"00",X"0C",X"00",X"0C",X"00",X"0C",X"00",X"0C",
		X"00",X"00",X"00",X"00",X"00",X"00",X"FF",X"FC",X"00",X"0C",X"00",X"0C",X"00",X"0C",X"00",X"0C",
		X"00",X"00",X"00",X"00",X"00",X"00",X"FF",X"FF",X"F0",X"00",X"F0",X"00",X"F0",X"00",X"F0",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"3F",X"FF",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"C0",X"00",X"C0",X"00",X"C0",X"00",X"C0",X"00",X"C0",X"00",X"C0",X"00",X"C0",X"00",X"C0",X"00",
		X"C0",X"00",X"C0",X"00",X"C0",X"00",X"FF",X"FF",X"C0",X"0C",X"C0",X"0C",X"C0",X"0C",X"C0",X"0C",
		X"C0",X"00",X"C0",X"00",X"C0",X"00",X"FF",X"FF",X"00",X"0C",X"00",X"0C",X"00",X"0C",X"00",X"0C",
		X"30",X"00",X"30",X"00",X"30",X"00",X"3F",X"FF",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"30",X"00",X"30",X"00",X"30",X"00",X"30",X"00",X"30",X"00",X"30",X"00",X"30",X"00",X"30",X"00",
		X"30",X"00",X"30",X"00",X"30",X"00",X"3F",X"FF",X"30",X"00",X"30",X"00",X"30",X"00",X"30",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"3F",X"FF",X"30",X"00",X"30",X"00",X"30",X"00",X"30",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"55",X"55",X"55",X"55",X"55",X"55",X"55",X"55",X"55",X"55",X"55",X"55",X"55",X"55",X"55",X"55",
		X"55",X"55",X"55",X"55",X"55",X"55",X"55",X"55",X"55",X"55",X"55",X"55",X"55",X"55",X"55",X"55",
		X"55",X"55",X"55",X"55",X"55",X"55",X"55",X"55",X"55",X"55",X"55",X"55",X"55",X"55",X"55",X"55",
		X"55",X"55",X"55",X"55",X"55",X"55",X"55",X"55",X"55",X"55",X"55",X"55",X"55",X"55",X"55",X"55",
		X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",
		X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",
		X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",
		X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",
		X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",
		X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",
		X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",
		X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF");
begin
process(clk)
begin
	if rising_edge(clk) then
		data <= rom_data(to_integer(unsigned(addr)));
	end if;
end process;
end architecture;
