node default {
	if $bootstrapped == 'false' {
		include hiera_array('bootstrapClasses', [])
		file {'/etc/bootstrapped':
			ensure => present,
			group => '0',
			owner => '0',
			mode => '0644',
		}
	} else {
		include hiera_array('classes', [])
	}
}
