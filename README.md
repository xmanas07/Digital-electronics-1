# Digital-electronics-1

## Labs


**Source code**


```vhdl
begin
writeline("Boris voní");
end;
```

**Morgan's Laws sim**
```vhdl
architecture dataflow of gates is
begin
    f_o     <= ((not b_i) and a_i) or ((not c_i) and (not b_i));
    fnand_o <= not(not((not b_i) and a_i) and not((not c_i) and (not b_i)));
    fnor_o  <= not(b_i or (not a_i)) or not(c_i or b_i);

end architecture dataflow;
```
