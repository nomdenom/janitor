void ext(int p);

void test1(int p1) {
    int a;
    int b;
    int c;

    b = 1;
    a = p1;

    for (c = 0; c < 1; c++) {
        ext(a);
    }
}


void test2(int p1) {
    int d;
    int e;
    int f;

    e = 1;
    d = p1;

    for (c = 0; c < 1; c++) {
        ext(d);
        d = 3;
    }
}

void test3(int p1) {
    int g;
    int h;
    int i;

    g = 1;
    h = p1;

    for (c = 0; c < 1; c++) {
        h = 3;
        ext(h);
    }
}

voit test4(int p2) {
    int j, k;

    j = p2;
    k = 1;
    j = 123;
    ext(j);
}

