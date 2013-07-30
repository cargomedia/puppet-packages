class apache2::mod::ssl () {

	apache2::mod {"ssl":
		configuration => template('apache2/mod/ssl.conf'),
	}
}
