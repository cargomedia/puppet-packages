class wowza (
  $version = '4.0.3',
  $license = 'EDEV4-Gj4jR-MW3BP-CtKh7-KGj8r-pnVym-7HjyUTUvPCFf',
  $admin_user = 'root',
  $admin_password = 'root'
) {

  require 'java::jre_headless'
  require 'ffmpeg'

  include 'wowza::service'

  user { 'wowza':
    ensure => present,
  }

  helper::script { 'install wowza':
    content => template("${module_name}/install.sh"),
    unless  => "dpkg-query -f '\${Status} \${Version}\n' -W wowzastreamingengine-${version} | grep -q 'ok installed ${version}'",
    timeout => 900,
    require => User['wowza'],
  }
  ->

  file {
    '/usr/local/WowzaStreamingEngine/lib/lib-versions':
      ensure => directory,
      owner  => 'wowza',
      group  => 'wowza',
      mode   => '0755';

    '/usr/local/WowzaStreamingEngine/conf/admin.password':
      ensure  =>file,
      content => template("${module_name}/admin.password"),
      owner   => '0',
      group   => '0',
      mode    => '0644',
      notify  => Service['wowza'];

    '/usr/local/WowzaStreamingEngine/conf/Server.license':
      ensure  => file,
      content => $license,
      owner   => '0',
      group   => '0',
      mode    => '0644',
      notify  => Service['wowza'];
  }
  ->

  sysvinit::script { 'wowza':
    content           => template("${module_name}/init"),
  }

  @monit::entry { 'wowza':
    content => template("${module_name}/monit"),
  }
}
