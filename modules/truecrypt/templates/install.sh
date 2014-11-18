#!/bin/sh

curl http://cznic.dl.sourceforge.net/project/truecrypt/TrueCrypt/Other/TrueCrypt-<%= @version %>-source-unix.tar.gz > TrueCrypt-<%= @version %>-source-unix.tar.gz
tar -xzf TrueCrypt-<%= @version %>-source-unix.tar.gz
cd truecrypt-<%= @version %>-source
sleep 5
#patching according to http://polywogsys.livejournal.com/296576.html (and others)
sed -E 's/(TC_TOKEN_ERR) (\(CKR_NEW_PIN_MODE\)|\(CKR_NEXT_OTP\))/\/\/ \1 \2/g' Common/SecurityToken.cpp > t && mv t Common/SecurityToken.cpp

export PKCS11_INC=/usr/include/pkcs11-helper-1.0/ make NOGUI=1
mv Main/truecrypt /usr/local/sbin/
