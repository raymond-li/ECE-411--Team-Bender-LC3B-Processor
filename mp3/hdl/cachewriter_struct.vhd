-- VHDL Entity ece411.CacheWriter.symbol
--
-- Created:
--          by - hwoods2.stdt (gllnx26.ews.illinois.edu)
--          at - 05:11:13 10/08/10
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2005.3 (Build 75)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.NUMERIC_STD.all;

LIBRARY ece411;
USE ece411.LC3b_types.all;

ENTITY CacheWriter IS
   PORT( 
      MWH      : IN     std_logic;
      MWL      : IN     std_logic;
      Sel      : IN     std_logic;
      lineData : IN     LC3b_word;
      newData  : IN     LC3b_word;
      newword  : OUT    LC3b_word
   );

-- Declarations

END CacheWriter ;

--
-- VHDL Architecture ece411.CacheWriter.struct
--
-- Created:
--          by - hwoods2.stdt (gllnx26.ews.illinois.edu)
--          at - 05:11:13 10/08/10
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2005.3 (Build 75)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.NUMERIC_STD.all;

LIBRARY ece411;
USE ece411.LC3b_types.all;

LIBRARY ece411;

ARCHITECTURE struct OF CacheWriter IS

   -- Architecture declarations

   -- Internal signal declarations
   SIGNAL F        : std_logic;
   SIGNAL F1       : std_logic;
   SIGNAL HByteSel : std_logic;
   SIGNAL Hnewword : LC3b_byte;
   SIGNAL LBSel    : std_logic;
   SIGNAL hF       : LC3B_BYTE;
   SIGNAL hF1      : LC3B_BYTE;
   SIGNAL lf       : LC3B_BYTE;
   SIGNAL lf1      : LC3B_BYTE;
   SIGNAL lnewword : LC3B_BYTE;


   -- Component Declarations
   COMPONENT And2in
   PORT (
      A : IN     std_logic ;
      B : IN     std_logic ;
      F : OUT    std_logic 
   );
   END COMPONENT;
   COMPONENT ByteMux2
   PORT (
      A   : IN     LC3b_byte ;
      B   : IN     LC3b_byte ;
      Sel : IN     std_logic ;
      F   : OUT    LC3b_byte 
   );
   END COMPONENT;
   COMPONENT NotGate
   PORT (
      A : IN     std_logic ;
      F : OUT    std_logic 
   );
   END COMPONENT;
   COMPONENT WordComb
   PORT (
      hA : IN     LC3B_BYTE ;
      lA : IN     LC3B_BYTE ;
      F  : OUT    LC3b_word 
   );
   END COMPONENT;
   COMPONENT WordSplitter
   PORT (
      A  : IN     LC3b_word ;
      hF : OUT    LC3B_BYTE ;
      lf : OUT    LC3B_BYTE 
   );
   END COMPONENT;

   -- Optional embedded configurations
   -- pragma synthesis_off
   FOR ALL : And2in USE ENTITY ece411.And2in;
   FOR ALL : ByteMux2 USE ENTITY ece411.ByteMux2;
   FOR ALL : NotGate USE ENTITY ece411.NotGate;
   FOR ALL : WordComb USE ENTITY ece411.WordComb;
   FOR ALL : WordSplitter USE ENTITY ece411.WordSplitter;
   -- pragma synthesis_on


BEGIN

   -- Instance port mappings.
   U_2 : And2in
      PORT MAP (
         A => F,
         B => Sel,
         F => HByteSel
      );
   U_3 : And2in
      PORT MAP (
         A => Sel,
         B => F1,
         F => LBSel
      );
   U_0 : ByteMux2
      PORT MAP (
         A   => hF1,
         B   => hF,
         Sel => HByteSel,
         F   => Hnewword
      );
   U_1 : ByteMux2
      PORT MAP (
         A   => lf,
         B   => lf1,
         Sel => LBSel,
         F   => lnewword
      );
   U_5 : NotGate
      PORT MAP (
         A => MWH,
         F => F
      );
   U_6 : NotGate
      PORT MAP (
         A => MWL,
         F => F1
      );
   U_4 : WordComb
      PORT MAP (
         hA => Hnewword,
         lA => lnewword,
         F  => newword
      );
   lineDsplitter : WordSplitter
      PORT MAP (
         A  => lineData,
         hF => hF1,
         lf => lf
      );
   newDSplitter : WordSplitter
      PORT MAP (
         A  => newData,
         hF => hF,
         lf => lf1
      );

END struct;
