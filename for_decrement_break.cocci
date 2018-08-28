@ decrement @
identifier v;
constant start;
constant decr;
@@
 for ( v = start;
+ /*SPACE*/ v >= 0
 ; v -= decr )
  {
    ...
-   if (!v) { break; }
  }