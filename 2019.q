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
d:first read0 `:adventofcode/d4.txt
r:string 125730+til neg value d
p1:sum {(x~asc x)&(1<=sum not differ x)} each  r
p2:sum {(x~asc x)&(1<=sum 2=count each group x)} each  r
/day 5
d:value first read0 `:adventofcode/d5.txt
f:.[{[m;i]
    em:01b!({x@y}[m];{x});
    ins:last c:10 vs m i;
    e:reverse "b"$-1_c;
    g:{[em;e;m;i;s] em[e s]@'m[i+s]}[em;e;m;i];
    $[99=m i;(m;i);
    1=ins;(@[m;m[i+3];:;sum g 1 2];i+4);
    2=ins;(@[m;m[i+3];:;prd g 1 2];i+4);
    3=ins;(@[m;m[i+1];:;get `input];i+2);
    4=ins;[res,::g 1;(m;i+2)];
    5=ins;(m;$[g 1;g 2;i+3]);
    6=ins;(m;$[not g 1;g 2;i+3]);
    7=ins;(@[m;m[i+3];:;"j"$.[<] g 1 2];i+4);
    8=ins;(@[m;m[i+3];:;"j"$.[=] g 1 2];i+4);
    (m;i)]}]
input:1;res:();f over (d;0)
p1:$[all not -1 _ res;last res;'broken]
input:5;res:();f over (d;0)
p2:$[1=count res;res;'broken]
/day 6
d:read0 `:adventofcode/d6.txt
p:.[!] reverse flip `COM,`$")" vs/: d
p1:sum count each 1 _(p\) each value p
p2:sum -1+n?\:first .[inter] n:(p\) each `YOU`SAN
