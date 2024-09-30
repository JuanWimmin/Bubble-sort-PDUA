library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ROM is
    Port ( cs, rd, iom : in std_logic;
           dir         : in std_logic_vector(6 downto 0);
           data        : out std_logic_vector(7 downto 0));
end ROM;

architecture Behavioral of ROM is
begin
process(cs, rd, dir)
begin

if cs = '1' and rd = '0' and iom = '1' then
       case dir is
       when "0000000" => data <= "01010000";  -- 0x00 JMP MAIN
       when "0000001" => data <= "00000011";  -- 0x01 MAIN (0x03)
       when "0000010" => data <= "00011000";  -- 0x02 MOV ACC,CTE (Inicializar bucle externo)
       when "0000011" => data <= "00000111";  -- 0x03 CTE (7 - número de pasadas)
       when "0000100" => data <= "00110000";  -- 0x04 MOV [0x08],ACC
       when "0000101" => data <= "00001000";  -- 0x05 DIR (0x08)
		 
		 --Bucle externo
       when "0000110" => data <= "00011000";  -- 0x06 MOV ACC,CTE (Inicializar bucle interno)
       when "0000111" => data <= "00000000";  -- 0x07 CTE (0 - índice inicial)
       when "0001000" => data <= "00110000";  -- 0x08 MOV [0x09],ACC
       when "0001001" => data <= "00001001";  -- 0x09 DIR (0x09)
		 --Bucle interno
       when "0001010" => data <= "00101000";  -- 0x0A MOV DPTR,ACC
       when "0001011" => data <= "00100000";  -- 0x0B MOV ACC,[DPTR]
       when "0001100" => data <= "00010000";  -- 0x0C MOV A,ACC
       when "0001101" => data <= "00001000";  -- 0x0D MOV ACC,DPTR
       when "0001110" => data <= "01001000";  -- 0x0E ADD ACC,CTE
       when "0001111" => data <= "00000001";  -- 0x0F CTE (1)
       when "0010000" => data <= "00101000";  -- 0x10 MOV DPTR,ACC
       when "0010001" => data <= "00100000";  -- 0x11 MOV ACC,[DPTR]
       when "0010010" => data <= "10011000";  -- 0x12 CMP ACC,A
       when "0010011" => data <= "01101000";  -- 0x13 JC SKIP_SWAP
       when "0010100" => data <= "00011001";  -- 0x14 DIR (0x19)
       when "0010101" => data <= "10100000";  -- 0x15 XCHG ACC,[DPTR]
       when "0010110" => data <= "00110000";  -- 0x16 MOV [DPTR],A
       when "0010111" => data <= "00100000";  -- 0x17 MOV ACC,[0x09]
       when "0011000" => data <= "00001001";  -- 0x18 DIR (0x09)
       when "0011001" => data <= "01001000";  -- 0x19 ADD ACC,CTE
       when "0011010" => data <= "00000001";  -- 0x1A CTE (1)
       when "0011011" => data <= "00110000";  -- 0x1B MOV [0x09],ACC
       when "0011100" => data <= "00001001";  -- 0x1C DIR (0x09)
       when "0011101" => data <= "00010000";  -- 0x1D MOV A,ACC
       when "0011110" => data <= "00100000";  -- 0x1E MOV ACC,[0x08]
       when "0011111" => data <= "00001000";  -- 0x1F DIR (0x08)
       when "0100000" => data <= "10011000";  -- 0x20 CMP A,ACC
       when "0100001" => data <= "01101000";  -- 0x21 JC INNER_LOOP
       when "0100010" => data <= "00001010";  -- 0x22 DIR (0x0A)
       when "0100011" => data <= "00100000";  -- 0x23 MOV ACC,[0x08]
       when "0100100" => data <= "00001000";  -- 0x24 DIR (0x08)
		-- Continuar bucle externo
       when "0100101" => data <= "01001000";  -- 0x25 ADD ACC,CTE
       when "0100110" => data <= "11111111";  -- 0x26 CTE (-1)
       when "0100111" => data <= "00110000";  -- 0x27 MOV [0x08],ACC
       when "0101000" => data <= "00001000";  -- 0x28 DIR (0x08)
       when "0101001" => data <= "01011000";  -- 0x29 JZ END
       when "0101010" => data <= "00101111";  -- 0x2A DIR (0x2F)
       when "0101011" => data <= "01010000";  -- 0x2B JMP OUTER_LOOP
       when "0101100" => data <= "00000110";  -- 0x2C DIR (0x06)
       when "0101101" => data <= "01010000";  -- 0x2D END: JMP END
       when "0101110" => data <= "00101101";  -- 0x2E DIR (0x2D)
       when "0101111" => data <= "00000000";  -- 0x2F (Unused)
       when others => data <= (others => 'X'); 
       end case;
else data <= (others => 'Z');
end if;  
end process;
end Behavioral;
