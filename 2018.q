D6
c:flip "J"$ "," vs/: read0 `:d6.txt
p1
p:-100 + (cross/)til each 2#1000
max d where d[0N] > d:count each group {k:sum abs c-x;$[1=count r:where k=min k;first r; 0N]} each p
p2
sum 10000> {sum over abs c-x} each p

D7
/used views to solve dependency resolution
d7:read0 `:d7.txt
k:()!();i:0;k[i]:enlist[`];j:()
t:0!select asc distinct d by r from flip `d`r!flip d7[;5 36]
c:(asc `$string distinct (raze t[`d]) except t[`r]) set\: 1
t:`d xasc t upsert (string[c],\:enlist[""])
v:{x[0],"::",(";" sv string x[1]),";{i+::1;k[i]:x; j,::y;1}[`",("`" sv string x[1]),";`",x[0],"]"} each flip value flip select r, d from t
value each v
l:`$first t[`r] except raze t[`d]
get l
k

p1
d7:read0 `:d7.txt
t:flip `d`r!flip `$string d7[;5 36]
t: `id xkey update id:i from t upsert `,'distinct t[`d] except t[`r]
f:{[t;x]t:(select id from x)_t;$[count t; x,first 0!select[<r] from t where({all y in x}[x[`r]];d) fby r;x]}[t]
raze over string exec distinct r from (f/) enlist `id`d`r!(0N;`;`) 
p2
t:flip `d`r!flip `$string d7[;5 36]
t:select last s, d by r from update s:61+(`$'.Q.A)?r from t upsert `,'distinct t[`d] except t[`r]
f:{[T;done]	
	f:exec r from done where s=0; /finished steps
	T:delete from T where r in (exec r from done); /ignore ones we are working on
	a:select[<r] r,s from T where d {all x in y}\: f; /check which are available and sort
    update s:0|s-1 from done upsert (5-sum not exec s=0 from done) sublist a
	}
-1 + count f[t] scan `r xkey enlist `r`s!(`;0)

D8
d8:value first read0 `:d8.txt
p1
g:.[f:{[x;c;m;M]
	 $[0=count x;(x;c;m;M);
	 	0=0^first[c]; (k _ x;@[1 _ c;0;-;1];1_m;M,(k:0^first[m])#x);
	 	0=first x;((2+k)_x;@[c;0;-;1];m;M,(k:first 1_x)#2_x);
		(2_x;first[x],c;(first 1_x),m;M)]
		   }]
 sum last g over (d8;enlist[1];7h$();())
p2
g:.[f:{[x;c;m;M]
	 $[0=count x;(x;c;m;M);
	 	0=0^first[c]; (k _ x;@[1 _ c;0;-;1];1_m;(k:0^first[m])#x);
	 	0=first x;((2+k)_x;@[c;0;-;1];m;sum (k:first 1_x)#2_x);
		(2_x;first[x],c;(first 1_x),m;M)]
		   }]
s:1 _' (@[;3] each k) group count each @[;1] each k:g scan (2 3 1 1 0 2 7 8 1 1 1 0 1 99 2 1 1 2;enlist[1];7h$();())


















D9
p1
norm:{[x;c;n] k:(0;(c+2) mod count x) _ x; 
	c:first where n=r:raze (k[0];n;k[1]);
	 r:r where not null r;(r;c;n+1;0)};
s23:{[x;c;n] k:(0;(c-7) mod count x) _ x; r:raze (k[0];1 _ k[1]);
		(r;count k[0];n+1;n+first k[1])};
f:.[{[x;c;n;s]$[n mod 23;norm[x;c;n];s23[x;c;n]]}];
t:update p:i mod 428 from flip `x`c`n`s!flip   (f\)[70825;(enlist[0];0;1;0)]
`s xdesc select sum s by p from t

p2 
j:()
f:.[{[x;c;n;s]r:$[n mod 23;norm[x;c;n];s23[x;c;n]];j,::last r;r}]
(f/)[7082500;(enlist[0];0;1;0)]
t:update p:i mod 428 from ([]j)
`s xdesc select sum s by p from t
/batching
j:()
f:{[x;n]c:first k:-7 rotate {y,2 rotate x}/[x;n+(til 22)];j,::22+n+c;1 _ k}
f/[enlist[0];(1+23*til 70825 div 23)]
`j xdesc select sum j by p from update p:(23*i) mod 428 from ([]j)
 
