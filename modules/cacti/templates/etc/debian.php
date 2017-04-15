<?php
##
## database access settings in php format
## automatically generated from /etc/dbconfig-common/cacti.conf
## by /usr/sbin/dbconfig-generate-include
## Mon, 31 Oct 2011 14:08:15 +0100
##
## by default this file is managed via ucf, so you shouldn't have to
## worry about manual changes being silently discarded.  *however*,
## you'll probably also want to edit the configuration file mentioned
## above too.
##
$database_username='<%= @db_user %>';
$database_password='<%= @db_password %>';
$basepath='';
$database_default='<%= @db_name %>';
$database_hostname='<%= @db_host %>';
$database_port='<%= @db_port %>';
$dbtype='mysql';
