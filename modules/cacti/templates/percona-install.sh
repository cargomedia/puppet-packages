# Percona templates
PERCONA_VERSION='<%= @version %>'
if ! (grep -q 'version = "${PERCONA_VERSION}"' /usr/share/cacti/site/scripts/ss_get_mysql_stats.php && grep -q "version = '${PERCONA_VERSION}'" /usr/share/cacti/site/scripts/ss_get_by_ssh.php); then
	wget -q http://mysql-cacti-templates.googlecode.com/files/better-cacti-templates-${PERCONA_VERSION}.tar.gz
	unp better-cacti-templates-${PERCONA_VERSION}.tar.gz
	cd better-cacti-templates-${PERCONA_VERSION}
	cp scripts/ss_get_by_ssh.php /usr/share/cacti/site/scripts/
	cp scripts/ss_get_mysql_stats.php /usr/share/cacti/site/scripts/
	cp templates/*.xml /usr/share/cacti/templates-cargomedia/
fi