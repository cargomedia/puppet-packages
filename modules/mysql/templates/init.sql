UPDATE mysql.user SET Password=PASSWORD('<%= @root_password %>') WHERE User='root';
UPDATE mysql.user SET Password=PASSWORD('<%= @debian_sys_maint_password %>') WHERE User='debian-sys-maint';
FLUSH PRIVILEGES;
