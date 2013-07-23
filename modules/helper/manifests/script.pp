define helper::script ($content, $unless = false) {

	$scriptName = md5($title)
	$scriptDirname = "/tmp/${scriptName}"
	$scriptFilename = "${scriptDirname}/${scriptName}"

	unless $unless {

		file { $scriptDirname:
			ensure => directory,
			group => 0, owner => 0, mode => 644,
		}

		file { $scriptFilename:
			content => $content,
			ensure => present,
			group => 0, owner => 0, mode => 755,
			require => File[$scriptDirname],
		}

		exec {"exec ${title}":
			command => "/bin/bash -ec '${scriptFilename}'",
			cwd => $scriptDirname,
			path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
			require => File[$scriptFilename],
		}

		exec {"cleanup ${title}":
			command => "rm -rf ${scriptDirname}",
			path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
			require => Exec["exec ${title}"],
		}
	}
}
