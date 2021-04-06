# Digital-electronics-1

## úkol 1: Preparation tasks
### Filled out state table



   | **Input P** | `0` | `0` | `1` | `1` | `0` | `1` | `0` | `1` | `1` | `1` | `1` | `0` | `0` | `1` | `1` | `1` |
| :-- | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: |
| **Clock** | ![rising](images/eq_uparrow.png) | ![rising](images/eq_uparrow.png) | ![rising](images/eq_uparrow.png) | ![rising](images/eq_uparrow.png) | ![rising](images/eq_uparrow.png) | ![rising](images/eq_uparrow.png) | ![rising](images/eq_uparrow.png) | ![rising](images/eq_uparrow.png) | ![rising](images/eq_uparrow.png) | ![rising](images/eq_uparrow.png) | ![rising](images/eq_uparrow.png) | ![rising](images/eq_uparrow.png) | ![rising](images/eq_uparrow.png) | ![rising](images/eq_uparrow.png) | ![rising](images/eq_uparrow.png) | ![rising](images/eq_uparrow.png) |
| **State** | A | A | B | C | C | D | A | B | C | D | B | B | B | C | D | B |
| **Output R** | `0` | `0` | `0` | `0` | `0` | `1` | `0` | `0` | `0` | `1` | `0` | `0` | `0` | `0` | `1` | `0` |

### Connection of RGB LEDs on NExys A7 board

![LED_connection](images/LED_connection.png)


### Figure with connection of RGB LEDs on Nexys A7 board

| **RGB LED** | **Artix-7 pin names** | **Red** | **Yellow** | **Green** |
| :-: | :-: | :-: | :-: | :-: |
| LD16 | N15, M16, R12 | `1,0,0` | `1,1,0` | `0,1,0` |
| LD17 | N16, R11, G14 | `1,0,0` | `1,1,0` | `0,1,0` |


## úkol 2: Traffic light controller

### State diagram

![](images/diagram_trafic.png)

### p_traffic_fsm process (`tlc`)

```vhdl
    p_traffic_fsm : process(clk)
    begin
        if rising_edge(clk) then
            if (reset = '1') then       -- Synchronous reset
                s_state <= STOP1 ;      -- Set initial state
                s_cnt   <= c_ZERO;      -- Clear all bits

            elsif (s_en = '1') then
                -- Every 250 ms, CASE checks the value of the s_state 
                -- variable and changes to the next state according 
                -- to the delay value.
                case s_state is

                    -- If the current state is STOP1, then wait 1 sec
                    -- and move to the next GO_WAIT state.
                    when STOP1 =>
                        -- Count up to c_DELAY_1SEC
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            -- Move to the next state
                            s_state <= WEST_GO;
                            -- Reset local counter value
                            s_cnt   <= c_ZERO;
                        end if;

                    when WEST_GO =>
       
                        -- Count up to c_DELAY_4SEC
                        if (s_cnt < c_DELAY_4SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            -- Move to the next state
                            s_state <= WEST_WAIT;
                            -- Reset local counter value
                            s_cnt   <= c_ZERO;
                        end if;

                    when WEST_WAIT =>
                     
                        -- Count up to c_DELAY_2SEC
                        if (s_cnt < c_DELAY_2SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            -- Move to the next state
                            s_state <= STOP2;
                            -- Reset local counter value
                            s_cnt   <= c_ZERO;
                        end if;
                        
                    when STOP2 =>
                     
                        -- Count up to c_DELAY_1SEC
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            -- Move to the next state
                            s_state <= SOUTH_GO;
                            -- Reset local counter value
                            s_cnt   <= c_ZERO;
                        end if;   
                    
                    when SOUTH_GO =>
                       
                        -- Count up to c_DELAY_4SEC
                        if (s_cnt < c_DELAY_4SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            -- Move to the next state
                            s_state <= SOUTH_WAIT;
                            -- Reset local counter value
                            s_cnt   <= c_ZERO;
                        end if;
                        
                    when SOUTH_WAIT =>
                   
                        -- Count up to c_DELAY_2SEC
                        if (s_cnt < c_DELAY_2SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            -- Move to the next state
                            s_state <= STOP1;
                            -- Reset local counter value
                            s_cnt   <= c_ZERO;
                        end if;                      
                    -- It is a good programming practice to use the 
                    -- OTHERS clause, even if all CASE choices have 
                    -- been made. 
                    when others =>
                        s_state <= STOP1;

                end case;
            end if; -- Synchronous reset
        end if; -- Rising edge
    end process p_traffic_fsm;
```

