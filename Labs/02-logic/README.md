# Digital-electronics-1

## Labs

### 01-gates
[playground link pro oba úkoly](https://www.edaplayground.com/x/L3Si)
#### Demorgan's law
- code listing
 ```vhdl
architecture dataflow of gates is
begin
    f_o     <= ((not b_i) and a_i) or ((not c_i) and (not b_i));
    fnand_o <= not(not((not b_i) and a_i) and not((not c_i) and (not b_i)));
    fnor_o  <= not(b_i or (not a_i)) or not(c_i or b_i);

end architecture dataflow;
```
- simulated waveforms screenshot
![](images/Demorgan.png)

### Tabulka

| **c** | **b** |**a** | **f(c,b,a)** |
| :-: | :-: | :-: | :-: |
| 0 | 0 | 0 | 1 |
| 0 | 0 | 1 | 1 |
| 0 | 1 | 0 | 0 |
| 0 | 1 | 1 | 0 |
| 1 | 0 | 0 | 0 |
| 1 | 0 | 1 | 1 |
| 1 | 1 | 0 | 0 |
| 1 | 1 | 1 | 0 |


#### Distributive laws
- code listing
 ```vhdl
architecture dataflow of gates is
begin
    f_dlaw1_L <= (a_i and b_i) or (a_i and c_i);
	   f_dlaw1_R <= a_i and (b_i or c_i);
    f_dlaw2_L <= (a_i or b_i) and (a_i or c_i);
    f_dlaw2_R <= a_i or (b_i and c_i);
end architecture dataflow;

```
- simulated waveforms screenshot
![](images/Dlaws.png)

### Tabulka


| **z** | **y** |**x** | **x and y or x and z** | **x and (y or z)** | **(x or y) and (x or z)**  | **x or (y and z)**  |
| :-: | :-: | :-: | :-: | :-: | :-: | :-: |
| 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| 0 | 0 | 1 | 0 | 0 | 1 | 1 |
| 0 | 1 | 0 | 0 | 0 | 0 | 0 |
| 0 | 1 | 1 | 1 | 1 | 1 | 1 |
| 1 | 0 | 0 | 0 | 0 | 0 | 0 |
| 1 | 0 | 1 | 1 | 1 | 1 | 1 |
| 1 | 1 | 0 | 0 | 0 | 1 | 1 |
| 1 | 1 | 1 | 1 | 1 | 1 | 1 |
