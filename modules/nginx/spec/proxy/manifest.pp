node default {

  $ssl_cert = '-----BEGIN CERTIFICATE-----
MIIDZDCCAkygAwIBAgIJAJQrxIgzRNLSMA0GCSqGSIb3DQEBBQUAMCoxKDAmBgNV
BAMUHyouc3RyZWFtLmZ1Y2tib29rLmNpLmNhcmdvbWVkaWEwHhcNMTMwNTI0MTYw
NjA1WhcNMjMwNTIyMTYwNjA1WjAqMSgwJgYDVQQDFB8qLnN0cmVhbS5mdWNrYm9v
ay5jaS5jYXJnb21lZGlhMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
rVsHvygnfksSRWFVSULfqKo8+3RgXDMEY/QIRduP6dLcml8VVvoI+m0gBCLtw/ZD
rVy8QBdo9CWfnppS4WHEtVrUBOolXc6bnSWIjRVEY54yCip0HgjUdrvOLkOWpwF/
gxFTvH5sIcP0rQXMzml3C0kojuLQztfVnqK1csVxkSBI1Y7dUN+5aaBrg1XY+Qty
XQFP/Yk5Lc7jIsQP7giqyVvn5MzfPTubtVRZ+ei2WyvefShPKjzfWvQUy90xTc7O
7HGQ7YSfSYC9eHhMoB6FxJgtqf96Udo7BuFz5P/VEdkpA2sKhXuC9a5mXU2wQhHW
fhGKuthVk6ZRvjL//6oSwwIDAQABo4GMMIGJMB0GA1UdDgQWBBTLmR8xXzZRT3bi
QXbhmKYRW5h+SDBaBgNVHSMEUzBRgBTLmR8xXzZRT3biQXbhmKYRW5h+SKEupCww
KjEoMCYGA1UEAxQfKi5zdHJlYW0uZnVja2Jvb2suY2kuY2FyZ29tZWRpYYIJAJQr
xIgzRNLSMAwGA1UdEwQFMAMBAf8wDQYJKoZIhvcNAQEFBQADggEBAKVXjkoUOyvU
Q3Qd4lFGdrCJr5ML8UQV9hkkByi9fDEK9ZOi4QJ+JyIMPJNA/VxNFW18X2NSTWxM
pPfgJXeZP5dzc8VWFQvO9KhekWWdpzyYQfi01LL7mKEtucBwZyOsbyA2Or2ep6fE
7W6eCzwIpUflob2CVfXJ4t3VCMDZzO/vc6XMsfmPE57eia3COOVeOqawa4XuPpro
JbXrnFaNIAsqat/bZ4n9AK3g2kLHpSx3WAYeBJovfEQW3OT1RS6W7oikT0iYeGK+
kH9u0sHmJN8ulmXs6qcfsVoehrno2IviVvwZpsgSTlJ7nALafDTXc1HbBc8NtoIj
oX4YELeDBLA=
-----END CERTIFICATE-----'

  $ssl_key = '-----BEGIN RSA PRIVATE KEY-----
MIIEpQIBAAKCAQEArVsHvygnfksSRWFVSULfqKo8+3RgXDMEY/QIRduP6dLcml8V
VvoI+m0gBCLtw/ZDrVy8QBdo9CWfnppS4WHEtVrUBOolXc6bnSWIjRVEY54yCip0
HgjUdrvOLkOWpwF/gxFTvH5sIcP0rQXMzml3C0kojuLQztfVnqK1csVxkSBI1Y7d
UN+5aaBrg1XY+QtyXQFP/Yk5Lc7jIsQP7giqyVvn5MzfPTubtVRZ+ei2WyvefShP
KjzfWvQUy90xTc7O7HGQ7YSfSYC9eHhMoB6FxJgtqf96Udo7BuFz5P/VEdkpA2sK
hXuC9a5mXU2wQhHWfhGKuthVk6ZRvjL//6oSwwIDAQABAoIBADqAEaksf8daxhur
sQA8FQXyDQo+R5ZVkRG59GC+q14YzmE53RWw4v6/fKJotxv+KvCB7vUh8UUSvT7k
jTuJprwcnpfZ/Cof4tuxIteZaa7EX9aWZQENscUvs3BhVqGdG867NirR7uOmIReS
cX7mkEm6snkliZmDtI8IEXtdrelvEUO/kcgc98uPTJ7gzgmtWkeMFizC1vYu4nbN
z+tjuxIW7YH9+U35kNEZQ+5WAclLs/PPGkCFksmvZAmQ2RUxpeX/EViTGb/ZmOkv
DF79HucNeNnC44noZJ4qO1yjUjrildeQ5+HjuYcPLc1Mj+Ms84kLDB1vNWEFXqPQ
I3XvhuECgYEA3hSXQVQ2W46CpOF1BPOfrIoWKm2Z3OZDqOvJ1CVDa8PcXTFkSFTf
FTkRjii+m+1ikULTRkA7RciN1QAdVUYdljt41h8WWL7CadT028FmAqtME7ooJ9eJ
l5WW4rxC8yHCGpv4zVvv+dNLYbP2VSwiCl66WXKJlz80cZrKlL3kqRcCgYEAx9VI
qkw4w0vHJOBqMZFCDkZptvBGu/jy+y3aWMFGEwOffo8pHlbxKqOXyyCMffwZb0+w
IchBLfnnaPJawMf/EIGAZnMStgBbO6szLsZBon02ECE/ZHrTOakk3C4rmiUwMIDV
eBJObLgp03vkbBTQ1jFqHci1f/WWgPm0XI4uFzUCgYEArR5ACp0rApRFI2LdZc7E
WiwKu2hU2O5nL/cejlG+DPPRhJRMKFaA0Hp8ROVeMQ8MF1CQgeLwUaXVaoV8WE0g
I0yZFdGGCggqZXWsquJIMyx1Uat8QhKzH4ds57L6Pa3DMhsECJHysD0WNkOjcyHE
J3FQswmmWFDdAPI5mVmuNmECgYEAm+m4CU7xFsb/+LCzijr4W+TqRFaSCcVB52Iu
MwORJfK0tW0DOu3AunDrVQvvMbjJK4T0OldhK3sI52P4FOO2CW3Q/Z4Y4jHC/Pol
NABxY1LoJIucR0xhk2J6JORNFrafM6jBZS57S+4gjCXk4cMX8ZaaYeSgX9cAd17c
Lz6rjWUCgYEAvtoLmxjFfafuKoJsMFoMzzKJk92bosnQ+85c+3uD23tcjpNwaFbz
UEmQgwSdfYTu5DLSuey9YMI6m3kSohQzpmHRZoGwFwBGh/hsrNjkYZHtzGbNfhg5
z5jiDSPskspb8TxB7mD/QtGd/K2UAhECw0n+dET8t9mzsHp5aqYeyMs=
-----END RSA PRIVATE KEY-----'

  class { 'nginx':
    worker_processes      => 6,
    worker_rlimit_nofile  => 20000,
    worker_connections    => 10000,
    keepalive_timeout     => 30,
    access_log            => 'off',
  }

  nginx::resource::vhost { 'staging.cargomedia.ch':
    listen_port         => '8090',
    proxy               => 'http://backend-socketredis',
    ssl                 => true,
    ssl_port            => '8090',
    ssl_cert            => $ssl_cert,
    ssl_key             => $ssl_key,
    location_cfg_append => [
      'proxy_set_header X-Real-IP $remote_addr;',
      'proxy_set_header Host $host;',
      'proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;',
      'proxy_http_version 1.1;',
      'proxy_set_header Upgrade $http_upgrade;',
      'proxy_set_header Connection "upgrade";',
      'proxy_redirect off;',
      'proxy_buffering off;',
    ]
  }

  nginx::resource::upstream { 'backend-socketredis':
    members             => [
      'localhost:8096',
      'localhost:8097',
      'localhost:8098',
      'localhost:8099',
    ],
    upstream_cfg_append => [
      'ip_hash;',
    ],
  }
}
