UPDATE mysql.user SET Password=PASSWORD('<%= @rootPassword %>') WHERE User='root';
FLUSH PRIVILEGES;
