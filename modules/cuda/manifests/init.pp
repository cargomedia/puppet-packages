class cuda (
  $version = '7.5-18'
){

  apt::source { 'cuda':
    entries => [
      "deb http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1504/x86_64",
    ],
    keys    => {
      elasticsearch => {
        key     => '5C37D3BE',
        key_url => 'http://developer.download.nvidia.com/compute/cuda/repos/GPGKEY',
      }
    }
  }

  package { 'cuda':
    ensure   => $version,
    provider => apt,
  }
}
