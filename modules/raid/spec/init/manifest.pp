node default {

  class { 'raid':
    controllers => ['adaptec', 'sas2ircu', 'linux_md'],
  }

}
