///buffer_gmkrypt_verbose(enable)

gml_pragma("global", "global._buffer_gmkrypt_verbose = false;");

var _oldval = global._buffer_gmkrypt_verbose;
global._buffer_gmkrypt_verbose = argument0;
if (global._buffer_gmkrypt_verbose) {
    show_debug_message("GMKrypt: Enabled verbose mode.");
}

return _oldval;
