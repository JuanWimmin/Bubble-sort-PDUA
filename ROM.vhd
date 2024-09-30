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
       when "0000001" => data <= "00001010";  -- 0x01 MAIN (0x0A)
       when "0000010" => data <= "00011000";  -- 0x02 RAI Vector de Interrupcion (apunta a la ISR)

       -- Inicializar los 8 números en RAM
       when "0000011" => data <= "00011000";  -- 0x03 MOV ACC,CTE
       when "0000100" => data <= "00000101";  -- 0x04 CTE (5)
       when "0000101" => data <= "00110000";  -- 0x05 MOV [0x00],ACC
       when "0000110" => data <= "00000000";  -- 0x06 DIR (0x00)
       when "0000111" => data <= "00011000";  -- 0x07 MOV ACC,CTE
       when "0001000" => data <= "11111110";  -- 0x08 CTE (-2)
       when "0001001" => data <= "00110000";  -- 0x09 MOV [0x01],ACC
       when "0001010" => data <= "00000001";  -- 0x0A DIR (0x01)
       when "0001011" => data <= "00011000";  -- 0x0B MOV ACC,CTE
       when "0001100" => data <= "00000111";  -- 0x0C CTE (7)
       when "0001101" => data <= "00110000";  -- 0x0D MOV [0x02],ACC
       when "0001110" => data <= "00000010";  -- 0x0E DIR (0x02)
       when "0001111" => data <= "00011000";  -- 0x0F MOV ACC,CTE
       when "0010000" => data <= "00000001";  -- 0x10 CTE (1)
       when "0010001" => data <= "00110000";  -- 0x11 MOV [0x03],ACC
       when "0010010" => data <= "00000011";  -- 0x12 DIR (0x03)
       when "0010011" => data <= "00011000";  -- 0x13 MOV ACC,CTE
       when "0010100" => data <= "11111100";  -- 0x14 CTE (-4)
       when "0010101" => data <= "00110000";  -- 0x15 MOV [0x04],ACC
       when "0010110" => data <= "00000100";  -- 0x16 DIR (0x04)
       when "0010111" => data <= "00011000";  -- 0x17 MOV ACC,CTE
       when "0011000" => data <= "00000000";  -- 0x18 CTE (0)
       when "0011001" => data <= "00110000";  -- 0x19 MOV [0x05],ACC
       when "0011010" => data <= "00000101";  -- 0x1A DIR (0x05)
       when "0011011" => data <= "00011000";  -- 0x1B MOV ACC,CTE
       when "0011100" => data <= "00001001";  -- 0x1C CTE (9)
       when "0011101" => data <= "00110000";  -- 0x1D MOV [0x06],ACC
       when "0011110" => data <= "00000110";  -- 0x1E DIR (0x06)
       when "0011111" => data <= "00011000";  -- 0x1F MOV ACC,CTE
       when "0100000" => data <= "11111011";  -- 0x20 CTE (-5)
       when "0100001" => data <= "00110000";  -- 0x21 MOV [0x07],ACC
       when "0100010" => data <= "00000111";  -- 0x22 DIR (0x07)

       -- Iniciar ordenamiento
       when "0100011" => data <= "00011000";  -- 0x23 MOV ACC,CTE (Inicializar bucle externo)
       when "0100100" => data <= "00000111";  -- 0x24 CTE (7 - número de pasadas)
       when "0100101" => data <= "00110000";  -- 0x25 MOV [0x08],ACC
       when "0100110" => data <= "00001000";  -- 0x26 DIR (0x08)
		 
       -- Bucle externo
       when "0100111" => data <= "00011000";  -- 0x27 MOV ACC,CTE (Inicializar bucle interno)
       when "0101000" => data <= "00000000";  -- 0x28 CTE (0 - índice inicial)
       when "0101001" => data <= "00110000";  -- 0x29 MOV [0x09],ACC
       when "0101010" => data <= "00001001";  -- 0x2A DIR (0x09)
       -- Bucle interno
       when "0101011" => data <= "00101000";  -- 0x2B MOV DPTR,ACC
       when "0101100" => data <= "00100000";  -- 0x2C MOV ACC,[DPTR]
       when "0101101" => data <= "00010000";  -- 0x2D MOV A,ACC
       when "0101110" => data <= "00001000";  -- 0x2E MOV ACC,DPTR
       when "0101111" => data <= "01001000";  -- 0x2F ADD ACC,CTE
       when "0110000" => data <= "00000001";  -- 0x30 CTE (1)
       when "0110001" => data <= "00101000";  -- 0x31 MOV DPTR,ACC
       when "0110010" => data <= "00100000";  -- 0x32 MOV ACC,[DPTR]
       when "0110011" => data <= "10011000";  -- 0x33 CMP ACC,A
       when "0110100" => data <= "01101000";  -- 0x34 JC SKIP_SWAP
       when "0110101" => data <= "00111001";  -- 0x35 DIR (0x39)
       when "0110110" => data <= "10100000";  -- 0x36 XCHG ACC,[DPTR]
       when "0110111" => data <= "00110000";  -- 0x37 MOV [DPTR],A
       when "0111000" => data <= "00100000";  -- 0x38 MOV ACC,[0x09]
       when "0111001" => data <= "00001001";  -- 0x39 DIR (0x09)
       when "0111010" => data <= "01001000";  -- 0x3A ADD ACC,CTE
       when "0111011" => data <= "00000001";  -- 0x3B CTE (1)
       when "0111100" => data <= "00110000";  -- 0x3C MOV [0x09],ACC
       when "0111101" => data <= "00001001";  -- 0x3D DIR (0x09)
       when "0111110" => data <= "00010000";  -- 0x3E MOV A,ACC
       when "0111111" => data <= "00100000";  -- 0x3F MOV ACC,[0x08]
       when "1000000" => data <= "00001000";  -- 0x40 DIR (0x08)
       when "1000001" => data <= "10011000";  -- 0x41 CMP A,ACC
       when "1000010" => data <= "01101000";  -- 0x42 JC INNER_LOOP
       when "1000011" => data <= "00101011";  -- 0x43 DIR (0x2B)
       when "1000100" => data <= "00100000";  -- 0x44 MOV ACC,[0x08]
       when "1000101" => data <= "00001000";  -- 0x45 DIR (0x08)
       -- Continuar bucle externo
       when "1000110" => data <= "01001000";  -- 0x46 ADD ACC,CTE
       when "1000111" => data <= "11111111";  -- 0x47 CTE (-1)
       when "1001000" => data <= "00110000";  -- 0x48 MOV [0x08],ACC
       when "1001001" => data <= "00001000";  -- 0x49 DIR (0x08)
       when "1001010" => data <= "01011000";  -- 0x4A JZ END
       when "1001011" => data <= "01001111";  -- 0x4B DIR (0x4F)
       when "1001100" => data <= "01010000";  -- 0x4C JMP OUTER_LOOP
       when "1001101" => data <= "00100111";  -- 0x4D DIR (0x27)
       when "1001110" => data <= "01010000";  -- 0x4E END: JMP END
       when "1001111" => data <= "01001110";  -- 0x4F DIR (0x4E)
       when others => data <= (others => 'X'); 
       end case;
else data <= (others => 'Z');
end if;  
end process;
end Behavioral;
