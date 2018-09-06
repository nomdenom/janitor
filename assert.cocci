@ if_assert @
expression E;
expression list Args;
@@
- if ( E )
-    assertion_failed(Args);
+ assert(!E, Args);

@ double_not @
expression E;
@@
    assert(
- !! \( E \| (E) \)
+ E
    , ...);

@ not_equal @
expression E, E2;
@@
    assert(
- !(E != E2)
+ E == E2
    , ...);

@ equal @
expression E, E2;
@@
    assert(
- !(E == E2)
+ E != E2
    , ...);

@ greater disable all @
expression E, E2;
@@
    assert(
- !(E > E2)
+ E <= E2
    , ...);

@ ge disable all @
expression E, E2;
@@
    assert(
- !(E >= E2)
+ E < E2
    , ...);

@ less disable all @
expression E, E2;
@@
    assert(
- !(E < E2)
+ E >= E2
    , ...);

@ le disable all @
expression E, E2;
@@
    assert(
- !(E <= E2)
+ E > E2
    , ...);