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
/day 7
d:value first read0 `:adventofcode/d7.txt
op:{[input;output;m;i]
    em:01b!({x@y}[m];{x});
    ins:last c:10 vs m i;
    e:reverse "b"$-1_c;
    g:{[em;e;m;i;s] em[e s]@'m[i+s]}[em;e;m;i];
    $[99=m i;(m;i);
    1=ins;(@[m;m[i+3];:;sum g 1 2];i+4);
    2=ins;(@[m;m[i+3];:;prd g 1 2];i+4);
    3=ins;(@[m;m[i+1];:;input[]];i+2);
    4=ins;[output g 1;(m;i+2)];
    5=ins;(m;$[g 1;g 2;i+3]);
    6=ins;(m;$[not g 1;g 2;i+3]);
    7=ins;(@[m;m[i+3];:;"j"$.[<] g 1 2];i+4);
    8=ins;(@[m;m[i+3];:;"j"$.[=] g 1 2];i+4);
    (m;i)]}
run:{[amp]
    output:{[x;y].[`amps;(x;`inp);,;y]};
    input:{[x;y]r:first .[`amps;(x;`inp)];.[`amps;(x;`inp);{y;1 _ x};y];0^r};
    .[op[input[amp[`id]];output[amp[`namp]]]] over amp[`tape`i]
    }
combos:combos where {all 1=count each group x} each combos:flip 5 vs til 5 sv 4 4 4 4 5
tape:d
try:{[ph]
    state:`tape`i`inp!(tape;0;7h$());
    amps::update inp:(inp,'phase) from `id xkey update id:`a`b`c`d`e, namp:`b`c`d`e`res, phase:ph from 5#enlist state;
    run each 0!amps;
    store,::update runid:5 sv ph from 0!amps; /for debugging 
    last amps[`res;`inp]
    }
delete store from `.
p1:max try each combos 
op:{[input;output;m;i]
    em:01b!({x@y}[m];{x});
    ins:last c:10 vs m i;
    e:reverse "b"$-1_c;
    g:{[em;e;m;i;s] em[e s]@'m[i+s]}[em;e;m;i];
    $[99=m i;(m;i);
    1=ins;(@[m;m[i+3];:;sum g 1 2];i+4);
    2=ins;(@[m;m[i+3];:;prd g 1 2];i+4);
    3=ins;(@[m;m[i+1];:;input[]];i+2);
    4=ins;[output g 1;(m;i)];
    5=ins;(m;$[g 1;g 2;i+3]);
    6=ins;(m;$[not g 1;g 2;i+3]);
    7=ins;(@[m;m[i+3];:;"j"$.[<] g 1 2];i+4);
    8=ins;(@[m;m[i+3];:;"j"$.[=] g 1 2];i+4);
    (m;i)]}
try2:{[ph]
    state:`tape`i`inp!(tape;0;7h$());
    amps::update inp:(inp,'phase) from `id xkey update id:`a`b`c`d`e, namp:`b`c`d`e`a, phase:ph from 5#enlist state;
    f:{[amps] orig:get `amps;
        current:last .[`amps;(`a;`inp)];
        r:flip run each 0!amps; if[current=last .[`amps;(`a;`inp)];:orig];
        update tape:first r, i:2+last r from `amps;get `amps};
    f over amps;
    last .[`amps;(`a;`inp)]
    }
p2:max try2 each 5+combos
/day 8
d:value each read0:`:adventofcode/d8.txt
p1:{sum[2=x]*sum[1=x]}raze g j?min j:{sum sum x} each 0=g:{(div[count z;x*y];y;x)#z}[25;6;]d
p2:(0 1!0N 1) last fills reverse (0 1 2!0 1 0N)g

/day 9
d:value first read0 `:adventofcode/d9.txt
op:{[input;output;m;i;r]
    em:0 1 2!({x@y}[m];{x};{x@y+z}[m;r]);
    ins:last c:10 vs m i;
    e:reverse -1_c;
    g:{[em;e;m;i;s] 0^em[0^e s]@'m[i+s]}[em;e;m;i];
    gw:{[e;i;m;r;s]$[2=0^e s;r+0^m[i+s];0^m[i+s]]}[e;i;m;r];
    $[99=m i;(m;i;r);
    1=ins;(@[m;gw 3;:;sum g 1 2];i+4;r);
    2=ins;(@[m;gw 3;:;prd g 1 2];i+4;r);
    3=ins;(@[m;gw 1;:;input[]];i+2;r);
    4=ins;[output g 1;(m;i+2;r)];
    5=ins;(m;$[g 1;g 2;i+3];r);
    6=ins;(m;$[not g 1;g 2;i+3];r);
    7=ins;(@[m;gw 3;:;"j"$.[<] g 1 2];i+4;r);
    8=ins;(@[m;gw 3;:;"j"$.[=] g 1 2];i+4;r);
    9=ins;(m;i+2;r+g 1);
    (m;i;r)]}
output:{res,::x}
k:{til[count x]!x} d
p1:first over (res;(.[op[{1};output]]/)(k;0;0))
p2:last first (res;(.[op[{2};output]]/)(k;0;0))
/day 10
d:read0 `:adventofcode/d10.txt
sm:{([]row:where count each i;col:raze i;val:raze x@'i:where each x<>0)} /sparse.q
f:{[t;r]count distinct select row%col,signum row, signum col from 
   delete from (t-\:r) where row=0,col=0}
t:delete val from sm ".#"?d
p1:max a:(f[t] each t)
degree:{[rise;run](?[0>run;2*atan[0w];0])+atan rise%run}
dist:{sqrt (x*x)+(y*y)}
t:(t-\:z:select col, row from t a?p1) _ a?p1
t:update dist:dist[row;col], slope:degree[row;col] from t
t:0!select row:row iasc dist, col:col iasc dist by slope from t  
blast:{1 rotate update 1 _/:row, 1 _/:col from x where i=0}
p2:100 sv value z+first select col,row from blast/[199;] t


