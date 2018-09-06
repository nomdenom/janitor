@ arr_sizeof @
identifier v;
expression start;
constant increment;
expression limit;
type cast;
@@
- v = &start;
  ...when != v 
     when exists
+ for ( v = &start; v < &limit; v += increment ) {
- while (1) {
    ...
-   v += increment;
    ... when != v
-   if (!((cast)v < (cast)&limit)) { break; } }
+ }


@ arr_ptr @
identifier v;
expression start;
expression limit, idx;
type cast;
@@
- v = start;
  ...when != v 
     when exists
+ for ( v = &start[0]; v < &limit[idx]; v++ ) {
- while (1) {
    ...
-   v++;
    ... when != v
-   if (!((cast)v < (cast)&limit[idx])) { break; } }
+ }
