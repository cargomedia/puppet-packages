<% require 'shellwords' -%>
#!/bin/bash -e

echo <%= Shellwords.escape @content %> > <%= @keypath %>
chmod 600 <%= @keypath %>
echo -n > <%= @ssh_dir %>/config
find <%= @ssh_dir %>/id.d/ -type f -not -name '*.pub' -exec echo IdentityFile \"{}\" >> <%= @ssh_dir %>/config \;
