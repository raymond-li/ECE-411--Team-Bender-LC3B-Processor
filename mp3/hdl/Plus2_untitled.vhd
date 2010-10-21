--
-- VHDL Architecture ece411.Plus2.untitled
--
-- Created:
--          by - hwoods2.stdt (eelnx18.ews.illinois.edu)
--          at - 14:57:49 08/29/10
--
-- using Mentor Graphics HDL Designer(TM) 2005.3 (Build 75)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.NUMERIC_STD.all;

LIBRARY ece411;
USE ece411.LC3b_types.all;

ENTITY Plus2 IS
   PORT( 
      PCout      : IN     LC3b_word;
      clk        : IN     std_logic;
      PCPlus2out : OUT    LC3b_word
   );

-- Declarations

END Plus2 ;

--
ARCHITECTURE UNTITLED OF PLUS2 IS
BEGIN
	VHDL_ADD_2 : PROCESS (PCOUT)
	BEGIN  -- PROCESS
		PCPLUS2OUT <= STD_LOGIC_VECTOR(UNSIGNED(PCOUT) + 2 ) AFTER DELAY_ADDER;
	END PROCESS;
END UNTITLED;

