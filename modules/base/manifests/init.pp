class base {

<<<<<<< HEAD
	require 'bash'
	require 'ssh'
	require 'postfix'
	require 'vim'
	require 'monit'
=======
  case $operatingsystem {
    Debian: {
      require 'apt::sources'
      require 'apt::cron-apt'
    }
  }
  require 'bash'
  require 'ssh'
  require 'postfix'
  require 'vim'
>>>>>>> f104f517d280b81afc737c306396abe5c83cdb56
}
