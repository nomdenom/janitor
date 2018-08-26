@ decrement @
identifier v;
constant start;
expression limit, e;
binary operator compareop;
@@
- v = start;
  ...when != v 
     when exists
+ for ( v = start; v; --v ) {
- while (1) {
    ...
-   --v;
-   if (!(v)) { break; } }
+ }
