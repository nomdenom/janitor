@ increment_by @
identifier v;
constant start;
expression limit;
expression increase;
binary operator compareop;
@@

- v = start;
  ...when != v 
     when exists
+ for ( v = start; v compareop limit; v += increase ) {
- while (1) {
    ...
-   v += increase;
    ... when != v
-   if (!(v compareop limit)) { break; } }
+ }
