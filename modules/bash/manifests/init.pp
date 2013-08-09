class bash ($prompt = '\u@\h:\w$ ') {

	$escapedPrompt = shellquote($prompt)

	file {'/etc/bash.bashrc':
		ensure => file,
		content => template('bash/bashrc'),
		owner => '0',
		group => '0',
		mode => '0644',
	}
}
