/day 1
d:"I"$read0 `:adventofcode/d1.txt
p1:sum -2+div[;3] d
p2:sum over 1 _ {0|-2+div[;3]x} scan d
/day 2
d:value first read0 `:adventofcode/d2.txt
f:.[{[m;i]$[99=m i;
    (m;i);
    1=m i;(@[m;m[i+3];:;sum m m[i+1 2]];i+4);
    2=m i;(@[m;m[i+3];:;prd m m[i+1 2]];i+4);(m;i)]}]
p1:{[x;y]first first f over (@[d;1 2;:;(x;y)];0)} . 12 2
p2:{x[1]+100*x[0]} first c where 19690720={[x;y]first over f over (@[d;1 2;:;(x;y)];0)} .' c:{x cross x} til 100 
/day 3
d:read0 `:adventofcode/d3.txt
m:"RLUD"!(1 0;-1 0;0 1;0 -1)
allPoints:{[wp](1 2#0),raze flip each (-1_sums[enlist[0 0],wp])+
 { flip 1 _ .[cross]  signum[x]*til each 1+abs x} each wp}
wires:m[w[;;0]]*"I"$1 _''w:("," vs/: d)
p1:@[;1] asc sum each abs {x[0] inter x[1]} allPoints each wires
p2:@[;1] sum {x ?\: x[0] inter x[1]}  allPoints each wires
/day 4
d:"125730-579381"
r:string 125730+til neg value d
p1:sum {(x~asc x)&(1<=sum not differ x)} each  r
p2:sum {(x~asc x)&(1<=sum 2=count each group x)} each  r
