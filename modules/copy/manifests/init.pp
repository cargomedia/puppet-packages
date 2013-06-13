define copy ($file = $title, $module, $template = false) {
	if $template {
		file { $file:
			content => template("${module}${file}.erb"),
			ensure => present,
		}
	} else {
		file { $file:
			source => "puppet:///modules/${module}${file}",
			ensure => present,
			recurse => true,
		}
	}
}
