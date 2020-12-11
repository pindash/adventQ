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

/shakti:
i:0:"d11.txt"
l:"#"=i;f:~"."=i
adj:{f*(5>a)&x|0=a:(2;{+(0+':x)+1_x,0})/:x}
+//:adj/:l

