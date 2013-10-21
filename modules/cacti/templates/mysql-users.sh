if (mysql -e "" 2>/dev/null); then
	mysql -e "UPDATE mysql.user SET password=PASSWORD('%MYSQL-ROOT-PASS%') WHERE user='root';"
	mysql -e "FLUSH PRIVILEGES;"
fi

function query {
	mysql --user=root --password=%MYSQL-ROOT-PASS% -ss -e "$1"
}

function setUser {
	if ! (query "SELECT user FROM mysql.user WHERE user='$1'" | grep -q "$1"); then
		query "CREATE USER '$1'@'$2' IDENTIFIED BY '$3';"
	fi
	query "UPDATE mysql.user SET password=PASSWORD('$3') WHERE user='$1' AND host='$2';"
}


setUser "debian-sys-maint" "localhost" "%MYSQL-MAINT-PASS%"
query "GRANT ALL ON *.* TO 'debian-sys-maint'@'localhost';"

setUser "replication" "%" "%MYSQL-REPLICATION-PASS%"
query "GRANT REPLICATION SLAVE ON *.* TO 'replication'@'%';"

setUser "%storage:CACTI-SENSE-DB-USER%" "%" "%storage:CACTI-SENSE-DB-PASSWD%"
query "GRANT PROCESS, SUPER, EVENT, TRIGGER ON *.* TO '%storage:CACTI-SENSE-DB-USER%'@'%';"

setUser "skadate" "%" "%MYSQL-USER-PASS%"
query "GRANT ALL ON skadate.* TO 'skadate'@'%';"
query "GRANT ALL ON skadate_test.* TO 'skadate'@'%';"

query "FLUSH PRIVILEGES;"
