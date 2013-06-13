define script ($content, $unless = false, $onlyif = true) {

	if !$unless and $onlyif {

		$script = md5($content)

		file { "/tmp/script-${script}":
			content => $content,
			mode => 755,
		}
		->

		exec {'run script':
			command => "/tmp/script-${script}",
			path => ['/usr/local/bin', '/usr/bin', '/bin']
		}
	}
}
