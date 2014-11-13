RESPONSES="1\\nG\\nyes\\n\\n"

curl http://cznic.dl.sourceforge.net/project/truecrypt/TrueCrypt/Other/TrueCrypt-<%= @version %>-Linux-console-x64.tar.gz > TrueCrypt-<%= @version %>-Linux-console-x64.tar.gz
unp TrueCrypt-<%= @version %>-Linux-console-x64.tar.gz
echo $RESPONSES | ./truecrypt-<%= @version %>-setup-console-x64


PKCS11_INC=/usr/include/opencryptoki/ make NOGUI=1 WXSTATIC=1
