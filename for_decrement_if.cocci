@ decrement_with_if @
identifier v;
expression start;
type cast;
@@
- v = start;
  ...when != v 
     when exists
+ for ( v = start; v; --v ) {
- if ( \( v \| (cast)v \) )  {
- while (1) {
    ...
-   --v;
-   if (!( v )) { break; } }
- }
+ }
