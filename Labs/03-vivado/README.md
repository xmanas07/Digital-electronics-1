# Digital-electronics-1

## úkol 1: Table with connection of 16 slide switches and 16 LEDs

| **LED** | **Connection** | **Switch** | **Connection** | 
| :-: | :-: | :-: | :-: |
| LED0 | H17 | SW0 | J15 |
| LED1 | K15 | SW1 | L16 |
| LED2 | J13 | SW2 | M13 |
| LED3 | N14 | SW3 | R15 |
| LED4 | R18 | SW4 | R17 |
| LED5 | V17 | SW5 | T18 |
| LED6 | U17 | SW6 | U18 |
| LED7 | U16 | SW7 | R13 |
| LED8 | V16 | SW8 | T8 |
| LED9 | T15 | SW9 | U8 |
| LED10 | U14 | SW10 | R16 |
| LED11 | T16 | SW11 | T13 |
| LED12 | V15 | SW12 | H6 |
| LED13 | V14 | SW13 | U12 |
| LED14 | V12 | SW14 | U11 |
| LED15 | V11 | SW15 | V10 |

## úkol 2: 2bit wide 4-to-1 multiplexer

### VHDL architecture (`mux_2bit_4to1.vhd`)

```vhdl
architecture Behavioral of mux_2bit_4to1 is
begin

    f_o <= a_i when sel_i = "00" else
           b_i when sel_i = "01" else
           c_i when sel_i = "10" else
           d_i;

end Behavioral;
```
### VHDL stimulus proces (`tb_mux_2bit_4to1.vhd`)

```vhdl
p_stimulus : process
    begin
        -- Report a note at the begining of stimulus process
        report "Stimulus process started" severity note;

        s_a <= "00"; s_b <= "01"; s_c <= "10"; s_d <= "11"; s_sel <= "00"; 
        wait for 250 ns;

        s_a <= "00"; s_b <= "01"; s_c <= "10"; s_d <= "11"; s_sel <= "00";
        s_sel <= "01";
        wait for 250 ns;
  
        s_a <= "00"; s_b <= "01"; s_c <= "10"; s_d <= "11"; s_sel <= "00";      
        s_sel <= "10";
        wait for 250 ns;
   
        s_a <= "00"; s_b <= "01"; s_c <= "10"; s_d <= "11"; s_sel <= "00";
        s_sel <= "11";
        wait for 250 ns;

        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;
```
### Screenshot with waveforms

![Screenshot](images/output_4bit1_Mux.png)

## úkol 3: Vivado tutorial

#### 1. krok

![Screenshot](images/01.png)

#### 2. krok

![Screenshot](images/02.png)

#### 3. krok

![Screenshot](images/03.png)

#### 4. krok

![Screenshot](images/04.png)

#### 5. krok

![Screenshot](images/05.png)

#### 6. krok

![Screenshot](images/06.png)

#### 7. krok

![Screenshot](images/07.png)

#### 8. krok

![Screenshot](images/08.png)

#### 9. krok

![Screenshot](images/09.png)

#### 10. krok

![Screenshot](images/10.png)

#### 11. krok

![Screenshot](images/11.png)

#### 12. krok

![Screenshot](images/12.png)

#### 13. krok

![Screenshot](images/13.png)

#### 14. krok

![Screenshot](images/14.png)
