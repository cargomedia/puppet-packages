define script ($content, $unless = false, $onlyif = true) {

	if !$unless and $onlyif {

		file { 'scriptfile':
			path => "/tmp/script",
			content => $content,
			mode => 755,
		}

		exec {'/tmp/script':
			path => ['/usr/local/bin', '/usr/bin', '/bin']
		}
	}
}
