--
-- VHDL Architecture ece411.nand2in.untitled
--
-- Created:
--          by - hwoods2.stdt (eelnx24.ews.illinois.edu)
--          at - 22:31:11 10/07/10
--
-- using Mentor Graphics HDL Designer(TM) 2005.3 (Build 75)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.NUMERIC_STD.all;

LIBRARY ece411;
USE ece411.LC3b_types.all;

ENTITY nand2in IS
   PORT( 
      A : IN     std_logic;
      B : IN     std_logic;
      F : OUT    std_logic
   );

-- Declarations

END nand2in ;

--
ARCHITECTURE untitled OF nand2in IS
BEGIN
  NAND2proc: process(A,B)
     variable result : std_logic;
     BEGIN
          IF ((A='1') AND (B='1')) THEN
            result := '0';
          ELSE
            result := '1';
          END IF;
     F <= result after 1ns;           
  END PROCESS;
END ARCHITECTURE untitled;

