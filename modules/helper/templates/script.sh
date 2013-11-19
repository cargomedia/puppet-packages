<% require 'shellwords' %>
mkdir -p <%= @scriptDirname %> && \
cd <%= @scriptDirname %> && \
echo <%= @content.shellescape %> > <%= @scriptName %> && \
chmod +x <%= @scriptName %> && \
./<%= @scriptName %>