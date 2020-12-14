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
/golfing
prd {j:y*\:1+til count x;sum x[j 0]@'j[1] mod count first x}[i] each (1 1;1 3;1 5;1 7;2 1)
/day4 
i:read0 `:d4.txt
/p1
k:`byr`iyr`eyr`hgt`hcl`ecl`pid
sum {all k in `$first each ":" vs/: raze " " vs/: x} each (0,where 0=count each i) _ i
/p2
d:{`_{(`$x[;0])!x[;1]}":" vs/: raze " " vs/: x} each (0,where 0=count each i) _ i
present:d where all each `byr`iyr`eyr`hgt`hcl`ecl`pid in/: key each d
m:`byr`iyr`eyr`hgt`hcl`ecl`pid`cid!({[x](4=count x) & ("I"$x) within 1920 2002};
	{[x](4=count x) & ("I"$x) within 2010 2020};
	{[x](4=count x) & ("I"$x) within 2020 2030};
	{[x]$["cm"~-2#x; ("I"$-2 _ x) within 150 193;
	      "in"~-2#x;("I"$-2 _ x) within 59 76;0b]};
	{[x](7=count x)&("#"=first x)&(all (1_ x) in "abcdef",.Q.n)};
    {[x] (`$x) in `amb`blu`brn`gry`grn`hzl`oth};
    {[x] (9=count x)&(all x in .Q.n)};{1b})
sum {all m[key x]@' value x} each present 
/day5
/p1
max ids:{(8*2 sv "B"=7#x)+2 sv "R"=-3#x} each read0 `:d5.txt
/p2
{(m+til max[x]-m:min[x])except x} ids
/second cut part 1:
max 2 sv flip read0[`:d5.txt] in "BR"



/day6
i:read0 `:d6.txt
i:enlist[""],i
/p1
sum (count distinct ::)each raze each (where 0=count each i)_i
/p2
sum {count (inter/) x} each 1_'(where 0=count each i)_i

/same idea, but we can replace count each with match(~)
sum (count distinct raze ::) each (where ""~/:i)_i
sum (count(inter/)1_ ::) each (where ""~/:i)_i

/day7
i:read0 `:d7.txt
t:ungroup {([]o:`$-1_'x[;0] inter\: .Q.a;p:"," vs/: x[;1])}"contain" vs/: i
t:update c:0^"I"$'p[;1], p:`${?["s"=last each x;-1_'x;x]}p inter\: .Q.a from t
/p1
-1+count {distinct asc x,exec o from t where p in x } over `shinygoldbag
/p2
s:update totalbelow:0 from t where c=0
f:{comp:exec o!1+totalbelow from x where not null totalbelow;
   update totalbelow:7h$c wsum comp[p] by o from x
    where ({all y in x}[key comp];p)fby o}
exec first totalbelow from (f over s) where o=`shinygoldbag

/day8
i:read0 `:d8.txt
`ins`off set' {(`$x[;0];"I"$x[;1])}" " vs/: i
visited:();acc:0;
/p1
{[i]if[i in visited;:acc]; visited,:i;$[`acc=c:ins i;{acc+:off x;x+1} i;`jmp=c;i+off i;`nop=c;i+1;0]}/[1000;0]
/p2
f:{if[x in v;:x];v,:x;$[`acc=c:ins x;{acc+:off x;x+1} x;`jmp=c;x+off x;`nop=c;x+1;x+0]}
reset:{`v`acc`ins`off set'{(();0;`$x[;0];"I"$x[;1])}" " vs/: i}
r[;0] where {count[ins] in/: x[;1]}r:{reset[];@[`ins;x;`jmp`nop!`nop`jmp];(acc;f scan 0)} each where ins in `jmp`nop

/day 9
i:"J"$read0 `:d9.txt
/p1
m:i first where 0=count each {y inter x-y}'[i;flip (1+til[25]) xprev\: i]
/p2
sum (min;max) @\: i {x[1]-til 1+x[0]}c vs last where raze m=sums til[c:count i]xprev\:i

/day 10
i:"J"$read0 `:d10.txt
/p1
prd count each group deltas asc[i],3+max i
/slightly shorter:
prd sum 1 3=/:deltas[asc i],3
/p2
trib:{7h$first {(1 1 1f;1 0 0f;0 1 0f)$x}/[0|x-1;(1 1 0f)]}
prd (trib sum ::) each {(0,where 0=x)_x}1=deltas asc i


/day 11
i:read0 `:d11.txt
/p1
l:`int$"#"=i;f:not "."=i;
adj:{f*(5>a)&x|0=a:2{flip (0i+':x)+1_x,0i}/x} 
sum over adj over l
/p2
shape:{(count x;count first x)} i
ts:1+{(til each x)@\:til max x} -1+shape
/directions
n:(neg ts[0];count[ts 1]#0);s:abs n;w:(count[ts 0]#0;neg ts 1);e:abs w;
nw:neg ts;ne:@[nw;1;neg];sw:@[nw;0;neg];se:neg nw;
chairs:where raze "L"=i;f:not "."=raze i;l:raze "#"=i
d:{x!x}til max shape
findN:{{first (shape sv x) inter chairs} each d (n;s;w;e;nw;ne;sw;se)+\:shape vs x}
near:flip findN each til count l
seat:{f*(5>a)&x|0=a:sum 0^x near}
sum seat over l

/alternative way of findig near nodes
c:"L"=i
d:{x!x}flip shape vs til count raze l 
travel:{{$[.[x] z;z;2#d z+y]}[.[l;y;:;0b];x;] over y}
alldir:(1_{x cross x}0 1 -1) travel\:
n2:flip shape sv/: flip each alldir each flip shape vs til count raze c
seat:{f*(5>a)&x|0=a:sum 0^x n2}
sum seat over l

/another way march the whole matrix/ way faster
c:raze "L"=i;l:raze "#"=i;
s:{(count x;count first x)} i
d:{x!s sv flip x}flip s vs til prd s
p:flip key d
m:{{?[c y;y;d flip x+s vs y]}[x]/[d flip x+y]}
n:(1_{x cross x}0 1 -1) m\: p
seat:{c*(5>a)&x|0=a:sum 0^x n}
sum seat over l

/shakti:
i:0:"d11.txt"
l:"#"=i;f:~"."=i
adj:{f*(5>a)&x|0=a:(2;{+(0+':x)+1_x,0})/:x}
+//:adj/:l

/day12
i:((`F;10);(`N;3);(`F;7);(`R;90);(`F;11)) /sample
i:{(`$x[0];"J"$1_x)}each read0 `:d12.txt
d:`E`S`W`N
/p1
m:`S`E`W`N`F`R`L!(@[;1;-;];@[;2;+;];@[;2;-;];@[;1;+;];{m[x 0][x;y]};
	{@[x;0;:;d mod[(d?x[0])+y div 90;4]]};{@[x;0;:;d mod[(d?x[0])-y div 90;4]]})
f:{m[y 0][x;y 1]}
sum abs 1 _ f/[(`E;0;0);i]
/p2
m:`S`E`W`N`F`R`L!(@[;2;-;];@[;3;+;];@[;3;-;];@[;2;+;];{@[x;0 1;+;x[2 3]*y]};
	{@[x;2 3;:;{reverse 1 -1*x}/[y div 90;x 2 3]]};{@[x;2 3;:;{reverse -1 1*x}/[y div 90;x 2 3]]})
f:{m[y 0][x;y 1]}
sum abs 2#f/[(0;0;1;10);i]

/day 13
i:read0 `:d13.txt
t:"J"$first i;k:{x where not null x}"J"$"," vs last i
/p1
prd {(min[x]-t;k first iasc x)}{{x+y}[;x]/[{x<t};0]} each k
/p2
k:"J"$"," vs last i
/key incite https://math.stackexchange.com/a/3864593
/large number multiplication under modulus
bigmodmul:{[a;b;m]
	a:a mod m;
	f:{if[x[`b] mod 2;x[`r]:(x[`r]+x[`a]) mod x[`m]];
	  x[`a]:(2*x[`a]) mod x[`m];x[`b]:x[`b] div 2;
	  x};
	x:f/[{x[`b]>0};`a`b`r`m!(a mod m;b;0;m)];
	x[`r]}
/bigmodmul kdb way:
bmmod:{[a;b;m]
	a:a mod m;l:reverse 2 vs b;
  a:(mod[;m] 2*)\[count l;a];
  {mod[;x]y+z}[m] over a where l}
/extended_gcd
egcd:{[a;b]
 x:`r0`r`s0`s`t0`t!(a;b;1;0;0;1);
 f:{q:x[`r0] div x[`r];r:x[`r0] mod x[`r];
    x[`r0`r]:(x[`r];r);x[`s0`s]:(x[`s];x[`s0]-q*x[`s]);
    x[`t0`t]:(x[`t];x[`t0]-q*x[`t]);
	x};
 res:f/[{0<>x[`r]};x];
 res[`r0`s0`t0]}
/combined phased rotations
cpr:{[a;ap;b;bp]
 x:()!();x[`gcd`s`t]:egcd[a;b];
 pd:ap-bp;pdm:pd div x[`gcd];pdr:pd mod x[`gcd];
 if[pdr;'rotation_reference_points_never_sync];
 cp:b*a div x[`gcd];
 ch:(ap-x[`s]*bmmod[pdm;a;cp]) mod cp;
 (cp;ch)};
F:{cpr[x 0;x[1] mod x[0];y[0];y 1 mod y 0]}
last F/[flip (k where not null k;neg where not null k)]
/test
t:((17,0N,13,19;3417);(67,7,59,61;754018);(67,0N,7,59,61;779210);(67,7,0N,59,61;1261476);(1789,37,47,1889;1202161486))
{k:first x;last[x]=last F/[flip (k where not null k;where not null k)]} each t
/alternative 
fa:{[a;ao;b;bo]
  x:cpr[a;neg[ao] mod a;b;neg[bo] mod b];
  (x 0;neg[x 1] mod x 0)}
G:{fa[x 0;x 1;y 0;y 1]}
last G/[flip (k where not null k;neg where not null k)]


/day 14
i:read0 `:d14.txt
p:?["a"=i[;1];"J"$''-36#'i;{"J"$x (where 1<deltas c)_c:where x in .Q.n} each i]
/p1
d:()!();g:{if[36=count y;:y];d[y 0]:2 sv (-36#0b vs y[1])^x;x}
g over p;sum d
/p2
d:(`long$())!`long$();
f:{y:?[c:null x;x;(-36#0b vs y)|x];2 sv flip @[y;where c;:;] each flip 2 vs til (2*)/[7h$sum c;1]}
g:{if[36=count y;:y];d[f[x;y 0]]:y[1];x}
g over p; sum d


