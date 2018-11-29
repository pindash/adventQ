D1
p1
captcha:D1
sum "I"$'captcha -1+where not differ captcha,first captcha
p2
{sum "I"$'x where last flip not differ each x (til count x),'(div[count x;2]+til count x) mod count x} captcha

D2
p1
spreadsheet:D2
mat:"I"$"\t" vs/: "\n" vs spreadsheet

sum .[-;] (max;min)@\: flip mat

p2
diag:{(x;x)#1,(x#0)}
sum .[%;] flip {x {(raze i),where count each i:where each x} {neg[diag count x]+0=x mod/: x} x} each mat

D3
p1
input:value D3
all {(1+(4*x)+x*x)=(x+2)*(x+2)} 1+til 10000

f:{[input]
	nbrc:{?[1h$x mod 2;x;x-1]} (floor sqrt input);  /nearest bottom corner
	grid:(1+2*til input)?nbrc;
	trc:nbrc+1+ brc:nbrc*nbrc; /top right corner
	tlc:nbrc+1+trc;
	blc:nbrc+1+tlc;
	$[brc=input;(neg[grid];grid);
		blc<=input;(neg[1+grid];neg[1+grid]+(input-blc));
		tlc<=input;(1+grid-input-tlc;neg[1+grid]);
		trc<=input;(1+grid;1+grid-input-trc);
			(neg[grid]+input-brc+1;grid+1)]
	}

sum abs f 289326
evolute:{(x;x)#iasc sums -1 rotate raze (-1 _ raze 2#'1+til x)#'(-1+2*x)#(1;neg x;-1;x)}
sm:{([]row:where count each i;col:raze i;val:raze x@'i:where each x<>0)} /dense to sparse
g:{([]row: neg j div 2;col:neg j div 2;val:enlist[0b])+sm reverse (1+evolute j:$[mod[j:ceiling sqrt x;2];j;j+1])=x}

{(x;x)#iasc sums -1 rotate (1;neg x;-1;x)@(where 1+where ((x-1)#2),1) mod (x-1)}

p2

neighbors:{flip x+flip (0 0;0 1;1 1;1 0;1 -1;0 -1;-1 -1;-1 0;-1 1)}
a:.[99 99#0;49 49;:;1]
b:.[5 5#0;2 2;:;1]
sumN:{sum over .[x;] each tran[x] neighbors y}
tran:{i:div[count x;2]; (i+y)}
res:{$[z<max over x;x;.[x;tran[x] y;:;sumN[x;y]]]}/[a;f each 1+til 1000;289326]
max over res
evolute 8
f each 1+ til 8
{5 5 #iasc sums -1 rotate (-1;x;1;neg x)(where where (x#2),1) mod 4} 5

D4
p1
input:"\n" vs D4
sum {.[=;] (('[count;distinct]);count) @\: `$" " vs x} each input

p2
sum {.[=;] (('[count;distinct]);count) @\: `$asc each " " vs x} each input

D5
p1
input:"J"$"\n" vs  D5
a:0 3 0 1 -3
f:{.[{if[y>=count x;:(x;y;z)];(@[x;y;+;1];y+x[y];z+:1)};x]} 
f over (input;0;0)
p2
f:{ g:{if[y>=count x;:(x;y;z)];
		(@[x;y;{$[2<x;x-y;x+y]};1];y+x[y];z+:1)};
	.[g;x]} 
f over (input;0;0)



D6
p1
input:value D6
x:0 2 7 0 
x:input
f:{v:x k:first idesc x;j:count q:@[x;k;:;0];q+neg[k+1] rotate @[j#(v div j); til (v mod j);+;1]};
g:{ 
	res:f\[y;x];
	$[(y+1)=k:count distinct res;
	.z.s[x;10*y];
	:k]}
\c 200 20000

g[input;10]

p2
i:0;{i+::1;f x} over f/[g[input;10];input];i



D7
si:"pbga (66)
xhth (57)
ebii (61)
havc (66)
ktlj (57)
fwft (72) -> ktlj, cntj, xhth
qoyq (66)
padx (45) -> pbga, havc, qoyq
tknk (41) -> ugml, padx, fwft
jptl (61)
ugml (68) -> gyxo, ebii, jptl
gyxo (61)
cntj (57)"
rows:"\n" vs si
t:([]name:`$4#'rows;weight:"I"$2#'6_'rows;links:?[1=count each ">" vs' rows;count[rows]#enlist[""];{trim last x}each ">" vs' rows])
t:update `$"," vs' links from t
t[`name] except (distinct exec raze links from t)

rows:"\n" vs D7
t:([]name:`$first each " " vs' rows;weight:value each @[;1] each " " vs' rows;links:?[1=count each ">" vs' rows;count[rows]#enlist[""];{trim last x}each ">" vs' rows])
t:update `$"," vs' links from t
root:t[`name] except (distinct exec raze links from t)
t:update leaf:all each links=\:` from t 


p2
tt:ungroup `name xkey t
tt:update subTreeWeight:0 from tt
f:{ [t;names]
	subW:{sum (x[`name]!x[`subTreeWeight]) y}[t];
	eqW:{j:(x[`name]!x[`subTreeWeight]) y; first [j]=j}[t];
	update subTreeWeight:first[weight]+subW[links],eq:eqW links by name from t where name in names}

p:tt[`links]!tt[`name]
p:p,root!root
levels: p scan exec name from tt where leaf
res:f/[tt;levels]
filt:{[x]r:select name,subTreeWeight,parent:x[`name] from res where name in x[`links];
  $[1=count distinct select subTreeWeight from r;0#r;r]} 
rf:distinct raze filt each select name,links from t where not leaf
rff:(exec name from rf) in/: levels
rp:exec distinct parent from rf where rff first where any each rff
problemName:exec name from rf where parent in rp, 1=(count;name) fby subTreeWeight 
targetWeightDiff:neg exec last deltas subTreeWeight from `x xdesc select count i by subTreeWeight from rf where parent in rp
select weight+targetWeightDiff from t where name in problemName

D8
si:"b inc 5 if a > 1
a inc 1 if b < 5
c dec -10 if a >= 1
c inc -20 if c == 10"
d:(`$())!7h$()
v:`$first each " " vs' first flip evals:reverse each "if " vs/: "\n" vs ssr/[D8;("!=";"==";"inc";"dec");("<>";"=";"+:";"-:")]
d[v]:0
maxSoFar:0
exps:{{{raze "d[`",first[x],"]",1 _ x}" " vs x}each x} each evals
{$[value x[0];value x[1];::];} each exps
max d

p2
d[v]:0
maxSoFar:0
{$[value x[0];value x[1];::]; maxSoFar::maxSoFar|max d;} each exps
maxSoFar

D9
p1
clean:{ssr/[x;("!!";"!?");("";"")]}
deleteGarbage:{
	start:first ss[x;"<"];
	if[null start;:x];
	end:first ss[x;">"];
    c:(0,start,end+1);
	{first[x],last x} c _ x}

clean "{{<a!>},{<a!>},{<a!>},{<ab>}}"

s:deleteGarbage over clean D9
s:s ss[s;"[{}]"]
{$["{"=y;x[`l]+:1;[x[`c]+:x[`l];x[`l]-:1]];x}/[`l`c!0 0;s]

p2
c:clean D9
sum abs 2+ 1 _ deltas count each deleteGarbage scan c

D10
p1
input:value D10
l:til 256
skip:til count input
c:0
prd 2#first {[x;y;skip]l:first x;c:last x; l[a]:reverse l a:(c+til y) mod 256;c:(c+skip+count a) mod 256;(l;c)}/[(l;c);input;skip]

p2
input:7h$D10
finput:input,17, 31, 73, 47, 23
l:til 256
finput:raze 64# enlist finput
skip:til count finput
res:first {[x;y;skip]l:first x;c:last x; l[a]:reverse l a:(c+til y) mod 256;c:(c+skip+count a) mod 256;(l;c)}/[(l;c);finput;skip]
4h$2 sv (<>/)flip 2 vs 16 16#res

hash:{[input]
  finput:(7h$input),17, 31, 73, 47, 23;
  l:til 256;
  finput:raze 64# enlist finput;
  skip:til count finput;
  res:first {[x;y;skip]l:first x;c:last x; l[a]:reverse l a:(c+til y) mod 256;c:(c+skip+count a) mod 256;(l;c)}/[(l;c);finput;skip];
  4h$2 sv (<>/)flip 2 vs flip 16 16#res}
hash ""
hash D10

D11
p1
m:`n`s`w`e`ne`nw`se`sw!((1 0);(-1 0);(0 -1);(0 1);(0.5 0.5);(0.5 -0.5);(-0.5 0.5);(-0.5 -0.5))
sum m `ne`ne`s`s
sum abs sum m `$"," vs "ne,ne,s,s"
sum abs sum m `$"," vs D11

p2
max sum flip abs sums m `$"," vs D111

D12
p1 
si:"0 <-> 2
1 <-> 1
2 <-> 0, 3, 4
3 <-> 2, 4
4 <-> 2, 3, 6
5 <-> 6
6 <-> 4, 5"
rep:{([row:"J"$first x]col:"J"$"," vs' last[x])}
t:ungroup rep trim flip "<->" vs/: "\n" vs si
ms:{./[(1+max x)#0b;x:x[;`row`col];:;1b]}
fAC:{[i;m]
		n: where m[i]; /find neighbors
	f:{distinct raze x,where each y x}[;m]; 
	f over n}
fAC[0;ms t]
m:ms ungroup rep trim flip "<->" vs/: "\n" vs D12
count fAC[0;m]

p2
allComponents:{[m]
	points:til count m;
	connected:();
	while[count points;
	i:first points;
	connected,:enlist n:`s#n:distinct asc i,fAC[i;m]; /add point in case it is island
	points:points except n];
	connected}
count allComponents m



d13
t:([]level:til 2+max t[`level]; range:0) lj 1!t
t:update spos:0 mod range, me:0b, c:0 from t
t:update realpos:map[range]@'spos from t
t:update me:1b from t where i=0
 pico:{
   x:update c:range*level from x where me, 0=map[range]@'spos;
   if[(max x[`level])=first where x[`me];:x];
   x[`me]:-1 rotate x[`me];
   x:update spos:(1+spos) mod max(0;-2+2*range) from x;
	x} 
select sum c from pico over t

update spos:0 from `t
select sum c from update c:level*range from t where 0=level mod 2*range-1

p2
pico:{[x;delay]
   if[0<>delay; x:update c:1+range*level from x where me, 0=realpos];
   if[(max x[`level])=first where x[`me];:x];
   x[`me]:delay rotate x[`me];
   x:update spos:(1+spos) mod max(0;-2+2*range)from x;
   x:update realpos:map[range]@'spos from x;
   x}
   i:0
 t
 f:{sum exec c from update c:1 from t where 0=(x+level) mod 2*range-1} 
 each til 100
f each til 100

{where exec 0=(level+x) mod 2*range-1 from t} 1

select from t
t[`range]

 while[not {0=sum exec c from pico/[t;(x#0),count[t]#-1]} i;i+:1]


first 10 _ 
pico/[t;(#0),count[t]#-1]

pico[t;-1]
update c:1+range*level from t where me, 0=realpos
siev:{$[x<4;enlist 2;r,1_where not any x#'not til each r:siev ceiling sqrt x]}

distinct select level mod 2*range-1 from t


1+first where 1<>deltas j where 0<j:distinct asc raze 

p:{[l;r;i]neg[l]+(2*r-1)*til i}[;;4000000]
j:distinct asc raze exec p'[level;range] from t
1+ first where 1<>deltas 
first where 1< deltas j
j:j where -1<j


j:{(til x),reverse -1_ 1_ til x} each (!) . flip "I"$":" vs/:"\n" vs d13
max {$[0 in { j[x;(x+y) mod count j[x]]}\:[til 93;x];0;x]} each til 4000000



D14
p1
hash:{[input]
  finput:(7h$input),17, 31, 73, 47, 23;
  l:til 256;
  c:0;
  finput:raze 64# enlist finput;
  skip:til count finput;
  res:first {[x;y;skip]l:first x;c:last x; l[a]:reverse l a:(c+til y) mod 256;c:(c+skip+count a) mod 256;(l;c)}/[(l;c);finput;skip];
  4h$2 sv (<>/)flip 2 vs flip 16 16#res}

sum over 1h$raze 2 vs 7h$hash each "ffayrhll-",/: string til 128


p2
find contigous
f:('[;]/)(first;{(x[0]+count[y]-0^first 7h$(sum/)y{any x in y}/:\:x[1];y)}/[(0j;());];{(where 1<>-2-':w)_w:where x}')
f a

t:([id:()]neighbors:())
gni:{j where 0<=j:(raze -1 0 0 1+/:x mod 128)+128*raze 0 -1 1 0+/:x div 128}

f:{((),x,k where 0^n k:(gni x) except x)} 

{$[not x in raze exec neighbors from t;`t upsert $[n x;(x;f over x);()];`t]} each til count n
