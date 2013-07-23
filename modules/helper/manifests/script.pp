define helper::script ($content, $unless = false) {

	$scriptName = md5($title)
	$scriptFilename = "/tmp/script-${scriptName}"

	unless $unless {

		file { $scriptFilename:
			content => $content,
			mode => 755,
		}

		exec {"exec ${title}":
			command => "/tmp/script-${scriptName}",
			cwd => "/tmp",
			path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
			require => File[$scriptFilename],
		}
	}
}
