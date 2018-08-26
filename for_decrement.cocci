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
    ... when != v
-   if (!( \(v \| v >= 0 \) )) { break; } }
+ }
