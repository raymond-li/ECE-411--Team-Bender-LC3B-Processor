ARCHITECTURE UNTITLED OF MEMORY IS
SIGNAL PRE_MRESP_H : STD_LOGIC;
SIGNAL PRE_DATAIN : LC3B_WORD;
BEGIN
  -------------------------------------------------------------------
  VHDL_MEMORY : PROCESS (RESET_L, MREAD_L, MWRITEH_L, MWRITEL_L) 
  -------------------------------------------------------------------
  VARIABLE MEM : MEMORY_ARRAY_64K;
  VARIABLE INT_OLD_ADDRESS : INTEGER;
  VARIABLE INT_ADDRESS : INTEGER;
  BEGIN
	  INT_ADDRESS := TO_INTEGER(UNSIGNED('0' & ADDRESS(11 DOWNTO 1) & '0'));
	  IF RESET_L = '0' THEN
		  PRE_MRESP_H <= '0';
		  MYDRAMINIT_64K(MEM);
    ELSIF (RESET_L = 'U') AND (MREAD_L = 'U') AND (MWRITEH_L = 'U') AND (MWRITEL_L = 'U') THEN
      -- resetting
      ASSERT TRUE;
	  ELSE
		  IF ((INT_ADDRESS >= 0) AND (INT_ADDRESS <= 4095)) THEN
			  IF (MWRITEH_L'EVENT AND (MWRITEH_L = '0') AND (MWRITEL_L'LAST_VALUE /= '1')) THEN
				  ASSERT FALSE 
				  REPORT "MEMORY WRITE HI-LO TIMING ERROR"
				  SEVERITY FAILURE;
			  END IF;
			  IF (MWRITEL_L'EVENT AND (MWRITEL_L = '0') AND (MWRITEH_L'LAST_VALUE /= '1')) THEN
				  ASSERT FALSE 
				  REPORT "MEMORY WRITE LO-HI TIMING ERROR"
				  SEVERITY FAILURE;
			  END IF;
			  IF (MWRITEL_L'EVENT AND (MWRITEL_L'LAST_VALUE = '0') AND (INT_ADDRESS /= INT_OLD_ADDRESS)) THEN
				  ASSERT FALSE 
				  REPORT "MEMORY WRITE LO TIMING ERROR"
				  SEVERITY FAILURE;
			  END IF;
			  IF (MWRITEH_L'EVENT AND (MWRITEH_L'LAST_VALUE = '0') AND (INT_ADDRESS /= INT_OLD_ADDRESS)) THEN
				  ASSERT FALSE 
				  REPORT "MEMORY WRITE HI TIMING ERROR"
				  SEVERITY FAILURE;
			  END IF;
			  IF (MREAD_L'EVENT AND (MREAD_L'LAST_VALUE = '0') AND (INT_ADDRESS /= INT_OLD_ADDRESS)) THEN
				  ASSERT FALSE 
				  REPORT "MEMORY READ TIMING ERROR"
				  SEVERITY FAILURE;
			  END IF;
			  IF (MREAD_L = '0' AND MWRITEL_L = '1' AND MWRITEH_L = '1') THEN
				  PRE_DATAIN(7 DOWNTO 0) <= MEM(INT_ADDRESS);             
				  PRE_DATAIN(15 DOWNTO 8) <= MEM(INT_ADDRESS + 1);             
				  PRE_MRESP_H <= '1' AFTER 0 NS, '0' AFTER CLOCK_PERIOD;
					INT_OLD_ADDRESS := INT_ADDRESS;
			  ELSIF ((MWRITEL_L = '0' OR MWRITEH_L = '0') AND MREAD_L = '1') THEN
				  IF (MWRITEL_L = '0') THEN
					  MEM(INT_ADDRESS) := DATAOUT(7 DOWNTO 0);
				  END IF;
				  IF (MWRITEH_L = '0') THEN
					  MEM(INT_ADDRESS + 1) := DATAOUT(15 DOWNTO 8);
				  END IF;
				  IF(MWRITEH_L = '0' OR MWRITEL_L = '0') THEN
					  PRE_MRESP_H <= '1' AFTER 0 NS, '0' AFTER CLOCK_PERIOD;
				  END IF;
					INT_OLD_ADDRESS := INT_ADDRESS;
				ELSIF (RESET_L'event AND ((RESET_L = '0') OR (RESET_L = '1'))) THEN
					-- reset_l signal going inactive
					ASSERT TRUE;
				ELSIF (MREAD_L'event AND ((MREAD_L = '1') AND (MREAD_L'LAST_VALUE = '0'))) THEN
					-- read_l signal going inactive
					ASSERT TRUE;
				ELSIF (MWRITEL_L'event AND ((MWRITEL_L = '1') AND (MWRITEL_L'LAST_VALUE = '0'))) THEN
					-- read_l signal going inactive
					ASSERT TRUE;
				ELSIF (MWRITEH_L'event AND ((MWRITEH_L = '1') AND (MWRITEH_L'LAST_VALUE = '0'))) THEN
					-- read_l signal going inactive
					ASSERT TRUE;
				ELSE
				  ASSERT FALSE 
				  REPORT "MEMORY WRITE"
				  SEVERITY FAILURE;
			  END IF;
		  ELSE
			  ASSERT FALSE
			  REPORT "INVALID ADDRESS"
			  SEVERITY FAILURE;
		  END IF;
	  END IF;
  END PROCESS VHDL_MEMORY;
  MRESP_H <= PRE_MRESP_H'DELAYED(DELAY_MP2_MEM);
  DATAIN <= PRE_DATAIN'DELAYED(DELAY_MP2_MEM);
END ARCHITECTURE untitled;