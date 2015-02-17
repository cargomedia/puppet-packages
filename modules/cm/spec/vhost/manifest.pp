node default {

  require 'cm::application'

  $application_root = '/home/fuckbook/serve'

  $ssl_cert = '-----BEGIN CERTIFICATE-----
MIIC9TCCAd2gAwIBAgIJAIq90DIzpdxxMA0GCSqGSIb3DQEBBQUAMBExDzANBgNV
BAMMBmZvby5jbTAeFw0xNTAyMTcxMTE5NTdaFw0yNTAyMTQxMTE5NTdaMBExDzAN
BgNVBAMMBmZvby5jbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBANA1
HSXw+PokyUBru4N2o6WqslrTF8qNwEgAY+/fjOYMs8FVtDfWNofY6Wo8aOrdAwBO
p3hiCKOhulPSKOcK3PZgtmzRw/Lmq5ptoH48FaKi0qmNFI6K+MAGUa7/ntCR5KM0
FBpSpmZwVq9V5CWvfJgXEDhqG8SAQej4mYRR6bPVoeSEkhP8/Pc/TQm+5BeOy6O5
5/EK7IxBZ3ZxNosGqG4bJtmgNQlGQY7moAzx6WOtpZHLhAqW0tq5cI1dDsKWnjkQ
fX32zoKSl+7lov6CB5knpaHY59DhkZ0bVdp1wmH50MXhZQm2qrwsybzomIt6YjKW
A29sl1X80gJw2Hmxob0CAwEAAaNQME4wHQYDVR0OBBYEFHN3XYqQKvIbej0CMasY
KqAMHYy5MB8GA1UdIwQYMBaAFHN3XYqQKvIbej0CMasYKqAMHYy5MAwGA1UdEwQF
MAMBAf8wDQYJKoZIhvcNAQEFBQADggEBAF/0JCIuMJD4qZ48OWVcAcfeizAHMp1h
UIWidA2xL4biIgBWdNp181dVI6hnvJ3gWULqrz9K2ibatd3/5DnB60ypVMKB0dfx
XxUwsI+wuhcpccxmBwdyWE4NTQCxDMMBL5Y3I6keIndrewlzAWbUAASF3VkyaX1p
t+Et3dNpMJpAMgSMBV+Sm7HHZiQMWDVBrG+8UzshcfGAwz7rQ7b+GOz/nzN0cFHZ
uztJc/MYBpx1ZfCRwRk9aoPzvFGhO5q0aw5GSXRMUQr5TQzmqVZ6wfYZ89qCgoZV
So6BnByddaB9hyenpM+3OWIxeqgi7AIcZyknvgVwqyLAwXzYt0Ue6pE=
-----END CERTIFICATE-----'

  $ssl_key = '-----BEGIN RSA PRIVATE KEY-----
MIIEogIBAAKCAQEA0DUdJfD4+iTJQGu7g3ajpaqyWtMXyo3ASABj79+M5gyzwVW0
N9Y2h9jpajxo6t0DAE6neGIIo6G6U9Io5wrc9mC2bNHD8uarmm2gfjwVoqLSqY0U
jor4wAZRrv+e0JHkozQUGlKmZnBWr1XkJa98mBcQOGobxIBB6PiZhFHps9Wh5ISS
E/z89z9NCb7kF47Lo7nn8QrsjEFndnE2iwaobhsm2aA1CUZBjuagDPHpY62lkcuE
CpbS2rlwjV0OwpaeORB9ffbOgpKX7uWi/oIHmSelodjn0OGRnRtV2nXCYfnQxeFl
CbaqvCzJvOiYi3piMpYDb2yXVfzSAnDYebGhvQIDAQABAoIBAAmYKPuymwaL42pA
jKeGNAxSTV26FIKU/aNTwUcwegGv3CiwlllsWZ7w8/CdUAhintzIwxbdDaDctwVd
zdy3t27zDfT9xZXP42B+ZMLsaeLQtfxyL9xRsxzGLcVuqhbaYjrTD4oW/OwDiTsT
Liw+ZfNsPKcc3KK1dlQSAKEEVUygGkY99oLJboKfeDr1BskYaI1jKMxvmfIwRT0b
CjjaiKg9rb1xciJ6ebs0ZE5JW6PVfbxy4XFMVcpgpbd/PwHqLHNWRaI5DRc7vHnh
urmvc76zr3lRGw/NmSwPgXfy9AMizJIgIS+YPKb8hGO+GIDkh5YIEaApNHb3bsnV
zHRd4FECgYEA8FKJHj1BcvhBc768soR4YsicqIksqUKtR+KLbBQeKzjXdnWaP5dg
o++0bBLMniXp/myIYBfR0klM1JaCL5wb0kOOPi+M32GysKgDSGUIanObvvezPkd1
l0EV4sGaSm/HmS9JKnCGJmGoeAdlvRsP8KFcBocPexnSMJC2+XqETZsCgYEA3co/
itUKxasSoSPonY8WRRnd/q1YIIzdwC59wKPw1nzzKSzSy2gDGObmSs6acyachsTp
zc8EJaLZcZFj+9+DaX/1cyR68ifs0BUxTnFHph55aBsCXdi1eV8D9rQd7hr8VFTB
UKlYKud41/W5bVOBzI+Pdp2HGi+hKEmqazB774cCgYAPfUJZMJmHT3jofOKsnt0j
gMqYEj9OqX2BpJhX3vQS1RcOC4ZlktwntMtsK8oEZ20teNFRYDel1hOdoBXD+8vP
QYtpdqcdvq5FtI6BnAFu2wSuykhDO1fY59kBRHktUwcKWIHeumHrF2BEXDWyeowM
dln4EbxtsrxZZPpmGf9tAQKBgGjNQOlhcg2loM/0H98T1fohFv1Y++OlrMM7NMDq
tssjj+NNAu6K36vMr9V5exIelKg6NCDESblfElDP2ucR3w7jICCghFgY9ZX97aab
cLfWfpfq61tdI6OOelkBE4OHzOQsiIyM+NSNPFUQD+bRJux6idgK5+Q/zW80IAs2
hdnRAoGAf2QS8mvy8/eagaX7UD7iQKAFX/6tQINRmprAjuF6/fOmZ3MQu9Q5R0mS
2K80iiuvCic4L5VWuXqhFhYpRKQKuHWfB8hQNKWsEZR34GYPOnRCEse5eMq8Rt1r
inZL8VyT42eLzq/N4eyQ/Xxd7HR0gWmwu+o18FYcrZVbaF3+VyQ=
-----END RSA PRIVATE KEY-----'

  $domain = 'foo.cm'

  host { $domain:
    host_aliases => [ 'admin.foo.cm', 'www.foo.cm', 'origin-www.foo.cm', 'bar.cm' ],
    ip           => '127.0.0.1',
  }

  cm::vhost { "www.${domain}":
    path       => $application_root,
    ssl_cert   => $ssl_cert,
    ssl_key    => $ssl_key,
    aliases    => [ $domain, "admin.${domain}" ],
    cdn_origin => "origin-www.${domain}",
    redirect   => 'bar.cm',
  }
}
