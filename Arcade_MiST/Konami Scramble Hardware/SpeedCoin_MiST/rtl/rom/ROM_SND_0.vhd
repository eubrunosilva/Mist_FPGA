library ieee;
use ieee.std_logic_1164.all,ieee.numeric_std.all;

entity ROM_SND_0 is
port (
	clk  : in  std_logic;
	addr : in  std_logic_vector(10 downto 0);
	data : out std_logic_vector(7 downto 0)
);
end entity;

architecture prom of ROM_SND_0 is
	type rom is array(0 to  2047) of std_logic_vector(7 downto 0);
	signal rom_data: rom := (
		X"00",X"F3",X"31",X"00",X"81",X"C3",X"40",X"00",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",
		X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",
		X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",
		X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"C3",X"54",X"05",X"FF",X"FF",X"FF",X"FF",X"FF",
		X"0E",X"10",X"CD",X"6C",X"03",X"0E",X"40",X"CD",X"6C",X"03",X"0E",X"10",X"CD",X"6C",X"03",X"0E",
		X"40",X"CD",X"6C",X"03",X"CD",X"04",X"01",X"21",X"00",X"80",X"01",X"00",X"04",X"36",X"00",X"23",
		X"0D",X"20",X"FA",X"10",X"F8",X"3E",X"3F",X"32",X"2A",X"81",X"32",X"38",X"81",X"CD",X"12",X"01",
		X"01",X"00",X"00",X"ED",X"56",X"FB",X"ED",X"5B",X"01",X"81",X"7A",X"B3",X"28",X"13",X"F3",X"ED",
		X"4B",X"01",X"81",X"11",X"00",X"00",X"ED",X"53",X"01",X"81",X"31",X"00",X"81",X"CD",X"4D",X"03",
		X"FB",X"0A",X"03",X"26",X"00",X"87",X"6F",X"11",X"A0",X"00",X"19",X"7E",X"23",X"66",X"6F",X"E9",
		X"D9",X"01",X"EB",X"01",X"0B",X"02",X"20",X"02",X"2D",X"02",X"37",X"02",X"43",X"02",X"50",X"02",
		X"62",X"02",X"6C",X"02",X"78",X"02",X"87",X"02",X"A1",X"02",X"B2",X"02",X"C8",X"02",X"DC",X"02",
		X"E2",X"02",X"EE",X"02",X"01",X"03",X"10",X"03",X"35",X"03",X"41",X"03",X"45",X"03",X"FB",X"01",
		X"3C",X"01",X"4B",X"01",X"54",X"01",X"88",X"01",X"8D",X"01",X"AB",X"01",X"B0",X"01",X"BF",X"01",
		X"C4",X"01",X"17",X"02",X"A3",X"03",X"21",X"44",X"81",X"06",X"06",X"11",X"00",X"00",X"CB",X"23",
		X"CB",X"12",X"CB",X"23",X"CB",X"12",X"7E",X"E6",X"03",X"B3",X"5F",X"2B",X"10",X"F0",X"21",X"00",
		X"90",X"19",X"77",X"C9",X"3E",X"03",X"21",X"3F",X"81",X"06",X"06",X"77",X"10",X"FD",X"CD",X"E6",
		X"00",X"C9",X"11",X"23",X"81",X"0E",X"10",X"CD",X"23",X"01",X"11",X"31",X"81",X"0E",X"40",X"CD",
		X"23",X"01",X"C9",X"2E",X"00",X"06",X"0E",X"7D",X"FE",X"0B",X"1A",X"13",X"38",X"06",X"CD",X"9A",
		X"03",X"BC",X"28",X"04",X"67",X"CD",X"8B",X"03",X"2C",X"10",X"EC",X"C9",X"21",X"3F",X"81",X"1E",
		X"06",X"0A",X"77",X"23",X"03",X"1D",X"20",X"F9",X"C3",X"76",X"00",X"DD",X"21",X"2A",X"81",X"21",
		X"23",X"81",X"18",X"07",X"DD",X"21",X"38",X"81",X"21",X"31",X"81",X"CD",X"79",X"01",X"28",X"04",
		X"DD",X"CB",X"00",X"86",X"CD",X"79",X"01",X"28",X"04",X"DD",X"CB",X"00",X"8E",X"CD",X"79",X"01",
		X"28",X"04",X"DD",X"CB",X"00",X"96",X"C3",X"76",X"00",X"EB",X"0A",X"03",X"6F",X"0A",X"03",X"67",
		X"EB",X"73",X"23",X"72",X"23",X"7A",X"B3",X"C9",X"21",X"29",X"81",X"18",X"03",X"21",X"37",X"81",
		X"0A",X"03",X"77",X"23",X"0A",X"03",X"CB",X"47",X"28",X"02",X"CB",X"9E",X"CB",X"4F",X"28",X"02",
		X"CB",X"A6",X"CB",X"57",X"28",X"02",X"CB",X"AE",X"C3",X"76",X"00",X"21",X"2B",X"81",X"18",X"03",
		X"21",X"39",X"81",X"16",X"03",X"0A",X"77",X"03",X"23",X"15",X"20",X"F9",X"C3",X"76",X"00",X"21",
		X"2E",X"81",X"18",X"03",X"21",X"3C",X"81",X"EB",X"0A",X"03",X"6F",X"0A",X"03",X"67",X"EB",X"73",
		X"23",X"72",X"23",X"0A",X"03",X"77",X"C3",X"76",X"00",X"AF",X"32",X"00",X"81",X"01",X"00",X"00",
		X"ED",X"4B",X"01",X"81",X"78",X"B1",X"C2",X"76",X"00",X"18",X"F5",X"C5",X"CD",X"E6",X"00",X"CD",
		X"12",X"01",X"3E",X"5C",X"3D",X"20",X"FD",X"C1",X"C3",X"76",X"00",X"C5",X"CD",X"12",X"01",X"CD",
		X"E6",X"00",X"3E",X"2E",X"3D",X"20",X"FD",X"C1",X"C3",X"76",X"00",X"0A",X"03",X"6F",X"87",X"9F",
		X"67",X"09",X"44",X"4D",X"C3",X"76",X"00",X"0A",X"03",X"6F",X"0A",X"47",X"4D",X"C3",X"76",X"00",
		X"0A",X"03",X"6F",X"0A",X"03",X"67",X"35",X"20",X"E2",X"03",X"C3",X"76",X"00",X"0A",X"03",X"6F",
		X"0A",X"03",X"67",X"5E",X"C3",X"46",X"02",X"0A",X"03",X"6F",X"0A",X"03",X"67",X"5E",X"23",X"56",
		X"C3",X"56",X"02",X"0A",X"03",X"5F",X"0A",X"03",X"6F",X"0A",X"03",X"67",X"73",X"C3",X"76",X"00",
		X"0A",X"03",X"5F",X"0A",X"03",X"57",X"0A",X"03",X"6F",X"0A",X"03",X"67",X"73",X"23",X"72",X"C3",
		X"76",X"00",X"0A",X"03",X"6F",X"0A",X"03",X"67",X"5E",X"C3",X"7B",X"02",X"0A",X"03",X"6F",X"0A",
		X"03",X"67",X"5E",X"23",X"56",X"C3",X"8D",X"02",X"0A",X"03",X"5F",X"0A",X"03",X"6F",X"0A",X"03",
		X"67",X"7E",X"83",X"77",X"C3",X"76",X"00",X"0A",X"03",X"5F",X"0A",X"03",X"57",X"0A",X"03",X"6F",
		X"0A",X"03",X"67",X"E5",X"7E",X"23",X"66",X"6F",X"19",X"EB",X"E1",X"73",X"23",X"72",X"C3",X"76",
		X"00",X"0A",X"03",X"5F",X"0A",X"03",X"6F",X"0A",X"03",X"67",X"CB",X"2E",X"1D",X"20",X"FB",X"C3",
		X"76",X"00",X"0A",X"03",X"5F",X"0A",X"03",X"6F",X"0A",X"03",X"67",X"23",X"CB",X"2E",X"2B",X"CB",
		X"1E",X"23",X"1D",X"20",X"F7",X"C3",X"76",X"00",X"0A",X"03",X"5F",X"0A",X"03",X"6F",X"0A",X"03",
		X"67",X"0A",X"77",X"23",X"03",X"1D",X"C2",X"D1",X"02",X"C3",X"76",X"00",X"0A",X"03",X"87",X"C3",
		X"CA",X"02",X"CD",X"6C",X"03",X"CD",X"4D",X"03",X"01",X"00",X"00",X"C3",X"76",X"00",X"0A",X"03",
		X"57",X"0A",X"03",X"5F",X"0A",X"03",X"6F",X"0A",X"03",X"67",X"7E",X"B2",X"A3",X"77",X"C3",X"76",
		X"00",X"0A",X"03",X"5F",X"0A",X"03",X"6F",X"0A",X"03",X"67",X"7E",X"B3",X"77",X"C3",X"76",X"00",
		X"0A",X"03",X"6F",X"0A",X"03",X"67",X"35",X"20",X"09",X"23",X"7E",X"B7",X"20",X"03",X"C3",X"76",
		X"00",X"35",X"0B",X"0B",X"0B",X"C5",X"CD",X"E6",X"00",X"CD",X"12",X"01",X"3E",X"5C",X"3D",X"20",
		X"FD",X"C1",X"C3",X"76",X"00",X"0A",X"03",X"6F",X"0A",X"03",X"67",X"C5",X"44",X"4D",X"C3",X"76",
		X"00",X"C1",X"C3",X"76",X"00",X"3E",X"00",X"32",X"00",X"81",X"C3",X"76",X"00",X"C5",X"21",X"23",
		X"81",X"06",X"0E",X"AF",X"77",X"23",X"10",X"FC",X"21",X"31",X"81",X"06",X"0E",X"AF",X"77",X"23",
		X"10",X"FC",X"3E",X"3F",X"32",X"2A",X"81",X"32",X"38",X"81",X"C1",X"C9",X"CD",X"73",X"03",X"0E",
		X"10",X"18",X"02",X"0E",X"40",X"06",X"0D",X"ED",X"41",X"CB",X"21",X"16",X"00",X"78",X"FE",X"07",
		X"20",X"02",X"16",X"3F",X"ED",X"51",X"CB",X"39",X"10",X"ED",X"C9",X"ED",X"69",X"CB",X"21",X"ED",
		X"61",X"CB",X"39",X"C9",X"0E",X"10",X"18",X"02",X"0E",X"40",X"ED",X"69",X"CB",X"21",X"ED",X"60",
		X"CB",X"39",X"C9",X"0A",X"03",X"6F",X"0A",X"03",X"67",X"C5",X"E5",X"DD",X"E1",X"11",X"05",X"81",
		X"23",X"23",X"01",X"0C",X"00",X"ED",X"B0",X"DD",X"7E",X"0E",X"32",X"2B",X"81",X"32",X"2C",X"81",
		X"32",X"2D",X"81",X"32",X"39",X"81",X"32",X"3A",X"81",X"32",X"3B",X"81",X"DD",X"46",X"00",X"48",
		X"ED",X"43",X"13",X"81",X"ED",X"43",X"15",X"81",X"ED",X"43",X"17",X"81",X"CD",X"EB",X"03",X"2A",
		X"05",X"81",X"7E",X"B7",X"C2",X"CC",X"03",X"C1",X"C3",X"76",X"00",X"CD",X"15",X"04",X"CD",X"3D",
		X"04",X"CD",X"65",X"04",X"CD",X"8D",X"04",X"CD",X"B5",X"04",X"CD",X"DD",X"04",X"C5",X"D5",X"E5",
		X"CD",X"12",X"01",X"ED",X"5B",X"01",X"81",X"7A",X"B3",X"C2",X"76",X"00",X"E1",X"D1",X"C1",X"CD",
		X"05",X"05",X"10",X"D7",X"C9",X"3A",X"2B",X"81",X"3D",X"32",X"2B",X"81",X"78",X"21",X"13",X"81",
		X"BE",X"C0",X"DD",X"7E",X"0E",X"32",X"2B",X"81",X"78",X"2A",X"05",X"81",X"96",X"32",X"13",X"81",
		X"23",X"7E",X"23",X"22",X"05",X"81",X"CD",X"12",X"05",X"22",X"23",X"81",X"C9",X"3A",X"2C",X"81",
		X"3D",X"32",X"2C",X"81",X"78",X"21",X"14",X"81",X"BE",X"C0",X"DD",X"7E",X"0E",X"32",X"2C",X"81",
		X"78",X"2A",X"07",X"81",X"96",X"32",X"14",X"81",X"23",X"7E",X"23",X"22",X"07",X"81",X"CD",X"12",
		X"05",X"22",X"25",X"81",X"C9",X"3A",X"2D",X"81",X"3D",X"32",X"2D",X"81",X"78",X"21",X"15",X"81",
		X"BE",X"C0",X"DD",X"7E",X"0E",X"32",X"2D",X"81",X"78",X"2A",X"09",X"81",X"96",X"32",X"15",X"81",
		X"23",X"7E",X"23",X"22",X"09",X"81",X"CD",X"12",X"05",X"22",X"27",X"81",X"C9",X"3A",X"39",X"81",
		X"3D",X"32",X"39",X"81",X"78",X"21",X"16",X"81",X"BE",X"C0",X"DD",X"7E",X"0E",X"32",X"39",X"81",
		X"78",X"2A",X"0B",X"81",X"96",X"32",X"16",X"81",X"23",X"7E",X"23",X"22",X"0B",X"81",X"CD",X"12",
		X"05",X"22",X"31",X"81",X"C9",X"3A",X"3A",X"81",X"3D",X"32",X"3A",X"81",X"78",X"21",X"17",X"81",
		X"BE",X"C0",X"DD",X"7E",X"0E",X"32",X"3A",X"81",X"78",X"2A",X"0D",X"81",X"96",X"32",X"17",X"81",
		X"23",X"7E",X"23",X"22",X"0D",X"81",X"CD",X"12",X"05",X"22",X"33",X"81",X"C9",X"3A",X"3B",X"81",
		X"3D",X"32",X"3B",X"81",X"78",X"21",X"18",X"81",X"BE",X"C0",X"DD",X"7E",X"0E",X"32",X"3B",X"81",
		X"78",X"2A",X"0F",X"81",X"96",X"32",X"18",X"81",X"23",X"7E",X"23",X"22",X"0F",X"81",X"CD",X"12",
		X"05",X"22",X"35",X"81",X"C9",X"C5",X"DD",X"46",X"01",X"3E",X"5C",X"3D",X"20",X"FD",X"10",X"F9",
		X"C1",X"C9",X"C5",X"47",X"E6",X"0F",X"87",X"6F",X"26",X"00",X"11",X"3A",X"05",X"19",X"5E",X"23",
		X"56",X"78",X"E6",X"7F",X"CB",X"3F",X"CB",X"3F",X"CB",X"3F",X"CB",X"3F",X"47",X"B7",X"CA",X"37",
		X"05",X"CB",X"3A",X"CB",X"1B",X"10",X"FA",X"EB",X"C1",X"C9",X"00",X"00",X"5D",X"0D",X"9C",X"0C",
		X"E7",X"0B",X"3C",X"0B",X"9B",X"0A",X"02",X"0A",X"73",X"09",X"EB",X"08",X"6B",X"08",X"F2",X"07",
		X"80",X"07",X"14",X"07",X"D9",X"08",X"3E",X"0E",X"D3",X"40",X"DB",X"80",X"6F",X"32",X"45",X"81",
		X"FE",X"0E",X"DA",X"67",X"05",X"2E",X"00",X"26",X"00",X"54",X"5D",X"19",X"19",X"11",X"94",X"05",
		X"19",X"EB",X"1A",X"21",X"00",X"81",X"BE",X"38",X"17",X"32",X"00",X"81",X"13",X"1A",X"32",X"01",
		X"81",X"13",X"1A",X"32",X"02",X"81",X"0E",X"10",X"CD",X"6C",X"03",X"0E",X"40",X"CD",X"6C",X"03",
		X"D9",X"08",X"FB",X"C9",X"40",X"BE",X"05",X"40",X"BF",X"05",X"40",X"BE",X"09",X"40",X"43",X"0A",
		X"40",X"73",X"0A",X"40",X"8B",X"0A",X"40",X"02",X"0B",X"40",X"BE",X"05",X"40",X"E8",X"05",X"40",
		X"E6",X"09",X"40",X"43",X"0A",X"40",X"73",X"0A",X"40",X"8B",X"0A",X"40",X"2B",X"0B",X"10",X"18",
		X"03",X"03",X"03",X"03",X"03",X"03",X"19",X"FF",X"0F",X"FF",X"0F",X"FF",X"0F",X"1A",X"FF",X"0F",
		X"FF",X"0F",X"FF",X"0F",X"22",X"D9",X"05",X"02",X"FB",X"08",X"B4",X"11",X"06",X"E2",X"06",X"96",
		X"07",X"62",X"08",X"DE",X"08",X"5A",X"09",X"06",X"18",X"03",X"03",X"03",X"03",X"03",X"03",X"19",
		X"FF",X"0F",X"FF",X"0F",X"FF",X"0F",X"1A",X"FF",X"0F",X"FF",X"0F",X"FF",X"0F",X"22",X"02",X"06",
		X"02",X"FB",X"08",X"B4",X"11",X"06",X"E2",X"06",X"96",X"07",X"62",X"08",X"DE",X"08",X"5A",X"09",
		X"02",X"01",X"80",X"01",X"C9",X"01",X"D4",X"01",X"C9",X"01",X"D1",X"02",X"D4",X"01",X"C8",X"01",
		X"D4",X"01",X"C8",X"01",X"CB",X"05",X"D4",X"01",X"80",X"01",X"C9",X"01",X"D4",X"01",X"C9",X"01",
		X"D1",X"02",X"D4",X"01",X"C8",X"01",X"D4",X"01",X"C8",X"01",X"CB",X"03",X"C4",X"01",X"80",X"01",
		X"C4",X"01",X"80",X"01",X"C9",X"01",X"CC",X"01",X"D5",X"01",X"80",X"01",X"D4",X"01",X"80",X"01",
		X"D4",X"01",X"80",X"01",X"C9",X"01",X"CC",X"01",X"D5",X"01",X"80",X"01",X"D4",X"02",X"80",X"01",
		X"80",X"01",X"A9",X"01",X"AC",X"01",X"B9",X"01",X"80",X"01",X"B9",X"01",X"BC",X"01",X"C9",X"01",
		X"80",X"01",X"C9",X"01",X"CC",X"01",X"D9",X"01",X"80",X"01",X"D9",X"01",X"DC",X"01",X"E9",X"02",
		X"E9",X"02",X"E9",X"02",X"E9",X"01",X"E9",X"01",X"E9",X"01",X"E9",X"01",X"E4",X"01",X"E6",X"01",
		X"E1",X"01",X"E4",X"02",X"E6",X"01",X"D9",X"01",X"D9",X"01",X"DB",X"01",X"DC",X"01",X"D9",X"01",
		X"DB",X"02",X"E1",X"01",X"E9",X"01",X"E1",X"01",X"D9",X"02",X"DB",X"02",X"D9",X"01",X"80",X"01",
		X"D9",X"02",X"D9",X"02",X"D9",X"02",X"D9",X"01",X"D9",X"01",X"D9",X"01",X"D9",X"01",X"D4",X"01",
		X"D6",X"01",X"D1",X"01",X"D4",X"02",X"D6",X"01",X"C9",X"01",X"C9",X"01",X"CB",X"01",X"CC",X"01",
		X"C9",X"01",X"CB",X"02",X"D1",X"01",X"C9",X"01",X"D1",X"01",X"C9",X"02",X"CB",X"02",X"C9",X"02",
		X"80",X"00",X"02",X"80",X"01",X"C4",X"02",X"80",X"02",X"C4",X"01",X"80",X"01",X"C4",X"01",X"C8",
		X"01",X"CB",X"05",X"C4",X"02",X"80",X"01",X"C4",X"02",X"80",X"02",X"C4",X"01",X"80",X"01",X"C4",
		X"01",X"C8",X"01",X"CB",X"03",X"C4",X"01",X"80",X"01",X"C4",X"03",X"80",X"01",X"C5",X"01",X"80",
		X"01",X"C4",X"01",X"80",X"01",X"C4",X"03",X"80",X"01",X"C5",X"01",X"80",X"01",X"C4",X"02",X"80",
		X"01",X"80",X"01",X"A9",X"01",X"AC",X"01",X"B9",X"01",X"80",X"01",X"B9",X"01",X"BC",X"01",X"C9",
		X"01",X"80",X"01",X"C9",X"01",X"CC",X"01",X"D9",X"01",X"80",X"01",X"D9",X"01",X"DC",X"01",X"E9",
		X"02",X"D9",X"02",X"D9",X"02",X"D9",X"01",X"D9",X"01",X"D9",X"01",X"D9",X"04",X"80",X"02",X"D9",
		X"01",X"D5",X"01",X"D5",X"01",X"80",X"01",X"D5",X"02",X"80",X"02",X"D4",X"01",X"80",X"01",X"D4",
		X"01",X"80",X"02",X"D4",X"02",X"D4",X"01",X"80",X"01",X"C9",X"02",X"C9",X"02",X"C9",X"02",X"C9",
		X"01",X"C9",X"01",X"C9",X"01",X"C9",X"01",X"80",X"01",X"C9",X"02",X"80",X"02",X"C9",X"01",X"C4",
		X"01",X"C5",X"01",X"80",X"01",X"C5",X"02",X"80",X"02",X"C4",X"01",X"80",X"01",X"C4",X"01",X"80",
		X"02",X"C4",X"02",X"C4",X"02",X"80",X"01",X"80",X"01",X"C9",X"01",X"D4",X"01",X"C9",X"01",X"D1",
		X"02",X"D4",X"01",X"C8",X"01",X"D4",X"01",X"C8",X"01",X"CB",X"05",X"D4",X"01",X"80",X"01",X"C9",
		X"01",X"D4",X"01",X"C9",X"01",X"D1",X"02",X"D4",X"01",X"C8",X"01",X"D4",X"01",X"C8",X"01",X"CB",
		X"03",X"C4",X"01",X"80",X"01",X"C4",X"01",X"80",X"01",X"C9",X"01",X"CC",X"01",X"D5",X"01",X"80",
		X"01",X"D4",X"01",X"80",X"01",X"D4",X"01",X"80",X"01",X"C9",X"01",X"CC",X"01",X"D5",X"01",X"80",
		X"01",X"D4",X"02",X"80",X"01",X"80",X"01",X"A9",X"01",X"AC",X"01",X"B9",X"01",X"80",X"01",X"B9",
		X"01",X"BC",X"01",X"C9",X"01",X"80",X"01",X"C9",X"01",X"CC",X"01",X"D9",X"01",X"80",X"01",X"D9");
begin
process(clk)
begin
	if rising_edge(clk) then
		data <= rom_data(to_integer(unsigned(addr)));
	end if;
end process;
end architecture;
