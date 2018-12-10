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
