node default {

  class { 'php5::extension::apcu':
    shm_size       => '12M',
    mmap_file_mask => '/tmp/foo.XXXXXX',
  }
}
