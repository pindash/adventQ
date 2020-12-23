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


/day 15
i:value first read0 `:d15.txt
/p1
last {x,0^-1+count[x]-{last where x=y}[-1 _ x;last[x]]}/[2020-count i;i] //naive
/p2
d:(`u#-1 _ i)!til c:-1+count i;l:last i;  /dictionary with unique values
f:{(@[x;y 0;:;y 1];(0^y[1]-x y 0;1+y 1))}/
\ts r:f/[30000000-count i;(`d;l,c)]
654 4719648

/using array to do look ups
N:30000000
k:@[N#0N;-1 _ i;:;til c:-1+count i];l:last i;
f:{(@[x;y 0;:;y 1];(0^y[1]-x y 0;1+y 1))}/
\ts r:first last f/[N-count i;(`k;l,c)]


/andras shakti slightly faster
i:0 3 6
N:30000000;j:N#0N;j[i]:!#i;c:-1+#i
f:{l:0|c-j x;j[x]:c;c+:1;l}
\t (N-#i;f)/:*|i

N:30000000;j:N#0N;j[i]:til c:count i;c-:1
f:{l:0|c-j x;j[x]:c;c+:1;l}
f/[N-count i;last i]

/arthur's solution
f:{l:a x;a[x]:y;0|y-l}
a:n#n:30000000
a[i]:til count i
\t r:last[i] f/-1+(count i)_til n


/day 16
i:read0 `:d16.txt
`r`mt`nt set'(0,where 0=count each i)_i
r1:"J"$"-" vs/:/: "or" vs/: .[;(::;1)]":" vs/: r
t:"J"$"," vs/: 2 _ nt
/p1
sum raze v:{x where all x {not any x within/: y}/: r1} each t
/p2
v:t where 0=count each v
p:where each all {x {any x within/: y}/:\: r1} each v
solve:{[r;m] r[c]:first m first c:where 1=count each m; (r;m except\: r)}/ 
m:first solve/[20;(20#0N;p)]
prd value[last mt] m?where r like "*departure*"
/shorter and faster
p:where each (all any ::) each v within/:/: r1
m:(raze (except':) p c)iasc c:iasc count each p
prd value[last mt] m where r like "*departure*"

/shakti
X:{0:"./advent/2020/d",($x),".txt"};Y:" "\'X@
/day 16
i:{(0,&0=#'x)^x}X 16
r:{0 1+/:x}'{(`i$"-"\'" "\x)[1 3]}'(":"\' i 0)[;1]
t:`i$","\' 2_i 2
/p1
+/,/v:t@'(&&/&/~+)'t within/:/:\: r
/p2
t@:&0=#'v;p:&'(&/|/)'t within/:/: r
m:(,/{y_x}':p c)@<c:<#'p
*/(`i$","\last[i 1])m@&&/+"departure" in/: (i 0)

/day 17
i:"#"=read0 `:d17.txt
tile:{(3*(count x;count x 0))#raze over flip each 3 3#@[9#enlist 0b&x;4;:;x]}
ad:{@[13#enlist 0b&x;6;:;x]}
life:{3=a-x*4=a:3{flip flip each (0i+':x)+1_x,0i}/x}
sum over 6 life/ ad tile i
/p2
life:{3=a-x*4=a:4{flip (flip') (flip'') (0i+':x)+1_x,0i}/x}
sum over 6 life/ ad ad tile i 


/more generally for n dimension
shape:{-1_ count each first\[{0<=type x};x]}
dim:count shape ::
transpose:{f:('[;]/)({y[x]}\)flip,(dim[x]-2)#(each);f x}
life:{3=a-x*4=a:dim[x]{transpose (0i+':x)+1_x,0i}/x}
sum over 6 life/ ad ad ad tile i 



/day 18
i:read0 `:d18.txt
/p1
sum {value x^(")("!"()") x:reverse x} each i
/p2
paren:(sums("()"!1 -1)::);ins:{raze ((y)#x;z;y _ x)};
p:{max(y&where z=x)except y};n:{min(y|where z=x)except y};
pb:{y:y-2;$[x[y] in .Q.n;p[x;y;" "];p[c;y;(c:paren[x]) y]]};
nb:{y:y+2;$[x[y] in .Q.n;n[x;y;" "];n[c;y;+(c:paren x)y-1]]};
f:{x:{" ",x," "}x^(")("!"()") x:reverse x;
	 k:pb[x] each where "+"=x;j:nb[x] each where "+"=x;
	 kp:asc raze count[k]#enlist "()";i:idesc (k:k,j);
   value ins/[x;k i;kp i]}
sum f each i

/day 19
`r``m set' (raze 0,0 1+/:where ""~/:i) _  i:read0 `:d19.txt
r:":" vs/: r;d:("J"$r[;0])!(value'') "|" vs/: r[;1]
c:where 10=type each d;a:c!`$d c
/p1
flatten:{raze `$(raze'')string (cross/') x}
uprule:{k:(where(all/')(key[x]_d) in key[x])#d;`K set k;
  $[any c:(all')1=(count'') k;x,raze each x where[c]#k;x,flatten each x k]}
rr:uprule over a
sum (`$m) in rr 0 
/p2 -- Inspired by András Dőtsch
r:?[7=type each r2;(enlist'')r2;r2:d[asc key d]]
m:{$[0=count x;0=c:count y;0=c;0b;-10=type f:x 0;$[f=y 0;m[1_x;1_y];0b];any m[;y]'[r[f],\:1_x]]}
sum m[raze r 0] peach i
/ part 2
r[8]:((),42;42 8);r[11]:(42 31;42 11 31)
sum m[raze r 0] peach i

/day 20
m:1 _' (where ""~/:i) cut i: enlist[""], read0 `:d20.txt
t:raze value each -1 _' 5 _' m[;0];m:"#"= -1 _ 1 _' m;
f:{2 sv 7h$flip (first x;last flip x;reverse last x;first flip reverse x)}
N:{(f x;f flip x)} each m
/p1
prd t where any each 2=(sum'') N in where 1=count each group raze over N
/p2
/c - corners; s solution matrix 12 by 12 by 3 tupple (tile;border set;orientation)
c:where any each 2=(sum'') N in where 1=count each group raze over N
s:(2#7h$sqrt count m)#enlist 3# 0N
/helpers
/fr-find rotate;im-index map;gP-get possible matches;ot-get oriention from tupple
/gB-get Border matches;gT-get Tile;dis - distinct sides (for border pieces) 
O:(0 1 2 3;1 2 3 0;2 3 0 1;3 0 1 2;3 2 1 0;2 1 0 3;1 0 3 2;0 3 2 1)
fr:{first where y~/:x[O]@\: z};ot:{(N . 2#x) O x 2};
im:{x!flip 12 vs x}til count raze s[;;0]; 
dis:{x inter where 1=count each group raze over N}
gP:{raze where each flip(any'')N in x};gB:{gP where 1=count each group(raze/[N])except 0N};
gT:{c:(first z inter where ::)each flip(any flip ::)each N in ot[x]y;i:first where not null c;(c[i],i)}
/Tile # Orientation NESW
g:{[s]if[all not null raze s[;;0];:s];
 c:(n:(0 -1;-1 0)+\:(k:im first where null d:raze s[;;0])) in im; 
 p:$[all c;gP[ot[s . n 0] 1];gB[]] except d;
 t:gT[s . n l;1 2 l:last where c;p];
 wn:(),$[c 0;ot[s . n 0] 1;dis[N . t]];
 nn:(),$[c 1;ot[s . n 1] 2;dis[N . t]];
 o:{min x where not null x}fr[N . t;;3 0] each $[2<>count wn;wn,/:nn;wn,\:nn];
 .[s;k;:;t,o]}
/first tile
s[0;0]:c[0],0,fr[N[c 0;0];dis[N[c 0;0]];0 3]
sol:g over s
r:{flip reverse each x}
tflip:(`s#0 4!({x};flip))
to:{x[2] r/ tflip[x 2] tflip[4*x 1]m x 0}
/draw to check
raze each raze flip each (".#")(to'') sol
/peel borders off and draw
pm:{x[1+til 8;1+til 8]} each m
tp:{x[2] r/ tflip[x 2] tflip[4*x 1]pm x 0}
I:raze each raze flip each (tp'') sol
sm:"#"=("                  # ";"#    ##    ##    ###";" #  #  #  #  #  #   ")
smi:(cross/)(til count sm; til count first sm)
conv:smi +\:/: flip count[I] vs til count raze I
fsm:{sum sum[raze sm]= sum raze[sm] * flip x ./:/: conv}
min sum/[I]-sum[raze sm]*fsm each IS:raze r\[3;] each (I;flip I)


/day 21 
i:read0 `:d21.txt
m:"contains" vs/: i;ing:`$m[;0];al:m[;1];ing2:`$-1 _' " " vs/: string ing;
al:`$", " vs/: 1 _' -1 _' al;t:([]al;ing);
t:update id:i from ungroup t
t:ungroup update ing:`$-1 _' " " vs/: string ing from t
tt:select ing by al, id from t
kk:exec (inter/) ing by al from tt
/p1
count raze[ing2] except distinct raze kk
/p2
M:()!();f:{M[k]:v:x k:first where 1=count each x;x except\: v}
f over kk;
"," sv string raze {asc[key x]#x} M