### p_output_fsm process (`tlc`)

```vhdl
p_output_fsm : process(s_state)
    begin
        case s_state is
            when STOP1 =>
                south_o <= c_RED;    -- RED (RGB = 100)
                west_o  <= c_RED;   
            when WEST_GO =>
                south_o <= c_RED;
                west_o  <= c_GREEN;  -- GREEN (RGB = 010)

                -- WRITE YOUR CODE HERE
            when WEST_WAIT =>
                south_o <= c_RED;
                west_o  <= c_YELLOW; -- YELLOW (RGB = 110)
                
            when STOP2 =>
                south_o <= c_RED;
                west_o  <= c_RED;
                
            when SOUTH_GO =>
                south_o <= c_GREEN;
                west_o  <= c_RED;
                
            when SOUTH_WAIT =>
                south_o <= c_YELLOW;
                west_o  <= c_RED;    
            

            when others =>
                south_o <= c_RED;
                west_o  <= c_RED;
        end case;
    end process p_output_fsm;

```

### Screenshot with waveforms

![Screenshot](images/sim1.png)




## úkol 3: Flip-flops

## d_ff_arst

### p_d_ff_arst process (`d_ff_arst`)

```vhdl
    p_d_ff_arst : process (arst, clk)
    begin
        if  (arst = '1') then
            q       <= '0';
            q_bar   <= '1';
        elsif (rising_edge(clk))then
            q       <=  d;
            q_bar   <=  (not d);
            
        end if;
    end process p_d_latch;
```

### VHDL clock, reset and stimulus processes (`tb_d_ff_arst`)

```vhdl
p_clk_gen : process
    begin
        while now < 750 ns loop         -- 75 periods of 100MHz clock
            s_clk_100MHz <= '0';
            wait for c_CLK_100MHZ_PERIOD / 2;
            s_clk_100MHz <= '1';
            wait for c_CLK_100MHZ_PERIOD / 2;
        end loop;
        wait;
end process p_clk_gen;

p_reset_gen : process
    begin
        s_arst <= '0';
        wait for 21 ns;
        
      
        s_arst <= '1';
        wait for 51 ns;
       
        
        s_arst <= '0';
        wait for 41 ns;
        
        
        s_arst <= '1';
        wait for 60 ns;
       
        s_arst <= '0';
        wait;
end process p_reset_gen;
 p_stimulus : process
    begin
        report "Stimulus process started" severity note;
            s_d <= '0';
                      
            wait for 20ns;
            s_d <= '1';
            wait for 10ns;
            s_d <= '0';            
            wait for 10ns;
            s_d <= '0';                      
            wait for 10ns;
            s_d <= '1';
            wait for 10ns;
            s_d <= '0';
            wait for 10ns;
            s_d <= '1';
            wait for 10ns;
            s_d <= '0'; 
            wait for 10ns;
            s_d <= '1';
            wait for 10ns;
            s_d <= '0';
            wait for 10ns;
            s_d <= '1';
            wait for 10ns;
            s_d <= '0';
            wait for 10ns;
            s_d <= '1';
            wait for 10ns;
            s_d <= '0'; 
            wait for 10ns;
            s_d <= '1';
            wait for 10ns;
            s_d <= '0';
            wait for 10ns;
            s_d <= '1';
            wait for 10ns;
            s_d <= '0';
            wait for 10ns;
            s_d <= '1';
            wait for 10ns;
            s_d <= '0'; 
            wait for 10ns;
            s_d <= '1';
            wait for 10ns;
            s_d <= '0';
            wait for 10ns;
            s_d <= '1';
            wait for 10ns;
            s_d <= '0';
            wait for 10ns;
            s_d <= '1';
            wait for 10ns;
            s_d <= '0'; 
            wait for 10ns;
            s_d <= '1';
            wait for 10ns;
            s_d <= '0'; 
            wait for 10ns;
            s_d <= '1';
            wait for 10ns;
            s_d <= '0';
            wait for 10ns;
            s_d <= '1';
            wait for 10ns;
            s_d <= '0';
            wait for 10ns;
            s_d <= '1';
            wait for 10ns;
            s_d <= '0'; 
    
    report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;

```

