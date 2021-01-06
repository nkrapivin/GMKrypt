///buffer_gmkrypt_decrypt(buff)

var _buff = argument0;
var _bufs = buffer_get_size(_buff);
var _olds = buffer_tell(_buff);
buffer_seek(_buff, buffer_seek_start, 0);

var _ints = buffer_sizeof(buffer_s32);
var _bill = buffer_read(_buff, buffer_s32);
var _fred = buffer_read(_buff, buffer_s32);

buffer_seek(_buff, buffer_seek_relative, _bill * _ints);
var _seed = buffer_read(_buff, buffer_s32);
buffer_seek(_buff, buffer_seek_relative, _fred * _ints);

if (global._buffer_gmkrypt_verbose) {
    show_debug_message("GMKrypt: Decrypting...");
    show_debug_message("GMKrypt: Seed " + string(_seed));
    show_debug_message("GMKrypt: Bill " + string(_bill));
    show_debug_message("GMKrypt: Fred " + string(_fred));
}

// output buffer size.
var _obfs = _bufs - buffer_tell(_buff);
var _outb = buffer_create(_obfs, buffer_fixed, 1);
// the first byte is never encrypted.
buffer_write(_outb, buffer_u8, buffer_read(_buff, buffer_u8));

var _gmkt = buffer_gmkrypt_init_table(_seed);
var _tsiz = array_length_1d(_gmkt[1]);

repeat (_obfs - 1) {
    var _ipos = buffer_tell(_buff);
    var _inbt = buffer_read(_buff, buffer_u8);
    var _byte = (array_get(_gmkt[1], _inbt) - _ipos) mod _tsiz;
    buffer_write(_outb, buffer_u8, _byte);
}

// Restore seek positions.
buffer_seek(_buff, buffer_seek_start, _olds);
buffer_seek(_outb, buffer_seek_start, 0);

return _outb;
