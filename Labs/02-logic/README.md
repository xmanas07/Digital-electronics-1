# Digital-electronics-1

## úkol 1: Preparation tasks

| **Dec. equivalent** | **B[1:0]** | **A[1:0]** | **B > A** | **B = A** | **B < A** |
| :-: | :-: | :-: | :-: | :-: | :-: |
| 0 | 0 0 | 0 0 | 0 | 1 | 0 |
| 1 | 0 0 | 0 1 | 0 | 0 | 1 |
| 2 | 0 0 | 1 0 | 0 | 0 | 1 |
| 3 | 0 0 | 1 1 | 0 | 0 | 1 |
| 4 | 0 1 | 0 0 | 1 | 0 | 0 |
| 5 | 0 1 | 0 1 | 0 | 1 | 0 |
| 6 | 0 1 | 1 0 | 0 | 0 | 1 |
| 7 | 0 1 | 1 1 | 0 | 0 | 1 |
| 8 | 1 0 | 0 0 | 1 | 0 | 0 |
| 9 | 1 0 | 0 1 | 1 | 0 | 0 |
| 10 | 1 0 | 1 0 | 0 | 1 | 0 |
| 11 | 1 0 | 1 1 | 0 | 0 | 1 |
| 12 | 1 1 | 0 0 | 1 | 0 | 0 |
| 13 | 1 1 | 0 1 | 1 | 0 | 0 |
| 14 | 1 1 | 1 0 | 1 | 0 | 0 |
| 15 | 1 1 | 1 1 | 0 | 1 | 0 |

### Canonical SoP and PoS
![SoP a PoS vzorec](images/Demorgan.png)

## úkol 2: A 2-bit comparator

### Karnaugh maps

#### B = A

<img src="/Images/02-logic/Kmap1.png" alt="b equals a" width="400" >

#### B > A

<img src="/Images/02-logic/Kmap2.png" alt="b is greater than a" width="400" >

#### B < A

<img src="/Images/02-logic/Kmap3.png" alt="b is less than a" width="400" >

### SoP and PoS

![SoP a PoS](/Images/02-logic/Kmap4.png)

![vzorec na SoP a PoS](/Images/02-logic/Vzorec2.gif)

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
