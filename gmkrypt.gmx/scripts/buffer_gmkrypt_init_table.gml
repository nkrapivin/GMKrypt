///buffer_gmkrypt_init_table(seed)

var _seed = argument0;

var _table, _tablesize;
_table = array_create(2);
_tablesize = 256;
_table[@ 1] = array_create(_tablesize);
_table[@ 0] = array_create(_tablesize);

var _a = 6 + (_seed mod 250);
var _b = floor(_seed / 250);
for (var _i = 0; _i < _tablesize; _i++) {
    array_set(_table[@ 0], _i, _i);
}

for (var _i = 0; _i < 10001; _i++) {
    var _j = 1 + ((_i * _a + _b) mod (_tablesize - 2));
    var _t = array_get(_table[@ 0], _j);
    array_set(_table[@ 0], _j, array_get(_table[@ 0], _j + 1));
    array_set(_table[@ 0], _j + 1, _t);
}

array_set(_table[@ 1], 0, 0);

for (var _i = 1; _i < _tablesize; _i++) {
    array_set(_table[@ 1], array_get(_table[@ 0], _i), _i);
}

return _table;
