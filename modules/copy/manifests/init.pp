define copy ($file = $title, $module) {
	file { $file:
		source => "puppet:///modules/${module}${file}",
		ensure => present,
		recurse => true,
	}
}
