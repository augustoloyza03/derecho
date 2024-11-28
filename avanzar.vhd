-- Quartus II VHDL Template
-- Four-State Moore State Machine

-- A Moore machine's outputs are dependent only on the current state.
-- The output is written only when the state changes.  (State
-- transitions are synchronous.)

library ieee;
use ieee.std_logic_1164.all;

entity avanzar is

	port(
		clk		 : in	std_logic;
		I,D	 : in	std_logic;
		reset	 : in	std_logic;
		MI1,MI0 : OUT STD_LOGIC; 
      MD1,MD0 : OUT STD_LOGIC
	);

end entity;

architecture rtl of avanzar is

	-- Build an enumerated type for the state machine
	type state_type is (ocioso,avanzar, CD, CI);    --CD 'corrijo hacia la derecha'; CI 'corrijo hacia la izquierda'

	-- Register to hold the current state
	signal state   : state_type;
   signal MI : std_logic_vector (1 downto 0);
	signal MD : std_logic_vector (1 downto 0);
begin

	-- Logic to advance to the next state
	process (clk, reset,I,D)
	begin
		if reset = '0' then
			state <= ocioso;
		elsif (rising_edge(clk)) then
			case state is
				when ocioso=>
						state <= avanzar;
				when Avanzar=>
					if I= '1' and D='0' then
						state <= CI;       -----deberia ser CD pero sospecho que los canales del adc estan invertidos
					elsif I= '0' and D='1' then
						state <= CD;       -----deberia ser CI pero sospecho que los canales del adc estan invertidos
					else
					   state <= avanzar;
					end if;
				when CI=>
					if  D= '0' then
						state <= avanzar;
					else
						state <= CI;
					end if;
				when CD =>
					if I= '0' then
						state <= avanzar;
					else
						state <= CD;
					end if;
			end case;
		end if;
	end process;

	-- Output depends solely on the current state
	process (state)
	begin
		case state is
			when ocioso =>
				MI <= "00";MD <= "00";
			when avanzar =>
				MI <= "01";MD <= "01";
			when CI =>
				MI <= "00";MD <= "01";
			when CD =>
			   MI <= "01";MD <= "00";
		end case;
	end process;
MI1<= MI(1); MI0<= MI(0);MD1<= MD(1);MD0<= MD(0);
end rtl;
