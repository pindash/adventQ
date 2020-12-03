/day1
/p1
{prd k first where 2020=sum flip k:x cross x}"I"$read0 `:d1.txt
/p2
{prd k first where 2020=sum flip k:x cross x cross x}"I"$read0 `:d1.txt
/thanks attila so much more elegant!!
prd i inter 2020-i
prd i inter 2020-raze i+/:i
/day2 
input:read0 `:d2.txt
`r`p set' flip ": " vs/: input
r:{c:"-" vs x;("I"$c 0;"I"$-1 _ c 1;last c 1)} each r
/p1
sum {sum[x[2]=y] within (x 0 1)}'[r;p]
/p2
sum {1=sum x[2]=y -1+x 0 1}'[r;p]
/day3 
i:(".#")?read0 `:d3.txt
/p1
{sum .[x] each flip @[;1;mod;count first x](1;3)*\:1+til count x} i
/p2
prd {sum .[x] each flip @[;1;mod;count first x]y*\:1+til count x}[i] each (1 1;1 3;1 5;1 7;2 1)
/cut2
/p1
{sum x@' (3*til count x) mod count first x} i 
/p2
prd {x:x where 0=mod[;y 0]til count x;sum x@' (y[1]*til count x) mod count first x}[i;] each (1 1;1 3;1 5;1 7;2 1)
prd {j:@[y*\:1+til count x;1;mod;count first x];sum x[j 0]@'j 1}[i] each (1 1;1 3;1 5;1 7;2 1)


