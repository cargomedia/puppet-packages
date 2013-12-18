UPDATE mysql.user SET Password=PASSWORD('<%= @root_password %>') WHERE User='root';
FLUSH PRIVILEGES;