### Screenshot with waveforms

![Screenshot](images/sim2.png)

## d_ff_rst

### p_d_ff_rst process (`d_ff_rst`)

```vhdl
p_d_ff_rst   : process (d, rst, clk)
    begin
        if rising_edge(clk) then
            if  (rst = '1') then
                q       <= '0';
                q_bar   <= '1';
            else
                q       <=  d;
                q_bar   <=  (not d);
            end if;
        end if;
end process p_d_ff_rst;
```

### VHDL clock, reset and stimulus processes (`tb_d_ff_rst`)

```vhdl
p_clk_gen : process
    begin
        while now < 750 ns loop         -- 75 periods of 100MHz clock
            s_clk_100MHz <= '0';
            wait for c_CLK_100MHZ_PERIOD / 2;
            s_clk_100MHz <= '1';
            wait for c_CLK_100MHZ_PERIOD / 2;
        end loop;
        wait;
 end process p_clk_gen;

p_reset_gen : process
    begin
        s_arst <= '0';
        wait for 21 ns;
        
      
        s_arst <= '1';
        wait for 51 ns;
       
        
        s_arst <= '0';
        wait for 41 ns;
        
        
        s_arst <= '1';
        wait for 60 ns;
       
        s_arst <= '0';
        wait;
end process p_reset_gen;
 p_stimulus : process
    begin
        report "Stimulus process started" severity note;
            s_d <= '0';
                      
            wait for 20ns;
            s_d <= '1';
            wait for 10ns;
            s_d <= '0';            
            wait for 10ns;
            s_d <= '0';                      
            wait for 10ns;
            s_d <= '1';
            wait for 10ns;
            s_d <= '0';
            wait for 10ns;
            s_d <= '1';
            wait for 10ns;
            s_d <= '0'; 
            wait for 10ns;
            s_d <= '1';
            wait for 10ns;
            s_d <= '0';
            wait for 10ns;
            s_d <= '1';
            wait for 10ns;
            s_d <= '0';
            wait for 10ns;
            s_d <= '1';
            wait for 10ns;
            s_d <= '0'; 
            wait for 10ns;
            s_d <= '1';
            wait for 10ns;
            s_d <= '0';
            wait for 10ns;
            s_d <= '1';
            wait for 10ns;
            s_d <= '0';
            wait for 10ns;
            s_d <= '1';
            wait for 10ns;
            s_d <= '0'; 
            wait for 10ns;
            s_d <= '1';
            wait for 10ns;
            s_d <= '0';
            wait for 10ns;
            s_d <= '1';
            wait for 10ns;
            s_d <= '0';
            wait for 10ns;
            s_d <= '1';
            wait for 10ns;
            s_d <= '0'; 
            wait for 10ns;
            s_d <= '1';
            wait for 10ns;
            s_d <= '0'; 
            wait for 10ns;
            s_d <= '1';
            wait for 10ns;
            s_d <= '0';
            wait for 10ns;
            s_d <= '1';
            wait for 10ns;
            s_d <= '0';
            wait for 10ns;
            s_d <= '1';
            wait for 10ns;
            s_d <= '0'; 
    
    report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;
```

### Screenshot with waveforms

![Screenshot](images/sim3.png)

## jk_ff_rst

### p_jk_ff_rst process (`jk_ff_rst`)

```vhdl
p_jk_ff_rst   : process (clk)
    begin
        if rising_edge(clk) then
            if  (rst = '1') then
                s_q     <= '0';
                
            else
                if    (j = '0' and k = '0')then
                    s_q <=  s_q;
                    
                elsif (j = '0' and k = '1')then
                    s_q <=  '0';
                    
                elsif (j = '1' and k = '0')then
                    s_q <=  '1';
                
                elsif (j = '1' and k = '1')then
                    s_q <=  (not s_q);
                    
                end if;
            end if;
        end if;
end process p_jk_ff_rst;
```

### VHDL clock, reset and stimulus processes (`tb_jk_ff_rst`)