/Using Embedpy for doubly linked lists 
\l anaconda/envs/py37/q/p.k
"p" "import numpy as np"
C:.p.import[`collections]
geta:.p.eval["lambda x: np.array(x)";<]
n:{a[`:rotate][-2];a[`:appendleft][x]}
pop:.p.eval["lambda x: x.popleft()";<]
s23:{a[`:rotate][7];pop[a]}
f:{n each x+til 22;22+x+s23[]}
a:C[`:deque][enlist[0]]
\t s:f each (1+23*til 7082500 div 23)
`s xdesc select sum s by p from update p:(23*i) mod 428 from ([]s)



D10
p1
\c 1100 1100
t:{`x`y`vx`vy!(last "<" vs x[0];first ">" vs x[1];last "<" vs x[1];first ">" vs x[2])} each "," vs/: d10:read0 `:advent/d10.txt
t:update value each x, value each y, value each vx, value each vy from t
f:.[{[t;s;c]m:max exec x+vx*s from t;$[c>m;(t;s+1;m);(t;s;c)]}]
s:-1+(f over (t;0;0W))[1]
p:update xplot:x+vx*s,yplot:y+vy*s from t
p:update xplot-abs min xplot, yplot-abs min yplot from p
V:flip" #" .[;;:;1b]/[(100 100#0b);flip p[`xplot`yplot]]
p2
s

D11
d11:7689
p1
t:([]x:1+til 300) cross ([]y:1+til 300)
pl:{[x;y] -5+"J"$last string div[ri*d11+y*ri:x+10;100]}
t:update `s#x,`g#y from `x`y xkey update p:pl'[x;y] from t
grid:{[x;y] ([]x:x+til 3) cross ([]y:y+til 3)}
`p xdesc t^sum each t each exec grid'[x;y] from t

p2
t2:delete x,y from `index xkey update index:`u#(x,'y) from t
grid2:{[x;y;z] if[(300<x+z)|(300<y+z);:0];sum exec p from t2 ([]index:(x + til z) cross (y+til z))}
s:{[g]max exec grid2'[x;y;g] from t}
r:s each d!d:1+til 30
size:first where r=max r
`power xdesc t ^ select size,power:grid2[;;size]'[x;y] from t


D12
p1
d12:read0 `:advent/d12.txt
x:1h$x where not 2=x:".#"?d12[0]
rule:`u#1h$5#'".#"? 2 _ d12
res:1h$last each ".#"? 2 _ d12
apply:rule!res
init:((count[x])#0b),(x),(count[x])#0b
sum neg[count x]+where {apply flip 2 1 0 -1 -2  xprev\: x}/[20;init]
p2
/trick is it crawls to right after a certain time step, which means we can just add the constant
init:(count[x]#0b),(x),(50*count[x])#0b
guess:1000
n:last count each res:where each {apply flip 2 1 0 -1 -2  xprev\: x}\[guess;init]
crawl:j first where all each 1=deltas res j:where n=count each res
sum (50000000000-crawl)+neg[count [x]]+where {apply flip 2 1 0 -1 -2  xprev\: x}/[crawl;init]

D13
d13:sample:read0 `:advent/d13samp.txt
d13:read0 `:advent/d13.txt
sm:{([]row:where count each i;col:raze i;val:raze x@'i:where each x<>0)} /sparse from matrix sparse.q
vert:update t:`v from sm d13 in "|^v"
horz:update t:`h from sm d13 in "-><"
rcurve:update t:`rc from sm "/" = d13
lcurve:update t:`lc from sm "\\"= d13
isec:update t:`isec from sm "+" = d13
map:`row`col xkey delete val from `row`col xasc update val:1b from (uj/) (vert;horz;rcurve;lcurve;isec)
trains:delete val from update tid:i,o:(1 2 3 4!`l`r`u`d) val,s:`l  from delete from (sm "*<>^v"? d13) where val=5
/ each train will move depending on it's orientation: 
/ this defines what section of track is next (position) 
orientToPos:{[x;y;oc] o:`u`d`r`l!((-1;0);(1;0);(0;1);(0;-1)); `row`col!(x;y)+ flip o[oc]}
/the type of track and it's current orientation and state, will give new orientation,new state
rules:([]t:`v`h`rc`lc`isec) cross ([]o:`u`d`r`l) cross ([]s:`l`s`r)
/remove impossible rules
rules:delete from rules where t=`v,o in `r`l
rules:delete from rules where t=`h,o in `u`d
/deal with the easy cases:
/if horizontal or vertical orientation doesn't change
rules:update no:o, ns:s from rules where t in `v`h
/if right curve
rules:update no:(`u`d`r`l!`r`l`u`d)o, ns:s from rules where t=`rc
/if left curve 
rules:update no:(`u`d`r`l!`l`r`d`u)o, ns:s from rules where t=`lc
/Intersection rules: new state is always ns + 1 mod 3
rules:update ns:`l`s`r[(1+(`l`s`r)?s) mod 3] from rules where t=`isec
/When in the left state, up and down behave like left curve and right and left behave like right curve
/ `u`d`r`l => `l`r`u`d
rules:update no:(`u`d`r`l!`l`r`u`d) o from rules where t=`isec, s=`l
/When in the right state, up and down behave like right curve and right and left behave like left curve
/ `u`d`r`l => `r`l`d`u
rules:update no:(`u`d`r`l!`r`l`d`u) o from rules where t=`isec, s=`r
/When in straight state orientation doesn't change while going through intersection
rules:update no:o from rules where t=`isec, s=`s
rules:`o`s`t xkey rules
/rules are built, now time to simulate:
/ we find the trains , advance them to next position and reorient them and check for crashes
/unfortunately advent is written by non APLers. 
/so, we have to also keep track of which row we are updating \unclear if we need to do column, 
/but it's easy to add / commented out
/so that a colision within one tick is caught -- UGLY
trains:update current:0b from trains
simul:{[trains]
	/check for collisions
	if[1<max count each group select col,row from trains;:trains];
	/calc which row we are up to:
	j:exec min row from trains where not current;
	c:select from trains where not current,row=j;
	/to do one row at a time
	/c:1#select from trains where not current;
	trains:update current:1b from trains where tid in c[`tid];
	/get new position and keep train id
	temp:c^flip exec orientToPos[row;col;o] from c;
	/get track info
	temp:temp lj map;
	/apply rules and return trains table 
	ntrains:select row, col, tid, o:no, s:ns, current:1b from temp lj rules;
	ntrains:ntrains uj delete from trains where tid in c[`tid];
	/when we have done all rows, we need to reset current and resort
	if[all exec current from ntrains;ntrains:`row`col xasc update current:0b from ntrains];
	:ntrains}

 select col,row from (simul over trains) where 1<(count;tid) fby (row,'col)

/We can visualize the results back this way
ms:{./[(1+max x)#" ";x:x[;`row`col];:;x`val]}
pic:`rc`lc`h`v`isec`r`l`d`u!"/}-|+><v^"
T:trains
A:{R:ms (select row,col,val:pic t from map) uj select row,col,val:pic o from T;`T set simul T;R}



p2
d13:read0 `:advent/d13samp2.txt
simul2:{[trains]
	/check if there is one train and it has not been looked at
	if[(1=count trains)&(1=count select from trains where not current);:trains];
	/remove collisions
	trains:delete from trains where 1<(count;tid) fby (row,'col);
	/to do one entry at a time
	c:1#select from trains where not current;
	trains:update current:1b from trains where tid in c[`tid];
	/get new position and keep train id
	temp:c^flip exec orientToPos[row;col;o] from c;
	/get track info
	temp:temp lj map;
	/apply rules and return trains table 
	ntrains:select row, col, tid, o:no, s:ns, current:1b from temp lj rules;
	ntrains:ntrains uj delete from trains where tid in c[`tid];
	/when we have done all rows, we need to reset current and resort
	if[all exec current from ntrains;ntrains:`row`col xasc update current:0b from ntrains];
	:ntrains}
trains:update current:0b from trains
simul2 over trains


