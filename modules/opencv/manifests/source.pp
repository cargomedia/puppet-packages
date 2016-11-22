class opencv::source (
  $version = '2.4.9'
){

  require 'git'
  require 'build'

  $tmp_directory = '/tmp/opencv'

  git::repository { 'opencv repository':
    remote      => 'https://github.com/opencv/opencv.git',
    directory   => $tmp_directory,
    revision    => $version,
  }
}
