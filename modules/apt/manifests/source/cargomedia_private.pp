class apt::source::cargomedia_private {

  require 'apt::transport_https'

  apt::source { 'cargomedia-private':
    entries => [
      "deb [arch=amd64] https://debian-packages-private.cargomedia.ch/ZijJtxgkSLjE5jzDG8KO7W9ljVxBrjr ${::lsbdistcodename} main",
    ],
    keys    => {
      'cargomedia-private' => {
        'key' => 'A0CFA7A8',
        'key_url' => 'https://debian-packages-private.cargomedia.ch/ZijJtxgkSLjE5jzDG8KO7W9ljVxBrjr/conf/signing.key',
      }
    },
  }
}
