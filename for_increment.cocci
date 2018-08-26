@ increment @
identifier v;
constant start;
expression limit;
binary operator compareop;
@@
- v = start;
  ...when != v 
     when exists
+ for ( v = start; v compareop limit; v++ ) {
- while (1) {
    ...
-   v++;
    ... when != v
-   if (!(v compareop limit)) { break; } }
+ }

