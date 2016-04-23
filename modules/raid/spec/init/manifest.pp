node default {

  require 'monit'

  class { 'raid':
    controllers => ['adaptec', 'sas2ircu', 'linux_md'],
  }

}
