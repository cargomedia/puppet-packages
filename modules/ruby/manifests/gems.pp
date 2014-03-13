class ruby::gems  {

  require 'ruby'

  if $::lsbdistid == 'Debian' and $::lsbmajdistrelease <= 6 {

    require 'unzip'
    $version = '1.6.2'

    helper::script { 'install gems':
      content => template('ruby/install-gems.sh'),
      unless => "which gem && gem --version | grep -P '^\\Q${version}\\E$'",
    }
  }
}
