define helper::script ($content, $unless = 'false') {

Exec { path => ['/usr/local/bin', '/usr/bin', '/bin'], logoutput => true}

$filename = md5($title)
$dirname = "/tmp/${filename}"
$fileWithPath = "${dirName}/${filename}"

exec { "create_tmp_dir_and_executable":
	command => "mkdir -p ${dirname}",
	creates => $dirname,
	unless => $unless,
}

file { $fileWithPath:
	content => $content,
	mode => 755,
}

exec {"exec ${title}":
	cwd => $dirname,
	command => $fileWithPath,
	require => File[$fileWithPath],
	unless => $unless,
}

}
