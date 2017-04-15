node default {

  $htpasswd = 'mypassword'

  $ssl_cert = '-----BEGIN RSA PRIVATE KEY-----
MIIEpgIBAAKCAQEAsm4YmILMCcrwTq5zf0EoWtYvljEqGA/8iDaYJb82zA1gBIZw
xqBI3Fqu7PUInjypVscRwB/0yTOEnPCD9D284OqVdjuO9ztH+Y3PuIJX259+Ztrv
xuJNB035gPF9lNKipI2wBohvHx8z8xUuaT88nZEES2yYEIfKL1IoQ3ZPTQlADX5U
ukUysoWChFMCCcXg25r+WeXVFItLZGPja5rSfFhlWdIGtGKyq0lxScqk8uijdmfs
M6soporDR3FPFQvckMcRtwkYy6XT1RV8+i5QZdjkUR7Ce6DV6anIDIYoE+2DAgxL
XBy5d4Gq6wHxJv1NMybqvzIuN85oOYpRgkSRdQIDAQABAoIBAQCKUXaXo61wWfV3
yRyXpXcXE7rH/0zWYm4tWcUQXe6ouCWa3G1ITLCuwU2hO0J3CCdtsdw8x4kG//zp
fDmOeN2WrcM3aGwnk7jz588DBWf+ROHD8iy2TG/SHcww/QOQ/sg+L+go6FLcGWA4
LE9SH0dqDiT6IzCuf9VoYZP82BYZbKqC2P6SRMsXltHlclH64LepC6orzkKca/Wq
JPdcJo/QAldOZRuZXSrjFXjMze8Wr1/soaoz/9/CWdbH69X0biarPqzWOydl/fxL
4z9tRUVjz+m4LxlKAb2rA2ydVq2xaImRKq2nkYX6jgvjuDXdOp0owVruzIfQam7O
d0vKmteBAoGBAOD2dSw+Owbp5tdCUmF7Tarkj6t9JbkFAbc3pWzCZ41BR28DJEpK
gx0XU71DZN0lej8TyhLVElTQM4EOISEJ42+rTPP6EXsI2XGM/3SJMeXFPigcN5TI
l41PLmybUE+gTeT58opuxewan7m8VpLWbnQa5OD6s0sa9TtJrBGjYbRNAoGBAMsM
IkkPZxU1B1noRG86oKvJmJmsMVVPYNp3ypHTUQAkvipRIjodCQYGxBR6yLnunZWG
d0bOwQoqlZ2FbceHhOzhGK6iYbVrDYQneeODXVpbKStOMc7w4SJ8HyAuGEL0eAlK
77G33p/908fF8FqjmQ4WeLkAivKG9TI2mtEQaoXJAoGBAN9ULIyolubNLArE343A
4CDoWKyRR/K+wq5GAubOtAhqJuVRRCSwhitKLiq1DhvxCcQ2/CPn/RPPwWG8Si1H
aM9CStnmhpYS+fMdW7kwPiXxwzwEjzUYUkPJuLe/FGKILOxFKoA9aiVzZN/51iRd
1jdTP6cNmxLTh2K9R6IXBXb9AoGBAMmr+p3AW613px6IkPg9LfqSWCxCGBnYpqU3
GA8w6SIQXIThYvJ/hkfjDnwc3CO4ufIaxXuhvaBgXYxAS6JDmyZACOjjRdMQSjN5
lhoAjwdAxipKFzSokaRTzgKDZfuSn2rzcBF/Q/J7BQ9GLY2JMmsIrM1rmZZ7ryw5
ihmeiX7pAoGBAIslpI2o+oGvqjddc+lLOe3lrIxQShsaDVktHCwUn2iXMk8houcZ
LwiklfHedEuNOfix8207LvTTYSp/EoA1z9wm6uXtnegAVPrT0A6yuwr7zJ/RcR8/
B8X0G6F1cCj4jGZ9c+cjDymcXq9K1i2M5wGPq82FsnkDEL4hmOx8J3Ld
-----END RSA PRIVATE KEY-----
-----BEGIN CERTIFICATE-----
MIIDajCCAlKgAwIBAgIJANgRfNiT89M4MA0GCSqGSIb3DQEBBQUAMCwxKjAoBgNV
BAMTIWNhY3RpLmZ1Y2tib29rLnN0YWdpbmcuY2FyZ29tZWRpYTAeFw0xMzExMTEx
NTIzMjhaFw0yMzExMDkxNTIzMjhaMCwxKjAoBgNVBAMTIWNhY3RpLmZ1Y2tib29r
LnN0YWdpbmcuY2FyZ29tZWRpYTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoC
ggEBALJuGJiCzAnK8E6uc39BKFrWL5YxKhgP/Ig2mCW/NswNYASGcMagSNxaruz1
CJ48qVbHEcAf9MkzhJzwg/Q9vODqlXY7jvc7R/mNz7iCV9uffmba78biTQdN+YDx
fZTSoqSNsAaIbx8fM/MVLmk/PJ2RBEtsmBCHyi9SKEN2T00JQA1+VLpFMrKFgoRT
AgnF4Nua/lnl1RSLS2Rj42ua0nxYZVnSBrRisqtJcUnKpPLoo3Zn7DOrKKaKw0dx
TxUL3JDHEbcJGMul09UVfPouUGXY5FEewnug1empyAyGKBPtgwIMS1wcuXeBqusB
8Sb9TTMm6r8yLjfOaDmKUYJEkXUCAwEAAaOBjjCBizAdBgNVHQ4EFgQUcixLit+i
rcXogXKwg22gwwluStwwXAYDVR0jBFUwU4AUcixLit+ircXogXKwg22gwwluStyh
MKQuMCwxKjAoBgNVBAMTIWNhY3RpLmZ1Y2tib29rLnN0YWdpbmcuY2FyZ29tZWRp
YYIJANgRfNiT89M4MAwGA1UdEwQFMAMBAf8wDQYJKoZIhvcNAQEFBQADggEBAF3g
C1edZwyCKtXSM2cK+1xTxhe7Rp4l+83uDxvqfncCCdoqgb97Hsf2sBC95110D6Rk
N+CTX8oO1oXd8n6/k/crOHT2EyXi/dF0j/WhpbKrWAW0AajBabwo2eEnW7adlRFi
sA6eN42Wtmd7mbR/1jm9DIowy1V0xfnRV96r6Gkp/E99s+68fQJPTWTjRSZfF7go
RHhHtlKEoAiuUlSoDfAjYIUW++mYBIhYTtUsKIsHqA5EqpnehJleEZax3uYV2vTe
Ms7TqpJmOcq6i3nUH8MF24379SibtRwhFz4vLEJupiVJ8feVvTEdhocKgLNfuop9
GlRKt+QNr/ePIOSy8nE=
-----END CERTIFICATE-----'

  class {'apt::update':
    before => Class['cacti::server'],
  }

  class {'cacti::server':
    hostname    => 'fuckbook.staging.cargomedia',
    db_host     => 'localhost',
    db_password => 'passwd',
    ssl_cert    => $ssl_cert,
    htpasswd    => $htpasswd,
  }
  ->

  class {'cacti::resource::bootstrap':
    deploy_dir        => '/home/fuckbook',
    db_sense_user     => 'sense-cacti',
    db_sense_password => 'sense-cacti',
  }
}
