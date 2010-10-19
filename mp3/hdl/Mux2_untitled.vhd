--
-- VHDL Architecture ece411.Mux2.untitled
--
-- Created:
--          by - jconroy2.stdt (eelnx35.ews.illinois.edu)
--          at - 09:35:25 10/08/10
--
-- using Mentor Graphics HDL Designer(TM) 2005.3 (Build 75)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

LIBRARY ece411;
USE ece411.LC3b_types.all;

ENTITY Mux2 IS
   PORT( 
      A   : IN     std_logic;
      B   : IN     std_logic;
      Sel : IN     std_logic;
      F   : OUT    std_logic
   );

-- Declarations

END Mux2 ;

--
ARCHITECTURE untitled OF Mux2 IS
BEGIN
	Process (A,B,Sel)
		variable state : std_logic;
	begin
		case Sel is
			when '0' =>
				state := A;
			when '1' =>
				state := B;
			when others =>
				state := 'X';
		end case;
		F <= state after delay_MUX2;
	end process;
END ARCHITECTURE untitled;

