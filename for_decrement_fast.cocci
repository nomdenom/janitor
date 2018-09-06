@ decrement @
identifier v;
constant start;
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
