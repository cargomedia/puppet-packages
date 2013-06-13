define mountpoint (
	$device,
	$fstype,
	$options = 'defaults'
) {

	script {'mountpoint make-readyonly':
		content => template('mountpoint/make-readonly.erb')
	}

	mount {$title:
		device => $device,
		fstype => $fstype,
		ensure => mounted,
		options => $options
	}
}
