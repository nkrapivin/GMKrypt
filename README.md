# GMKrypt
A GMKrypt implementation... in GML...

## Usage
```gml
// Let's imagine this is uh... your game?

///Saving
var saveBuffer = scr_save();
var bufferToSave = buffer_gmkrypt_encrypt(saveBuffer);
buffer_save(bufferToSave, "save.dat");
buffer_delete(bufferToSave);
buffer_delete(saveBuffer);

///Loading
var bufferToDecrypt = buffer_load("save.dat");
var actualBuff = buffer_gmkrypt_decrypt(bufferToDecrypt);
scr_load(actualBuff);
buffer_delete(actualBuff);
buffer_delete(bufferToDecrypt);
```

## Credits

IsmAvatar for this nice paper http://ismavatar.com/lgm/formats/gmkrypt1.html
