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
