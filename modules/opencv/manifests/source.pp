class opencv::source (
  $version = '2.4.9'
){

  require 'git'
  require 'build'

  git::repository { 'opencv repository':
    remote      => 'https://github.com/opencv/opencv.git',
    directory   => '/tmp/opencv',
    revision    => $version,
  }
}
