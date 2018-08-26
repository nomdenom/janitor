@ increment_fn @
expression e;
identifier fn;
identifier v;
@@
 e = fn(..., <+...
- v++
+ v /*JOIN*/
 ...+>, ...)
 ;
+ v++;

@ decrement_fn @
expression e;
identifier fn;
identifier v;
@@
 e = fn(..., <+...
- v--
+ v /*JOIN*/
 ...+>, ...)
 ;
+ --v;
