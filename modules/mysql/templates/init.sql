UPDATE mysql.user SET authentication_string=PASSWORD('<%= @root_password %>'), password_expired = 'N' WHERE User='root';
UPDATE mysql.user SET authentication_string=PASSWORD('<%= @debian_sys_maint_password %>'), password_expired = 'N' WHERE User='debian-sys-maint';
FLUSH PRIVILEGES;
