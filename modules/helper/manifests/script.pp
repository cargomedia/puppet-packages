define helper::script ($content, $unless) {

	$scriptName = md5($title)
	$scriptDirname = "/tmp/${scriptName}"
	$scriptFilename = "${scriptDirname}/${scriptName}"

	$contentQuoted = shellquote($content)

	exec {"exec ${title}":
		command => "mkdir -p ${scriptDirname} && echo ${contentQuoted} > ${scriptFilename} && chmod +x ${scriptFilename} && cd ${scriptDirname} && /bin/bash -ec '${scriptFilename}'",
		unless => $unless,
		path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
		logoutput => on_failure,
	}

	exec {"cleanup ${title}":
		command => "rm -rf ${scriptDirname}",
		onlyif => "test -d ${scriptDirname}",
		path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
		require => Exec["exec ${title}"],
	}
}
