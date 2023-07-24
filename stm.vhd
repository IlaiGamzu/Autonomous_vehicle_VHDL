library ieee;
use ieee.std_logic_1164.all;

--Entity STM
	entity stm is 
	  port( 
		stm_clock, restN : in std_logic;
		track            : in std_logic_vector(1 downto 0);
		dir              : in std_logic_vector(2 downto 0);
		s                : out std_logic_vector(2 downto 0)
	  );
	end stm;

--Architecture of STM
	architecture arc_stm of stm is
	
	--Component:
	
	--component to rectangle
	component rec_road is
		port (stm_clock, restN 			: in std_logic;
			  output_rec                : out std_logic_vector(2 downto 0)
			  );
    end component;
	---------------------------------------------------------------------------------------------------
	-- component circaul_road is 
			-- port (stm_clock, restN : in std_logic;
				  -- output_circaul                 : out std_logic_vector(2 downto 0));
    -- end component;
	---------------------------------------------------------------------------------------------------
	
	--component to back_and_forward
	component back_and_forward is 
			port (stm_clock, restN 						: in std_logic;
				  output_back_and_forward               : out std_logic_vector(2 downto 0)
				  );
    end component;
	
	--component to mux
	component mux is 
	port(mux_from_rec, mux_from_bafo, mux_from_dir : in std_logic_vector(2 downto 0);
		 reset 									   : in std_logic;
		 chooseTrack                               : in std_logic_vector(1 downto 0);
		 output                                    : out std_logic_vector(2 downto 0)
		 );
    end component;
	
	--signals that connect from all mini STM to mux
	    signal rec_out_net: std_logic_vector (2 downto 0);
        -- signal cir_out: std_logic_vector (2 downto 0);
	    signal bafo_out_net: std_logic_vector (2 downto 0);
		signal dir_out_net : std_logic_vector (2 downto 0);

	begin

	
	A1: rec_road port map (stm_clock=>stm_clock, restN=>restN, output_rec=>rec_out_net);
	-- A2: circaul_road port map(stm_clock=>stm_clock, restN=>restN, output_circaul=>cir_out);
	A3: back_and_forward port map(stm_clock=>stm_clock, restN=>restN, output_back_and_forward=>bafo_out_net);
	--DIR
	A5: mux port map(output=>s, mux_from_rec =>rec_out_net,  
					  mux_from_bafo=>bafo_out_net, mux_from_dir=>dir, reset=>restN,chooseTrack=>track );
	
	end arc_stm;
	
	
	-----entity------
library ieee;
use ieee.std_logic_1164.all;	
	entity rec_road is 
		port (stm_clock, restN : in std_logic;
			  output_rec       : out std_logic_vector(2 downto 0));
			  
	end rec_road;
	------------------------------------------------------------------------
	-- entity circaul_road is 
			-- port (stm_clock, restN : in std_logic;
			  -- s                : out std_logic_vector(2 downto 0));
    -- end entity;
	------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
	entity back_and_forward is 
			port (stm_clock, restN : in std_logic;
				output_back_and_forward                : out std_logic_vector(2 downto 0));
    end entity;
	
library ieee;
use ieee.std_logic_1164.all;
	entity mux is 
	port(mux_from_rec, mux_from_bafo,mux_from_dir : in std_logic_vector(2 downto 0); --mux_from_cir
		 reset 									  : in std_logic;
		 chooseTrack                              : in std_logic_vector(1 downto 0);
		 output                                   : out std_logic_vector(2 downto 0)
		 );
    end entity;
	
	
	------architecture for rectangle STM------
	
	architecture arc_rec of rec_road is
		type state_type is (rac_state1,rac_state2, rac_state3, rac_state4, rac_state5, rac_state6);
		signal state, next_state : state_type;
		begin
		
		  --- state machine process ---
		  
		--move from next state to state when clock raise up
		process(restN, stm_clock)
			begin 
				if restN = '0' then --reset=0 --> reset off
					state <= rac_state1;
				elsif rising_edge(stm_clock) then
					state <= next_state; 
				end if;
		end process;

	  --intialize next state and vector s

		process(state)
		begin
			case state is

			  when rac_state1 =>
					output_rec <= "011";
					next_state <= rac_state2;

			  when rac_state2 =>
				   output_rec <= "011";
				  next_state <= rac_state3;

			 when rac_state3 =>
				next_state <= rac_state4;
				 output_rec <= "001";
			 when rac_state4 =>
				next_state <= rac_state5;
				 output_rec <= "011";

			 when rac_state5 =>
				next_state <= rac_state6;
				output_rec <="011";	

			 when rac_state6 =>
				next_state <=rac_state1;
				output_rec <= "001";
	end case;
	end process;

	end arc_rec;

----------------------------------------------------------------------------
	-- architecture arc_cir of circaul_road is
		-- type state_type is (circ_state); --not need
		-- signal state, next_state : state_type;	--check
		-- begin 
				  ---- state machine process ---
		-- process(restN, stm_clock)
			-- begin 
				-- if restN = '0' then
					-- state <= circ_state;
				-- elsif rising_edge(stm_clock) then
					-- state <= next_state; 
				-- end if;
		-- end process;
		
		-- process(state)
		-- begin
		-- next_state <=circ_state;
		 -- s<="001";
		-- end process;
	-- end arc_cir;
-------------------------------------------------------------------------------

	------architecture for back_and_forward STM------

	architecture arc_bafo of back_and_forward is
		type state_type is (BaF_state1, BaF_state2, BaF_state3, BaF_state4, BaF_state5, BaF_state6);
		signal state, next_state : state_type;
				--move from next state to state when clock raise up
			begin
		process(restN, stm_clock)
			begin 
				if restN = '0' then --reset=0 --> reset off
					state <= BaF_state1;
				elsif rising_edge(stm_clock) then
					state <= next_state; 
				end if;
		end process;

		process(state)
			begin
				case state is
					when BaF_state1 =>
								
							next_state <= BaF_state2;
							output_back_and_forward <= "011";

					when BaF_state2 =>
							
							next_state <= BaF_state3;
							output_back_and_forward <= "011";

					when BaF_state3 =>
							
							next_state <= BaF_state4;
							output_back_and_forward <= "011";

					when BaF_state4 =>
								
							next_state <= BaF_state5;
							output_back_and_forward <= "100";

					when BaF_state5 =>
							next_state <= BaF_state6;
							output_back_and_forward <= "100";

					when BaF_state6 =>
							next_state <=BaF_state1;
							output_back_and_forward <= "100";
				end case;		
		
	end process;	
	end arc_bafo;

	------architecture for mux STM------

	architecture arc_mux of mux is
	signal temp :  std_logic_vector (2 downto 0);
	begin
	with chooseTrack select
	
	temp<=	mux_from_rec when  "01",
			mux_from_bafo when "11",
			"001" when  "10",   --mux_from_cir, -->  temp<= mux_from_cir when  "10".
			 --We input the stm of circular const number and not stm, beacuse the circular road just turn right
			mux_from_dir when  "00", --manual control
			"000" when others;
	
	--check if has a reset or not
	output<=temp when reset='1'
			else "000"; --means has a reset=0
	
	end arc_mux;


		
		
		

	