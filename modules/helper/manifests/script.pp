define helper::script ($content, $unless = false) {

	$scriptName = md5($title)
	$scriptFilename = "/tmp/script-${scriptName}"

	file { $scriptFilename:
		content => $content,
		mode => 755,
	}

	exec {"exec ${title}":
		command => "/tmp/script-${scriptName}",
		path => ['/usr/local/bin', '/usr/bin', '/bin'],
		require => File[$scriptFilename],
		unless => $unless,
	}
}