```vhdl
p_clk_gen : process
    begin
        while now < 750 ns loop         -- 75 periods of 100MHz clock
            s_clk_100MHz <= '0';
            wait for c_CLK_100MHZ_PERIOD / 2;
            s_clk_100MHz <= '1';
            wait for c_CLK_100MHZ_PERIOD / 2;
        end loop;
        wait;
    end process p_clk_gen;

p_reset_gen : process
    begin
        s_rst <= '0';
        wait for 20 ns;
        
      
        s_rst <= '1';
        wait for 12 ns;
       
        
        s_rst <= '0';
        wait for 30 ns;
        
        
        s_rst <= '1';
        wait for 12 ns;
       
        s_rst <= '0';
        wait;
end process p_reset_gen;
 p_stimulus : process
    begin
        report "Stimulus process started" severity note;
            s_j <= '0';
            s_k <= '0';           
            wait for 20ns;
            
            s_j <= '0';
            s_k <= '1';           
            wait for 20ns;
            
            s_j <= '1';
            s_k <= '0';           
            wait for 20ns;
            
            s_j <= '1';
            s_k <= '1';           
            wait for 20ns;
            
            
            s_j <= '0';
            s_k <= '0';           
            wait for 20ns;
            
            s_j <= '0';
            s_k <= '1';           
            wait for 20ns;
            
            s_j <= '1';
            s_k <= '0';           
            wait for 20ns;
            
            s_j <= '1';
            s_k <= '1';           
            wait for 20ns;
            
            s_j <= '0';
            s_k <= '0';           
            wait for 20ns;
            
            s_j <= '0';
            s_k <= '1';           
            wait for 20ns;
            
            s_j <= '1';
            s_k <= '0';           
            wait for 20ns;
            
            s_j <= '1';
            s_k <= '1';           
            wait for 20ns;
            
            s_j <= '0';
            s_k <= '0';           
            wait for 20ns;
            
            s_j <= '0';
            s_k <= '1';           
            wait for 20ns;
            
            s_j <= '1';
            s_k <= '0';           
            wait for 20ns;
            
            s_j <= '1';
            s_k <= '1';           
            wait for 20ns;
            
            s_j <= '0';
            s_k <= '0';           
            wait for 20ns;
            
            s_j <= '0';
            s_k <= '1';           
            wait for 20ns;
            
            s_j <= '1';
            s_k <= '0';           
            wait for 20ns;
            
            s_j <= '1';
            s_k <= '1';           
            wait for 20ns;
            
            
    
    report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;
```

### Screenshot with waveforms

![Screenshot](images/sim4.png)

## t_ff_rst

### p_t_ff_rst process (`t_ff_rst`)

```vhdl
p_t_ff_rst   : process (clk)
    begin
        if rising_edge(clk) then
            if  (rst = '1') then
                s_q     <= '0';
                
            else
                if    (t = '0')then
                    s_q <=  s_q;
                
                elsif (t = '1') then
                    s_q <=  (not s_q);                                  
                    
                end if;
            end if;
        end if;
end process p_t_ff_rst;
```

### VHDL clock, reset and stimulus processes (`tb_t_ff_rst`)

```vhdl
p_clk_gen : process
    begin
        while now < 750 ns loop         -- 75 periods of 100MHz clock
            s_clk_100MHz <= '0';
            wait for c_CLK_100MHZ_PERIOD / 2;
            s_clk_100MHz <= '1';
            wait for c_CLK_100MHZ_PERIOD / 2;
        end loop;
        wait;
    end process p_clk_gen;

p_reset_gen : process
    begin
        s_rst <= '0';
        wait for 20 ns;
        
      
        s_rst <= '1';
        wait for 12 ns;
       
        
        s_rst <= '0';
        wait for 30 ns;
        
        
        s_rst <= '1';
        wait for 12 ns;
       
        s_rst <= '0';
        wait;
end process p_reset_gen;
 p_stimulus : process
    begin
        report "Stimulus process started" severity note;
            
            s_t <= '0';           
            wait for 51ns;
            s_t <= '1';
            wait for 49ns;
            
            s_t <= '0';           
            wait for 51ns;
            s_t <= '1';
            wait for 49ns;
            
            s_t <= '0';           
            wait for 51ns;
            s_t <= '1';
            wait for 49ns;
            
            s_t <= '0';           
            wait for 51ns;
            s_t <= '1';
            wait for 49ns;
            
            s_t <= '0';           
            wait for 99ns;
            s_t <= '1';
            wait for 101ns;

    report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;

```

### Screenshot with waveforms

![Screenshot](images/sim5.png)


## Úkol 4: Shift register

![Screenshot](images/pic1.png)



