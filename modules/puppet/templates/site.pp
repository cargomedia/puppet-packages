node default {
	if $bootstrapped == 'false' {
		$bootstrapClasses = hiera_array('bootstrapClasses', [])
		$bootstrapClasses.each {|$class| require $class }

		file {'/etc/bootstrapped':
			ensure => present,
			group => '0',
			owner => '0',
			mode => '0644',
		}
	} else {
		$classes = hiera_array('classes', [])
		$classes.each {|$class| require $class }
	}
}
