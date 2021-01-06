///buffer_gmkrypt_encrypt(buf,[seed])

var _buff = argument[0];
var _olds = buffer_tell(_buff);
buffer_seek(_buff, buffer_seek_start, 0);
var _bufs = buffer_get_size(_buff);
var _ints = buffer_sizeof(buffer_s32);
var _seed;

var _bill = irandom(3000) + 123;
var _fred = irandom(3000) + 231;
if (argument_count > 1) {
    _seed = argument[1];
}
else {
    _seed = irandom(25600) + 3328;
    if (_seed < 3328) {
        show_debug_message("GMKrypt: The seed is too small, expected <=3328");
    }
}

if (global._buffer_gmkrypt_verbose) {
    show_debug_message("GMKrypt: Encrypting...");
    show_debug_message("GMKrypt: Seed " + string(_seed));
    show_debug_message("GMKrypt: Bill " + string(_bill));
    show_debug_message("GMKrypt: Fred " + string(_fred));
}

// 3 - bill,fred,seed.
var _gmkb = buffer_create((_ints * 3) + (_bill * _ints) + (_fred * _ints) + _bufs, buffer_fixed, 1);

buffer_write(_gmkb, buffer_s32, _bill);
buffer_write(_gmkb, buffer_s32, _fred);

// Bill's junk.
repeat (_bill) {
    buffer_write(_gmkb, buffer_s32, irandom(3000));
}

// The seed.
buffer_write(_gmkb, buffer_s32, _seed);

// Fred's junk.
repeat (_fred) {
    buffer_write(_gmkb, buffer_s32, irandom(3000));
}

// Do the magic.
var _gmkt = buffer_gmkrypt_init_table(_seed);
var _tsiz = array_length_1d(_gmkt[0]);
buffer_write(_gmkb, buffer_u8, buffer_read(_buff, buffer_u8)); // the first byte is not encrypted.
repeat (_bufs - 1) {
    var _ipos = buffer_tell(_gmkb);
    var _inbt = buffer_read(_buff, buffer_u8);
    var _indx = (_inbt + _ipos) mod _tsiz;
    
    var _byte = array_get(_gmkt[0], _indx);
    buffer_write(_gmkb, buffer_u8, _byte);
}

buffer_seek(_buff, buffer_seek_start, _olds);
buffer_seek(_gmkb, buffer_seek_start, 0);

return _gmkb;
