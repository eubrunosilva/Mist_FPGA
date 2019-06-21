library ieee;
use ieee.std_logic_1164.all,ieee.numeric_std.all;

entity GALAXIAN_1K is
port (
	clk  : in  std_logic;
	addr : in  std_logic_vector(11 downto 0);
	data : out std_logic_vector(7 downto 0)
);
end entity;

architecture prom of GALAXIAN_1K is
	type rom is array(0 to  4095) of std_logic_vector(7 downto 0);
	signal rom_data: rom := (
		X"38",X"7C",X"C2",X"82",X"86",X"7C",X"38",X"00",X"02",X"02",X"FE",X"FE",X"42",X"02",X"00",X"00",
		X"62",X"F2",X"BA",X"9A",X"9E",X"CE",X"46",X"00",X"8C",X"DE",X"F2",X"B2",X"92",X"86",X"04",X"00",
		X"08",X"FE",X"FE",X"C8",X"68",X"38",X"18",X"00",X"1C",X"BE",X"A2",X"A2",X"A2",X"E6",X"E4",X"00",
		X"0C",X"9E",X"92",X"92",X"D2",X"7E",X"3C",X"00",X"C0",X"E0",X"B0",X"9E",X"8E",X"C0",X"C0",X"00",
		X"0C",X"6E",X"9A",X"9A",X"B2",X"F2",X"6C",X"00",X"78",X"FC",X"96",X"92",X"92",X"F2",X"60",X"00",
		X"3E",X"7E",X"C8",X"88",X"C8",X"7E",X"3E",X"00",X"6C",X"FE",X"92",X"92",X"92",X"FE",X"FE",X"00",
		X"44",X"C6",X"82",X"82",X"C6",X"7C",X"38",X"00",X"38",X"7C",X"C6",X"82",X"82",X"FE",X"FE",X"00",
		X"82",X"92",X"92",X"92",X"FE",X"FE",X"00",X"00",X"80",X"90",X"90",X"90",X"90",X"FE",X"FE",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"3E",X"7E",X"C8",X"88",X"C8",X"7E",X"3E",X"00",
		X"6C",X"FE",X"92",X"92",X"92",X"FE",X"FE",X"00",X"44",X"C6",X"82",X"82",X"C6",X"7C",X"38",X"00",
		X"38",X"7C",X"C6",X"82",X"82",X"FE",X"FE",X"00",X"82",X"92",X"92",X"92",X"FE",X"FE",X"00",X"00",
		X"80",X"90",X"90",X"90",X"90",X"FE",X"FE",X"00",X"9E",X"9E",X"92",X"82",X"C6",X"7C",X"38",X"00",
		X"FE",X"FE",X"10",X"10",X"10",X"FE",X"FE",X"00",X"82",X"82",X"FE",X"FE",X"82",X"82",X"00",X"00",
		X"FC",X"FE",X"02",X"02",X"02",X"06",X"04",X"00",X"82",X"C6",X"6E",X"3C",X"18",X"FE",X"FE",X"00",
		X"02",X"02",X"02",X"02",X"FE",X"FE",X"00",X"00",X"FE",X"FE",X"70",X"38",X"70",X"FE",X"FE",X"00",
		X"FE",X"FE",X"1C",X"38",X"70",X"FE",X"FE",X"00",X"7C",X"FE",X"82",X"82",X"82",X"FE",X"7C",X"00",
		X"70",X"F8",X"88",X"88",X"88",X"FE",X"FE",X"00",X"7A",X"FC",X"8E",X"8A",X"82",X"FE",X"7C",X"00",
		X"72",X"F6",X"9E",X"8C",X"88",X"FE",X"FE",X"00",X"0C",X"5E",X"D2",X"92",X"92",X"F6",X"64",X"00",
		X"80",X"80",X"FE",X"FE",X"80",X"80",X"00",X"00",X"FC",X"FE",X"02",X"02",X"02",X"FE",X"FC",X"00",
		X"F0",X"F8",X"1C",X"0E",X"1C",X"F8",X"F0",X"00",X"F8",X"FE",X"1C",X"38",X"1C",X"FE",X"F8",X"00",
		X"C6",X"EE",X"7C",X"38",X"7C",X"EE",X"C6",X"00",X"C0",X"F0",X"1E",X"1E",X"F0",X"C0",X"00",X"00",
		X"C2",X"E2",X"F2",X"BA",X"9E",X"8E",X"86",X"00",X"10",X"10",X"10",X"10",X"10",X"10",X"10",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"FF",X"80",X"80",X"80",X"80",X"80",X"80",X"80",X"00",X"00",X"00",X"02",X"06",X"04",X"0C",X"3E",
		X"FF",X"01",X"01",X"01",X"01",X"01",X"01",X"01",X"FE",X"3E",X"0C",X"04",X"06",X"02",X"00",X"00",
		X"80",X"80",X"80",X"80",X"80",X"80",X"80",X"FF",X"00",X"00",X"00",X"00",X"00",X"24",X"7F",X"3E",
		X"01",X"01",X"01",X"01",X"01",X"01",X"01",X"FF",X"FF",X"3E",X"7F",X"24",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"03",X"00",X"00",X"00",X"20",X"60",X"40",X"C0",X"E0",
		X"0F",X"03",X"00",X"00",X"00",X"00",X"00",X"00",X"E0",X"E0",X"C0",X"40",X"60",X"20",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"02",X"07",X"03",X"00",X"00",X"00",X"00",X"00",X"40",X"F0",X"E0",
		X"0F",X"03",X"07",X"02",X"00",X"00",X"00",X"00",X"F0",X"E0",X"F0",X"40",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"06",X"0C",X"3E",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"FF",X"3E",X"0C",X"06",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"03",X"00",X"00",X"00",X"00",X"00",X"60",X"C0",X"E0",
		X"0F",X"03",X"00",X"00",X"00",X"00",X"00",X"00",X"F0",X"E0",X"C0",X"60",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"1B",X"07",X"00",X"00",X"00",X"00",X"00",X"00",X"80",X"C0",
		X"07",X"03",X"01",X"00",X"00",X"00",X"00",X"00",X"C0",X"E0",X"C0",X"80",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"1B",X"07",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"C0",
		X"07",X"03",X"03",X"01",X"00",X"00",X"00",X"00",X"C0",X"C0",X"C0",X"A0",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"04",X"02",X"01",X"00",X"00",X"00",X"00",X"00",X"00",X"80",X"E0",
		X"03",X"03",X"03",X"01",X"00",X"00",X"00",X"00",X"F4",X"E0",X"C0",X"10",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"02",X"01",X"01",X"03",X"00",X"00",X"00",X"00",X"00",X"00",X"80",X"C0",
		X"01",X"01",X"01",X"00",X"00",X"00",X"00",X"00",X"EC",X"F0",X"E0",X"E0",X"40",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"02",X"01",X"03",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"80",
		X"03",X"07",X"0F",X"0F",X"09",X"00",X"00",X"00",X"80",X"E0",X"E0",X"80",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"01",X"01",X"03",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"80",
		X"18",X"18",X"00",X"00",X"00",X"00",X"18",X"18",X"18",X"18",X"00",X"00",X"00",X"00",X"18",X"18",
		X"00",X"00",X"00",X"00",X"00",X"03",X"FF",X"CF",X"03",X"06",X"0C",X"18",X"1C",X"E0",X"F8",X"FC",
		X"FF",X"03",X"00",X"00",X"00",X"00",X"00",X"00",X"F8",X"E0",X"1C",X"18",X"0C",X"06",X"03",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"07",X"0E",X"3F",X"04",X"3F",X"0E",X"07",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"F8",X"F8",X"F8",X"F8",X"F8",X"F8",X"F8",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"F0",X"70",X"70",X"30",X"10",X"00",
		X"81",X"7E",X"7E",X"7E",X"7E",X"7E",X"7E",X"81",X"00",X"00",X"FF",X"FF",X"FF",X"F0",X"7C",X"1F",
		X"00",X"00",X"01",X"01",X"0D",X"07",X"06",X"16",X"00",X"00",X"20",X"C0",X"80",X"70",X"E0",X"C0",
		X"0B",X"05",X"03",X"06",X"04",X"08",X"00",X"00",X"60",X"80",X"60",X"B0",X"88",X"00",X"00",X"00",
		X"00",X"00",X"02",X"01",X"02",X"06",X"09",X"0E",X"00",X"00",X"80",X"40",X"80",X"56",X"B8",X"70",
		X"06",X"0D",X"35",X"03",X"00",X"00",X"00",X"00",X"70",X"AC",X"C2",X"C0",X"C0",X"40",X"20",X"00",
		X"00",X"00",X"3C",X"23",X"21",X"22",X"24",X"18",X"00",X"00",X"70",X"88",X"84",X"44",X"24",X"14",
		X"18",X"14",X"22",X"41",X"40",X"41",X"3E",X"00",X"14",X"38",X"70",X"E8",X"C8",X"38",X"00",X"00",
		X"00",X"04",X"01",X"08",X"14",X"00",X"10",X"00",X"00",X"00",X"80",X"50",X"05",X"10",X"00",X"04",
		X"60",X"00",X"08",X"10",X"0A",X"01",X"08",X"00",X"04",X"08",X"00",X"28",X"08",X"80",X"08",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"02",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"40",
		X"07",X"03",X"0F",X"03",X"07",X"02",X"00",X"00",X"F0",X"80",X"00",X"80",X"F0",X"40",X"00",X"00",
		X"00",X"00",X"00",X"01",X"00",X"00",X"00",X"01",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"20",
		X"09",X"09",X"01",X"00",X"00",X"00",X"01",X"00",X"20",X"20",X"20",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"02",X"00",X"00",X"00",X"00",X"30",X"78",X"F8",X"F0",
		X"07",X"05",X"05",X"07",X"02",X"00",X"00",X"00",X"40",X"B0",X"B0",X"40",X"F0",X"F8",X"78",X"30",
		X"0E",X"10",X"26",X"41",X"83",X"87",X"0F",X"1F",X"00",X"00",X"C0",X"00",X"88",X"C8",X"C0",X"88",
		X"1F",X"2F",X"27",X"03",X"01",X"06",X"00",X"00",X"88",X"C0",X"C1",X"81",X"02",X"C4",X"08",X"70",
		X"06",X"08",X"03",X"24",X"40",X"10",X"20",X"40",X"60",X"10",X"00",X"30",X"0A",X"21",X"10",X"00",
		X"88",X"A8",X"24",X"08",X"40",X"26",X"10",X"03",X"15",X"15",X"24",X"80",X"12",X"60",X"04",X"90",
		X"00",X"00",X"00",X"00",X"04",X"00",X"08",X"09",X"00",X"00",X"00",X"00",X"80",X"20",X"80",X"50",
		X"00",X"02",X"08",X"04",X"00",X"00",X"00",X"00",X"90",X"00",X"20",X"40",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"08",X"0C",X"FC",X"0C",X"08",X"00",X"00",X"F8",X"01",X"7F",X"F0",X"7F",X"01",X"F8",X"00",
		X"00",X"00",X"00",X"00",X"10",X"3A",X"7F",X"FF",X"00",X"00",X"10",X"38",X"70",X"60",X"20",X"F8",
		X"FC",X"FF",X"7F",X"3A",X"10",X"00",X"00",X"00",X"30",X"F8",X"20",X"60",X"70",X"38",X"10",X"00",
		X"20",X"20",X"00",X"10",X"28",X"28",X"28",X"3E",X"2A",X"2A",X"2A",X"12",X"00",X"20",X"20",X"3E",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"24",X"00",X"00",X"00",X"66",X"66",X"00",X"00",X"00",
		X"FF",X"FF",X"FF",X"FF",X"00",X"00",X"00",X"00",X"FC",X"FE",X"FF",X"FF",X"0F",X"07",X"07",X"07",
		X"00",X"00",X"00",X"00",X"FF",X"FF",X"FF",X"FF",X"07",X"07",X"07",X"0F",X"FF",X"FF",X"FE",X"FC",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"7F",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"C0",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"C0",X"C0",X"FF",X"FF",X"FF",X"FF",X"00",X"00",
		X"F0",X"F0",X"F0",X"F0",X"00",X"00",X"00",X"00",X"FF",X"FF",X"FF",X"FF",X"FF",X"E0",X"E0",X"E0",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"E0",X"E0",X"E0",X"E0",X"E0",X"E0",X"00",X"00",
		X"FF",X"FF",X"01",X"00",X"FF",X"FF",X"FF",X"FF",X"FE",X"FF",X"FF",X"FF",X"FC",X"F0",X"F0",X"FC",
		X"00",X"01",X"FF",X"FF",X"FF",X"FF",X"00",X"00",X"FF",X"FF",X"FF",X"FE",X"FC",X"F8",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"FF",X"FF",X"FF",X"F8",X"F8",X"FF",X"8F",X"8F",
		X"00",X"00",X"00",X"00",X"00",X"00",X"FF",X"FF",X"8F",X"8F",X"FF",X"7F",X"00",X"00",X"F8",X"FC",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"E0",X"E0",X"E0",X"E0",X"E0",X"E0",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"FF",X"FF",X"FF",X"FF",X"FF",X"00",X"00",X"FF",
		X"30",X"71",X"F3",X"E3",X"E3",X"E3",X"E3",X"E3",X"FC",X"FE",X"FF",X"FF",X"FF",X"9F",X"0F",X"07",
		X"E3",X"E3",X"E3",X"F7",X"FF",X"FF",X"7E",X"3C",X"07",X"07",X"07",X"07",X"0F",X"0F",X"0E",X"0C",
		X"00",X"18",X"26",X"41",X"40",X"20",X"21",X"13",X"00",X"00",X"0E",X"1F",X"5B",X"7F",X"FE",X"FE",
		X"13",X"0F",X"0F",X"0F",X"0F",X"07",X"03",X"01",X"7F",X"FE",X"B4",X"B8",X"E8",X"F0",X"F0",X"E0",
		X"00",X"00",X"34",X"7F",X"FF",X"BF",X"FF",X"FF",X"00",X"18",X"64",X"82",X"02",X"84",X"04",X"C8",
		X"FD",X"FF",X"FE",X"77",X"6F",X"1F",X"0F",X"01",X"E8",X"F0",X"E0",X"F0",X"F8",X"D8",X"F0",X"70",
		X"03",X"07",X"07",X"07",X"03",X"07",X"09",X"10",X"00",X"E0",X"E0",X"D0",X"B8",X"F6",X"EE",X"BE",
		X"10",X"20",X"20",X"40",X"41",X"26",X"18",X"00",X"1F",X"1E",X"26",X"43",X"80",X"00",X"00",X"00",
		X"07",X"1F",X"3F",X"1F",X"6D",X"F7",X"FB",X"FF",X"E0",X"B0",X"F0",X"E0",X"E0",X"E0",X"90",X"08",
		X"FF",X"FE",X"BC",X"EA",X"C1",X"00",X"00",X"00",X"08",X"04",X"04",X"02",X"82",X"64",X"18",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"66",X"FF",X"FF",X"FE",X"FE",X"EE",
		X"03",X"07",X"06",X"07",X"01",X"0C",X"CE",X"1F",X"75",X"F5",X"F0",X"E4",X"90",X"90",X"08",X"00",
		X"00",X"00",X"00",X"80",X"EC",X"DE",X"AD",X"3B",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"57",X"4F",X"07",X"03",X"07",X"07",X"09",X"08",X"00",X"00",X"C0",X"E0",X"70",X"B0",X"E0",X"70",
		X"13",X"1C",X"0F",X"05",X"0F",X"0E",X"0D",X"03",X"89",X"0B",X"10",X"90",X"20",X"60",X"C9",X"D9",
		X"07",X"07",X"02",X"03",X"00",X"00",X"00",X"00",X"FA",X"7C",X"FE",X"FE",X"FF",X"3B",X"03",X"00",
		X"00",X"08",X"05",X"07",X"03",X"22",X"49",X"63",X"10",X"F0",X"F0",X"60",X"C0",X"C0",X"20",X"A0",
		X"67",X"E7",X"F7",X"FF",X"7F",X"1E",X"4A",X"00",X"E0",X"F0",X"C0",X"0C",X"00",X"00",X"00",X"00",
		X"00",X"01",X"00",X"10",X"08",X"00",X"22",X"10",X"00",X"00",X"90",X"48",X"68",X"24",X"04",X"90",
		X"0A",X"06",X"02",X"20",X"58",X"06",X"11",X"00",X"4A",X"23",X"3B",X"9E",X"4C",X"08",X"D8",X"7C",
		X"00",X"11",X"22",X"20",X"44",X"49",X"0A",X"90",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"20",
		X"30",X"64",X"E0",X"C6",X"58",X"F1",X"60",X"46",X"40",X"80",X"04",X"18",X"20",X"00",X"00",X"00",
		X"00",X"03",X"06",X"0E",X"14",X"20",X"01",X"02",X"0E",X"0B",X"12",X"22",X"44",X"04",X"09",X"09",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"10",X"22",X"02",X"40",X"80",X"00",X"00",X"00",
		X"E0",X"B0",X"89",X"84",X"42",X"40",X"24",X"22",X"00",X"80",X"E0",X"50",X"08",X"00",X"80",X"40",
		X"14",X"00",X"08",X"04",X"42",X"40",X"20",X"00",X"20",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"04",X"42",X"21",X"10",X"08",X"00",X"02",X"01",X"01",X"01",X"01",X"20",X"11",X"10",X"0A",X"20",
		X"20",X"10",X"09",X"04",X"00",X"00",X"00",X"1C",X"12",X"0A",X"0A",X"87",X"02",X"0E",X"3C",X"F8",
		X"00",X"00",X"04",X"09",X"13",X"92",X"A0",X"84",X"01",X"42",X"84",X"48",X"00",X"02",X"44",X"98",
		X"01",X"92",X"A0",X"C1",X"E6",X"3C",X"30",X"63",X"38",X"10",X"84",X"48",X"10",X"20",X"00",X"00",
		X"00",X"00",X"04",X"09",X"11",X"22",X"40",X"18",X"1C",X"0E",X"0B",X"93",X"05",X"04",X"48",X"90",
		X"11",X"22",X"40",X"01",X"10",X"20",X"40",X"80",X"04",X"08",X"88",X"10",X"24",X"24",X"28",X"10",
		X"30",X"7C",X"43",X"E0",X"A4",X"90",X"82",X"09",X"58",X"1C",X"0A",X"11",X"88",X"44",X"00",X"08",
		X"A0",X"A0",X"89",X"04",X"84",X"02",X"00",X"00",X"9C",X"0A",X"21",X"10",X"08",X"04",X"02",X"01",
		X"38",X"7C",X"C2",X"82",X"86",X"7C",X"38",X"00",X"02",X"02",X"FE",X"FE",X"42",X"02",X"00",X"00",
		X"62",X"F2",X"BA",X"9A",X"9E",X"CE",X"46",X"00",X"8C",X"DE",X"F2",X"B2",X"92",X"86",X"04",X"00",
		X"08",X"FE",X"FE",X"C8",X"68",X"38",X"18",X"00",X"1C",X"BE",X"A2",X"A2",X"A2",X"E6",X"E4",X"00",
		X"0C",X"9E",X"92",X"92",X"D2",X"7E",X"3C",X"00",X"C0",X"E0",X"B0",X"9E",X"8E",X"C0",X"C0",X"00",
		X"0C",X"6E",X"9A",X"9A",X"B2",X"F2",X"6C",X"00",X"78",X"FC",X"96",X"92",X"92",X"F2",X"60",X"00",
		X"3E",X"7E",X"C8",X"88",X"C8",X"7E",X"3E",X"00",X"6C",X"FE",X"92",X"92",X"92",X"FE",X"FE",X"00",
		X"44",X"C6",X"82",X"82",X"C6",X"7C",X"38",X"00",X"38",X"7C",X"C6",X"82",X"82",X"FE",X"FE",X"00",
		X"82",X"92",X"92",X"92",X"FE",X"FE",X"00",X"00",X"80",X"90",X"90",X"90",X"90",X"FE",X"FE",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"3E",X"7E",X"C8",X"88",X"C8",X"7E",X"3E",X"00",
		X"6C",X"FE",X"92",X"92",X"92",X"FE",X"FE",X"00",X"44",X"C6",X"82",X"82",X"C6",X"7C",X"38",X"00",
		X"38",X"7C",X"C6",X"82",X"82",X"FE",X"FE",X"00",X"82",X"92",X"92",X"92",X"FE",X"FE",X"00",X"00",
		X"80",X"90",X"90",X"90",X"90",X"FE",X"FE",X"00",X"9E",X"9E",X"92",X"82",X"C6",X"7C",X"38",X"00",
		X"FE",X"FE",X"10",X"10",X"10",X"FE",X"FE",X"00",X"82",X"82",X"FE",X"FE",X"82",X"82",X"00",X"00",
		X"FC",X"FE",X"02",X"02",X"02",X"06",X"04",X"00",X"82",X"C6",X"6E",X"3C",X"18",X"FE",X"FE",X"00",
		X"02",X"02",X"02",X"02",X"FE",X"FE",X"00",X"00",X"FE",X"FE",X"70",X"38",X"70",X"FE",X"FE",X"00",
		X"FE",X"FE",X"1C",X"38",X"70",X"FE",X"FE",X"00",X"7C",X"FE",X"82",X"82",X"82",X"FE",X"7C",X"00",
		X"70",X"F8",X"88",X"88",X"88",X"FE",X"FE",X"00",X"7A",X"FC",X"8E",X"8A",X"82",X"FE",X"7C",X"00",
		X"72",X"F6",X"9E",X"8C",X"88",X"FE",X"FE",X"00",X"0C",X"5E",X"D2",X"92",X"92",X"F6",X"64",X"00",
		X"80",X"80",X"FE",X"FE",X"80",X"80",X"00",X"00",X"FC",X"FE",X"02",X"02",X"02",X"FE",X"FC",X"00",
		X"F0",X"F8",X"1C",X"0E",X"1C",X"F8",X"F0",X"00",X"F8",X"FE",X"1C",X"38",X"1C",X"FE",X"F8",X"00",
		X"C6",X"EE",X"7C",X"38",X"7C",X"EE",X"C6",X"00",X"C0",X"F0",X"1E",X"1E",X"F0",X"C0",X"00",X"00",
		X"C2",X"E2",X"F2",X"BA",X"9E",X"8E",X"86",X"00",X"10",X"10",X"10",X"10",X"10",X"10",X"10",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"FF",X"80",X"80",X"80",X"80",X"80",X"80",X"80",X"00",X"00",X"20",X"20",X"04",X"04",X"10",X"00",
		X"FF",X"01",X"01",X"01",X"01",X"01",X"01",X"01",X"90",X"80",X"02",X"02",X"08",X"08",X"00",X"00",
		X"80",X"80",X"80",X"80",X"80",X"80",X"80",X"FF",X"00",X"00",X"08",X"08",X"02",X"02",X"80",X"90",
		X"01",X"01",X"01",X"01",X"01",X"01",X"01",X"FF",X"00",X"10",X"04",X"04",X"20",X"20",X"00",X"00",
		X"00",X"00",X"00",X"02",X"02",X"02",X"07",X"05",X"30",X"78",X"F8",X"F8",X"F0",X"E0",X"40",X"B0",
		X"05",X"07",X"02",X"02",X"02",X"00",X"00",X"00",X"B0",X"40",X"E0",X"F0",X"F8",X"F8",X"78",X"30",
		X"00",X"00",X"00",X"00",X"00",X"02",X"07",X"05",X"00",X"00",X"30",X"78",X"F8",X"F0",X"40",X"B0",
		X"05",X"07",X"02",X"00",X"00",X"00",X"00",X"00",X"B0",X"40",X"F0",X"F8",X"78",X"30",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"10",X"00",X"00",X"00",X"12",X"92",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"92",X"12",X"00",X"00",X"00",X"10",X"00",X"00",
		X"00",X"00",X"10",X"00",X"00",X"00",X"12",X"92",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"92",X"12",X"00",X"00",X"00",X"10",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"20",X"20",X"04",X"04",X"10",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"90",X"80",X"02",X"02",X"08",X"08",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"10",X"00",X"10",X"12",X"82",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"82",X"12",X"10",X"00",X"10",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"08",X"08",X"02",X"02",X"80",X"90",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"10",X"04",X"04",X"20",X"20",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"10",X"3A",X"7F",X"FF",X"00",X"00",X"10",X"38",X"70",X"60",X"20",X"F8",
		X"FC",X"FF",X"7F",X"3A",X"10",X"00",X"00",X"00",X"30",X"F8",X"20",X"60",X"70",X"38",X"10",X"00",
		X"00",X"00",X"00",X"00",X"03",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"08",X"00",X"C0",
		X"01",X"10",X"00",X"02",X"00",X"00",X"00",X"00",X"00",X"10",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"01",X"00",X"00",X"32",X"00",X"00",X"00",X"00",X"80",X"00",X"00",X"8C",
		X"18",X"18",X"00",X"00",X"00",X"00",X"18",X"18",X"18",X"18",X"00",X"00",X"00",X"00",X"18",X"18",
		X"00",X"00",X"00",X"00",X"00",X"03",X"FF",X"CF",X"03",X"06",X"0C",X"18",X"1C",X"E0",X"F8",X"FC",
		X"FF",X"03",X"00",X"00",X"00",X"00",X"00",X"00",X"F8",X"E0",X"1C",X"18",X"0C",X"06",X"03",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"07",X"0E",X"3F",X"04",X"3F",X"0E",X"07",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"F8",X"F8",X"F8",X"F8",X"F8",X"F8",X"F8",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"F0",X"70",X"70",X"30",X"10",X"00",
		X"1F",X"7C",X"F0",X"FF",X"FF",X"FF",X"00",X"00",X"00",X"00",X"FF",X"FF",X"FF",X"F0",X"7C",X"1F",
		X"00",X"00",X"01",X"01",X"0D",X"07",X"06",X"16",X"00",X"00",X"20",X"C0",X"80",X"70",X"E0",X"C0",
		X"0B",X"05",X"03",X"06",X"04",X"08",X"00",X"00",X"60",X"80",X"60",X"B0",X"88",X"00",X"00",X"00",
		X"00",X"00",X"02",X"01",X"02",X"06",X"09",X"0E",X"00",X"00",X"80",X"40",X"80",X"56",X"B8",X"70",
		X"06",X"0D",X"35",X"03",X"00",X"00",X"00",X"00",X"70",X"AC",X"C2",X"C0",X"C0",X"40",X"20",X"00",
		X"00",X"00",X"3C",X"23",X"21",X"22",X"24",X"18",X"00",X"00",X"70",X"88",X"84",X"44",X"24",X"14",
		X"18",X"14",X"22",X"41",X"40",X"41",X"3E",X"00",X"14",X"38",X"70",X"E8",X"C8",X"38",X"00",X"00",
		X"00",X"04",X"01",X"08",X"14",X"00",X"10",X"00",X"00",X"00",X"80",X"50",X"05",X"10",X"00",X"04",
		X"60",X"00",X"08",X"10",X"0A",X"01",X"08",X"00",X"04",X"08",X"00",X"28",X"08",X"80",X"08",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"01",X"08",X"0C",X"FC",X"0C",X"08",X"01",X"00",X"C0",X"01",X"7F",X"F0",X"70",X"1C",X"14",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"08",X"0C",X"FC",X"0C",X"08",X"00",X"00",X"F8",X"01",X"7F",X"F0",X"7F",X"01",X"F8",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"01",X"08",X"0C",X"FC",X"0C",X"08",X"01",X"00",X"C4",X"0C",X"70",X"F0",X"7F",X"01",X"C0",
		X"00",X"00",X"00",X"00",X"00",X"01",X"1A",X"3C",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"38",X"3C",X"1A",X"01",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"06",X"08",X"03",X"24",X"40",X"10",X"20",X"40",X"60",X"10",X"00",X"30",X"0A",X"21",X"10",X"00",
		X"88",X"A8",X"24",X"08",X"40",X"26",X"10",X"03",X"15",X"15",X"24",X"80",X"12",X"60",X"04",X"90",
		X"00",X"00",X"00",X"00",X"04",X"00",X"08",X"09",X"00",X"00",X"00",X"00",X"80",X"20",X"80",X"50",
		X"00",X"02",X"08",X"04",X"00",X"00",X"00",X"00",X"90",X"00",X"20",X"40",X"00",X"00",X"00",X"00",
		X"06",X"37",X"4D",X"4D",X"59",X"79",X"36",X"00",X"3C",X"7E",X"4B",X"49",X"49",X"79",X"30",X"00",
		X"FF",X"FF",X"FF",X"C3",X"C3",X"C3",X"00",X"00",X"00",X"00",X"C3",X"C3",X"C3",X"FF",X"FF",X"FF",
		X"8E",X"DE",X"DF",X"FF",X"FF",X"FF",X"00",X"00",X"00",X"00",X"71",X"71",X"FB",X"DB",X"DB",X"8F",
		X"DB",X"FF",X"FF",X"FF",X"FF",X"FF",X"00",X"00",X"00",X"00",X"C3",X"C3",X"DB",X"DB",X"DB",X"DB",
		X"0F",X"00",X"00",X"00",X"00",X"00",X"28",X"1C",X"F0",X"00",X"00",X"00",X"08",X"00",X"28",X"60",
		X"1C",X"28",X"00",X"00",X"00",X"00",X"00",X"0F",X"60",X"28",X"00",X"08",X"00",X"00",X"00",X"F0",
		X"01",X"00",X"00",X"00",X"00",X"00",X"28",X"1C",X"F0",X"08",X"04",X"02",X"08",X"00",X"28",X"60",
		X"1C",X"28",X"00",X"00",X"40",X"20",X"10",X"0F",X"60",X"28",X"00",X"08",X"00",X"00",X"00",X"80",
		X"00",X"00",X"00",X"00",X"00",X"00",X"08",X"1C",X"30",X"08",X"04",X"02",X"09",X"09",X"21",X"68",
		X"1C",X"88",X"80",X"80",X"40",X"20",X"10",X"0C",X"68",X"20",X"08",X"08",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"08",X"9C",X"00",X"08",X"04",X"02",X"09",X"09",X"21",X"69",
		X"9C",X"88",X"80",X"80",X"40",X"20",X"10",X"00",X"69",X"20",X"08",X"08",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"80",X"80",X"A8",X"9C",X"00",X"00",X"00",X"00",X"09",X"01",X"29",X"61",
		X"9C",X"A8",X"80",X"80",X"00",X"00",X"00",X"00",X"61",X"29",X"01",X"09",X"00",X"00",X"00",X"00",
		X"00",X"10",X"20",X"40",X"80",X"80",X"A8",X"9C",X"00",X"00",X"00",X"00",X"08",X"00",X"28",X"61",
		X"9C",X"28",X"00",X"00",X"00",X"00",X"00",X"00",X"61",X"29",X"01",X"09",X"02",X"04",X"08",X"00",
		X"0C",X"10",X"20",X"40",X"80",X"A0",X"28",X"1C",X"00",X"00",X"00",X"00",X"08",X"08",X"20",X"68",
		X"1C",X"28",X"20",X"00",X"00",X"00",X"00",X"00",X"68",X"20",X"09",X"09",X"02",X"04",X"08",X"70",
		X"0F",X"10",X"20",X"40",X"00",X"00",X"08",X"1C",X"80",X"00",X"00",X"00",X"08",X"08",X"20",X"68",
		X"1C",X"08",X"00",X"00",X"00",X"00",X"00",X"01",X"68",X"20",X"08",X"08",X"02",X"04",X"08",X"F0",
		X"00",X"18",X"26",X"41",X"40",X"20",X"21",X"13",X"00",X"00",X"0E",X"1F",X"5B",X"7F",X"FE",X"FE",
		X"13",X"0F",X"0F",X"0F",X"0F",X"07",X"03",X"01",X"7F",X"FE",X"B4",X"D8",X"E8",X"F0",X"F0",X"E0",
		X"00",X"00",X"34",X"7F",X"FF",X"DF",X"FF",X"FF",X"00",X"18",X"64",X"82",X"02",X"84",X"04",X"C8",
		X"FD",X"FF",X"FE",X"77",X"6F",X"1F",X"0F",X"01",X"E8",X"F0",X"E0",X"F0",X"F8",X"D8",X"F0",X"70",
		X"03",X"07",X"07",X"07",X"03",X"07",X"09",X"10",X"00",X"E0",X"E0",X"D0",X"B8",X"F6",X"EE",X"BE",
		X"10",X"20",X"20",X"40",X"41",X"26",X"18",X"00",X"1F",X"1E",X"26",X"43",X"80",X"00",X"00",X"00",
		X"07",X"1F",X"3F",X"1F",X"6D",X"F7",X"FB",X"FF",X"E0",X"B0",X"F0",X"E0",X"E0",X"E0",X"90",X"08",
		X"FF",X"FE",X"BC",X"EA",X"C1",X"00",X"00",X"00",X"08",X"04",X"04",X"02",X"82",X"64",X"18",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"66",X"FF",X"FF",X"FE",X"FE",X"FE",
		X"03",X"07",X"06",X"07",X"01",X"0C",X"CE",X"1F",X"75",X"F5",X"F0",X"E4",X"90",X"90",X"08",X"00",
		X"00",X"00",X"00",X"80",X"EC",X"DE",X"AD",X"3B",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"57",X"4F",X"07",X"03",X"07",X"07",X"09",X"08",X"00",X"00",X"C0",X"E0",X"70",X"B0",X"E0",X"70",
		X"13",X"1C",X"0F",X"05",X"0F",X"0E",X"0D",X"03",X"89",X"0B",X"10",X"90",X"20",X"60",X"C9",X"D9",
		X"07",X"07",X"02",X"03",X"00",X"00",X"00",X"00",X"FA",X"7C",X"FE",X"FE",X"FF",X"3B",X"03",X"00",
		X"00",X"08",X"05",X"07",X"03",X"22",X"49",X"63",X"10",X"F0",X"F0",X"60",X"C0",X"C0",X"20",X"A0",
		X"67",X"E7",X"F7",X"FF",X"7F",X"1E",X"4A",X"00",X"E0",X"F0",X"C0",X"C0",X"00",X"00",X"00",X"00",
		X"00",X"01",X"00",X"10",X"08",X"00",X"22",X"10",X"00",X"00",X"90",X"48",X"68",X"24",X"04",X"90",
		X"0A",X"06",X"02",X"20",X"58",X"06",X"11",X"00",X"4A",X"23",X"3B",X"9E",X"4C",X"08",X"D8",X"7C",
		X"00",X"11",X"22",X"20",X"44",X"49",X"0A",X"90",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"20",
		X"30",X"64",X"E0",X"C6",X"58",X"F1",X"60",X"46",X"40",X"80",X"04",X"18",X"20",X"00",X"00",X"00",
		X"00",X"03",X"06",X"0E",X"14",X"20",X"01",X"02",X"0E",X"0B",X"12",X"22",X"44",X"04",X"09",X"09",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"10",X"01",X"02",X"40",X"80",X"00",X"00",X"00",
		X"E0",X"B0",X"89",X"84",X"42",X"40",X"24",X"22",X"00",X"80",X"E0",X"50",X"08",X"00",X"80",X"40",
		X"14",X"00",X"08",X"04",X"42",X"40",X"20",X"00",X"20",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"04",X"42",X"21",X"10",X"08",X"00",X"02",X"01",X"01",X"01",X"01",X"20",X"11",X"10",X"0A",X"20",
		X"20",X"10",X"09",X"04",X"00",X"00",X"00",X"1C",X"12",X"0A",X"0A",X"87",X"02",X"0E",X"3C",X"F8",
		X"00",X"00",X"04",X"09",X"13",X"92",X"A0",X"84",X"01",X"42",X"84",X"48",X"00",X"02",X"44",X"98",
		X"01",X"92",X"A0",X"C1",X"E6",X"3C",X"30",X"63",X"38",X"10",X"84",X"48",X"10",X"20",X"00",X"00",
		X"00",X"00",X"04",X"09",X"11",X"22",X"40",X"18",X"1C",X"0E",X"0B",X"93",X"05",X"04",X"48",X"90",
		X"11",X"22",X"40",X"01",X"10",X"20",X"40",X"80",X"04",X"08",X"88",X"10",X"24",X"24",X"28",X"10",
		X"30",X"7C",X"43",X"E0",X"A4",X"90",X"82",X"09",X"58",X"1C",X"0A",X"11",X"88",X"44",X"00",X"08",
		X"A0",X"A0",X"89",X"04",X"84",X"02",X"00",X"00",X"9C",X"0A",X"21",X"10",X"08",X"04",X"02",X"01");
begin
process(clk)
begin
	if rising_edge(clk) then
		data <= rom_data(to_integer(unsigned(addr)));
	end if;
end process;
end architecture;
