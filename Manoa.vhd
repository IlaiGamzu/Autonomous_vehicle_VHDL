library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
--use Project_package.vhd;

entity engine is 
--port of Engine
port(dir : in std_logic_vector (2 downto 0);
     output: out std_logic_vector (7 downto 0);
	 Estop : in std_logic); -- vector length 2 bit, output
end entity;
	
architecture arc_engine of engine is
signal forward, backwards, stop :  std_logic_vector (1 downto 0);
signal f_right, b_right, f_left, b_left :  std_logic_vector (1 downto 0);
   -- constant stop : std_logic_vector (2 downto 0):="000"; --Stop wheel
    constant move_right : std_logic_vector (2 downto 0):="001"; --The weels direction is right
    constant move_left : std_logic_vector (2 downto 0):="010";  --The weels direction is left
    constant move_forward : std_logic_vector (2 downto 0):="011"; -- The wheel move forward
    constant move_backwards : std_logic_vector (2 downto 0):="100"; -- The wheel move backwards

    

	begin
	--const
	forward <= "01";
	backwards <= "10";
	stop <= "00" ;
	process (dir, forward, backwards,stop,Estop)
	begin
	
	--case: move forward--
	
	if dir=move_forward then
		f_right <= forward;
		b_right <= forward;
		f_left <= forward;
		b_left <= forward;
		
	--case: move backwards--

	elsif dir=move_backwards then
		f_right <= backwards;
		b_right <= backwards;
		f_left <= backwards;
		b_left <= backwards;

	--case: move right--

	elsif dir=move_right then
		f_right <= stop;
		b_right <= stop;
		f_left <= forward;
		b_left <= forward;
	
	--case: move left--
	elsif dir=move_left then
		f_right <= forward;
		b_right <= forward;
		f_left <= stop;
		b_left <= stop;
	else 
	--case: stop--

		f_right <= stop;
		b_right <= stop;
		f_left <= stop;
		b_left <= stop;
	end if;
	
	--case: Estop='1'--

	if Estop='1' then 
	--The wheels will stop
		f_right <= stop;
		b_right <= stop;
		f_left <= stop;
		b_left <= stop;
	end if;
end process;
--all vectors 2 bit from each engine will connect to a big output vector with 8 bit
--which f_right (1) and f_right (0) belong to engine 1 
output<= (f_right(1),f_right(0), b_right(1),b_right(0), f_left(1),f_left(0), b_left(1),b_left(0)); 
end architecture;
	 

	