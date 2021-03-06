library ieee;
use ieee.std_logic_1164.all,ieee.numeric_std.all;

entity ckong_palette is
port (
	clk  : in  std_logic;
	addr : in  std_logic_vector(5 downto 0);
	data : out std_logic_vector(7 downto 0)
);
end entity;

architecture prom of ckong_palette is
	type rom is array(0 to  63) of std_logic_vector(7 downto 0);
	signal rom_data: rom := (
		X"00",X"3F",X"16",X"FF",X"00",X"C0",X"FF",X"A7",X"00",X"C8",X"E8",X"3F",X"00",X"27",X"16",X"2F",
		X"00",X"1F",X"37",X"FF",X"00",X"D0",X"C0",X"E8",X"00",X"07",X"27",X"F6",X"00",X"2F",X"F7",X"A7",
		X"00",X"38",X"17",X"F0",X"00",X"06",X"DB",X"F0",X"00",X"37",X"07",X"F7",X"00",X"37",X"07",X"D7",
		X"00",X"F0",X"F7",X"D7",X"00",X"E8",X"8A",X"88",X"00",X"37",X"D7",X"07",X"00",X"07",X"E8",X"37");
begin
process(clk)
begin
	if rising_edge(clk) then
		data <= rom_data(to_integer(unsigned(addr)));
	end if;
end process;
end architecture;
