        library ieee;
        use ieee.std_logic_1164.all;
        use ieee.std_logic_unsigned.all;

        entity top_level_of_wheels is
        
                --port of top level

               port(
                clk,Estop, Reset: in std_logic; -- The clock of system and stop mechanism
                track: in std_logic_vector (1 downto 0); -- The track of car
                dir: in std_logic_vector (2 downto 0); -- Direction that car can move
                outputFromEngines: out std_logic_vector (7 downto 0)    
                );
        end entity top_level_of_wheels;

        architecture arc_top_level_of_wheels of top_level_of_wheels is
        
        --clk divide that convert the clock to second
        component clk_div is
           port (clk, rst    : in  std_logic;
                 clk_divided : out std_logic );
        end component clk_div;
        
        --component of state machine
        component stm is 
          port( 
            stm_clock, restN : in std_logic;
            track            : in std_logic_vector(1 downto 0);
            dir              : in std_logic_vector(2 downto 0);
            s                : out std_logic_vector(2 downto 0)
          );
        end component stm;

        
        --component of engine
        component engine is 
          port(dir : in std_logic_vector (2 downto 0);
               output: out std_logic_vector (7 downto 0);
               Estop : in std_logic); -- vector length 2 bit, output
        end component;
        
        
        --signal that uses for a net between component
        signal clk_divided: std_logic ; --clock that keep puls in system that a net
        signal output_stm: std_logic_vector (2 downto 0);  
      
        begin
                --connected
                U1 :  clk_div port map (clk=>clk, rst=>Reset, clk_divided=>clk_divided);
                U2 :  stm port map (stm_clock => clk_divided,track=>track,dir=>dir,s=>output_stm, restN=>Reset);
                
                --All engine connect from output of stm to enigne   
                U3 :  engine port map (dir=>output_stm, Estop=>Estop, output=> outputFromEngines);



        end architecture arc_top_level_of_wheels;
