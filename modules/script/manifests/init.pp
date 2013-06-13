define script ($content, $unless = false, $onlyif = true) {

	if !$unless and $onlyif {

		$scriptName = md5($title)

		file { "/tmp/script-${scriptName}":
			content => $content,
			mode => 755,
		}
		->

		exec {"run script ${title}":
			command => "/tmp/script-${scriptName}",
			path => ['/usr/local/bin', '/usr/bin', '/bin']
		}
	}
}
