node default {

	class {'puppet::agent':
		tag => 'bootstrap',
	}

	hiera_include('classes')
}
