@ r_ma @
type T;
identifier L;
expression E;
position Pdecl;
position Passigns;
assignment operator AOP;
@@
    T L@Pdecl;
<+... 
    L AOP@Passigns E 
...+>

@ script:python  @
Pdecl << r_ma.Pdecl;
Passigns << r_ma.Passigns;
L << r_ma.L;
@@
print L, len(Passigns)
if len(Passigns) > 1:
    cocci.include_match(False)
    print "FAIL!!!!"

@ r_remove  @
type T;
identifier L;
local idexpression P;
position r_ma.Pdecl;
postion PL;
@@
- T L@Pdecl;
... when exists
- L = P;
<+...
- L
+ P
...+>

