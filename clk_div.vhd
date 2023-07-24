library ieee;
use ieee.std_logic_1164.all;

entity clk_div is
	port (clk, rst    : in  std_logic;
		  clk_divided : out std_logic );
end entity clk_div;

architecture arc_clk_div of clk_div is
	 constant DIV_BY : integer := 100000000; --run half sec 
	--constant DIV_BY : integer := 25000000; --run half sec 
	constant IS_SWITCHED : std_logic := '0';
	signal cnt : integer range 0 to DIV_BY;
  begin
	sync : process (clk, rst)
		begin
			if rst = IS_SWITCHED then
				cnt <= 0;
			elsif clk'event AND clk='1' then --when has rise the clock--> from 0-->1 has a change
				if cnt = DIV_BY then
					cnt <= 0;
				else
					cnt <= cnt + 1;
				end if;
			end if;
	end process;

	comb : process (cnt)
		begin
			if cnt < DIV_BY/2 then
				clk_divided <= '0';
			else
				clk_divided <= '1';
			end if;
	end process;
end architecture arc_clk_div;
