class truecrypt(
  $version = '7.2'
) {

#  libopencryptoki-dev, libfuse-dev, wx ?, nasm
#oder libpkcs11-helper1-dev

#PKCS11_INC=/usr/include/pkcs11-helper-1.0/ make NOGUI=1 WXSTATIC=1

  #
  # Comment out in /Common/SecurityToken.cpp
  #
  # lines with CKR_NEW_PIN_MODE and  CKR_NEXT_OTP
  #

  helper::script {'install truecrypt':
    content => template("${module_name}/install.sh"),
    unless => "which truecrypt",
    timeout => 900,
    require => User['wowza'],
  }

}
